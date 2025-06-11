from bottle import request
from mysql.connector import get_db 

def get_courriers(user_id):
    db = get_db()
    cursor = db.cursor(dictionary=True)
    cursor.execute("""
        SELECT c.id, u.nom AS expediteur, c.sujet, c.message, c.date_envoi
        FROM courriers c
        JOIN utilisateurs u ON c.expediteur_id = u.id
        WHERE c.destinataire_id = %s
        ORDER BY c.date_envoi DESC
    """, (user_id,))
    courriers = cursor.fetchall()
    return courriers
