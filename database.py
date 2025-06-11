import mysql.connector
from mysql.connector import Error

def get_db():
    """
    Cette fonction retourne une connexion à la base de données MySQL.
    Si la connexion échoue, elle renvoie None.
    """
    try:
        db = mysql.connector.connect(
            host="localhost",            # L'hôte de ton serveur MySQL
            user="root",                 # L'utilisateur MySQL (par défaut root)
            password=" ", # Remplace par ton mot de passe
            database="courrier_db"       # Le nom de ta base de données
        )
        if db.is_connected():
            print("Connexion réussie à la base de données")
        return db
    except Error as e:
        print(f"Erreur de connexion à la base de données : {e}")
        return None

def close_db(db):
    """
    Cette fonction ferme la connexion à la base de données.
    """
    if db.is_connected():
        db.close()
        print("Connexion fermée")
