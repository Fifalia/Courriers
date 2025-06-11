<!DOCTYPE html>
<html>
<head>
    <title>Modifier le courrier</title>
    <style>
        .container {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        label {
            display: block;
            margin-top: 15px;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], textarea, input[type="file"] {
            width: 100%;
            padding: 8px;
            box-sizing: border-box;
            margin-top: 5px;
        }
        button {
            margin-top: 20px;
            padding: 10px 15px;
            background-color: #007bff;
            border: none;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }
        button:hover {
            background-color: #0056b3;
        }
        .actions {
            margin-top: 20px;
        }
        .actions a {
            margin-right: 15px;
            text-decoration: none;
            color: #007bff;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Modifier le courrier</h2>
        <form action="/edit/{{courrier['id']}}" method="post" enctype="multipart/form-data">
            <label for="destinataire">Destinataire (email) :</label>
            <input type="email" name="destinataire" value="{{courrier['destinataire']}}" required>

            <label for="sujet">Sujet :</label>
            <input type="text" name="sujet" value="{{courrier['sujet']}}" required>

            <label for="message">Message :</label>
            <textarea name="message" rows="5" required>{{courrier['message']}}</textarea>

            <label for="fichier">Joindre un fichier (laisser vide pour garder le fichier actuel) :</label>
            <input type="file" name="fichier">

            <button type="submit">Enregistrer</button>
        </form>

        <div class="actions">
            <a href="/inbox" class="inbox-link">Voir les courriers reçus</a>
            <a href="/logout" class="logout-link">Se déconnecter</a>
        </div>
    </div>
</body>
</html>
