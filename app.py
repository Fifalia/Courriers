from bottle import Bottle, run, request, response, redirect, template, static_file
import mysql.connector
import hashlib
import os
import time

app = Bottle()

UPLOAD_FOLDER = 'uploads'

def get_db():
    return mysql.connector.connect(
        host="localhost",
        user="root",
        password="", 
        database="courrier_db"
    )

def hash_password(password):
    return hashlib.sha256(password.encode()).hexdigest()

@app.route('/')
def home():
    return redirect('/login')

@app.route('/register', method=['GET', 'POST'])
def register():
    if request.method == 'POST':
        nom = request.forms.get('nom')
        email = request.forms.get('email')
        mdp = hash_password(request.forms.get('mot_de_passe'))

        db = get_db()
        cursor = db.cursor()
        try:
            cursor.execute("INSERT INTO utilisateurs (nom, email, mot_de_passe) VALUES (%s, %s, %s)", (nom, email, mdp))
            db.commit()
            return redirect('/login')
        except mysql.connector.Error as e:
            return f"Erreur : {str(e)}"
    return template('register')

@app.route('/login', method=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.forms.get('email')
        mdp = hash_password(request.forms.get('mot_de_passe'))

        db = get_db()
        cursor = db.cursor(dictionary=True)
        cursor.execute("SELECT * FROM utilisateurs WHERE email = %s AND mot_de_passe = %s", (email, mdp))
        user = cursor.fetchone()
        if user:
            response.set_cookie("user_id", str(user['id']))
            return redirect('/inbox')
        else:
            return "Identifiants incorrects"
    return template('login')

@app.route('/send', method=['GET', 'POST'])
def send():
    user_id = request.get_cookie("user_id")
    if not user_id:
        return redirect('/login')

    db = get_db()
    cursor = db.cursor(dictionary=True)

    if request.method == 'POST':
        destinataire_email = request.forms.get('destinataire')
        sujet = request.forms.get('sujet')
        message = request.forms.get('message')
        upload = request.files.get('fichier')

        filename = None
        if upload and upload.filename:
            os.makedirs('./uploads', exist_ok=True)
            chemin_stockage = f"./uploads/{upload.filename}"
            if os.path.exists(chemin_stockage):
                base, ext = os.path.splitext(upload.filename)
                upload.filename = f"{base}_{int(time.time())}{ext}"
                chemin_stockage = f"./uploads/{upload.filename}"
            upload.save(chemin_stockage)
        else:
            upload = None

        # Recherche de l'id du destinataire
        cursor.execute("SELECT id FROM utilisateurs WHERE email = %s", (destinataire_email,))
        destinataire = cursor.fetchone()

        if not destinataire:
            return "Destinataire introuvable"

        # Insertion du courrier dans la base de données
        cursor.execute(
            "INSERT INTO courriers (expediteur_id, destinataire_id, sujet, message, fichier) VALUES (%s, %s, %s, %s, %s)",
            (user_id, destinataire['id'], sujet, message, upload.filename if upload else None)
        )
        db.commit()
        return redirect('/inbox')

    # Si ce n’est pas un POST, retourne le formulaire
    cursor.execute("SELECT email FROM utilisateurs")
    users = cursor.fetchall()

    return template('send', users=users)


    # Requête pour récupérer la liste des utilisateurs (emails)
    cursor.execute("SELECT email FROM utilisateurs")
    users = cursor.fetchall()

    # Requête pour récupérer la liste des services
    cursor.execute("SELECT nom FROM service")
    services = cursor.fetchall()

    # Requête pour récupérer la liste des directions
    cursor.execute("SELECT nom FROM direction")
    directions = cursor.fetchall()

    return template('send', users=users, services=services, directions=directions)

@app.route('/inbox')
def inbox():
    user_id = request.get_cookie("user_id")
    if not user_id:
        return redirect('/login')

    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.id, u.nom AS expediteur, c.sujet, c.message, c.date_envoi, c.fichier
        FROM courriers c
        JOIN utilisateurs u ON c.expediteur_id = u.id
        WHERE c.destinataire_id = %s
        ORDER BY c.date_envoi DESC
    """, (user_id,))
    courriers = cursor.fetchall()
    return template('inbox', courriers=courriers)

@app.route('/statut/<nouveau_statut>/<id:int>')
def changer_statut(nouveau_statut, id):
    if nouveau_statut not in ['lu', 'non lu', 'distribué']:
        return "Statut invalide"
    conn = mysql.connector.connect(
        host="localhost",
        user="root",
        password="",
        database="courrier_db"
    )
    cur = conn.cursor()
    cur.execute("UPDATE courriers SET statut = %s WHERE id = %s", (nouveau_statut, id))
    conn.commit()
    conn.close()

    return redirect("/inbox")

@app.route('/edit/<id:int>')
def edit_courrier_form(id):
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='courrier_db'
    )
    cursor = conn.cursor(dictionary=True)

    cursor.execute("SELECT * FROM courriers WHERE id = %s", (id,))
    courrier = cursor.fetchone()

    cursor.close()
    conn.close()

    if courrier is None:
        return "Courrier non trouvé"

    print(courrier)

    return template('edit_form', courrier=courrier)



@app.route('/delete/<id:int>')
def delete_courrier(id):
    # Connexion à la base MySQL
    conn = mysql.connector.connect(
        host='localhost',
        user='root',
        password='',
        database='courrier_db'
    )
    cursor = conn.cursor(dictionary=True)

    # Récupérer le nom du fichier associé au courrier
    cursor.execute("SELECT fichier FROM courriers WHERE id = %s", (id,))
    result = cursor.fetchone()

    # Supprimer le fichier s'il existe
    if result and result['fichier']:
        filepath = os.path.join(UPLOAD_FOLDER, result['fichier'])
        if os.path.exists(filepath):
            os.remove(filepath)

    # Supprimer le courrier de la base de données
    cursor.execute("DELETE FROM courriers WHERE id = %s", (id,))
    conn.commit()

    cursor.close()
    conn.close()

    # Rediriger vers la boîte de réception après suppression
    return redirect('/inbox')

@app.route('/uploads/<filename>')
def serve_file(filename):
    return static_file(filename, root='./uploads', download=filename)

@app.route('/sent')
def sent():
    user_id = request.get_cookie("user_id")
    if not user_id:
        return redirect('/login')

    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.id, u.nom AS destinataire, c.sujet, c.message, c.date_envoi, c.fichier
        FROM courriers c
        JOIN utilisateurs u ON c.destinataire_id = u.id
        WHERE c.expediteur_id = %s
        ORDER BY c.date_envoi DESC
    """, (user_id,))
    courriers = cursor.fetchall()
    return template('sent', courriers=courriers)



@app.route('/logout')
def logout():
    response.delete_cookie("user_id")
    return redirect('/login')

if __name__ == '__main__':
    run(app, host='localhost', port=8080, debug=True, reloader=True)
