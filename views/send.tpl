<!DOCTYPE html>
<html>
<head>
    <title>Envoyer un courrier - Gestion de Courrier</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            display: flex;
            justify-content: center;
            padding: 40px 20px;
        }

        .container {
            background-color: white;
            width: 100%;
            max-width: 800px;
            padding: 40px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 25px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        label {
            font-weight: 500;
            color: #2c3e50;
        }

        select, input[type="text"], textarea {
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
            transition: all 0.3s;
        }

        select:focus, input[type="text"]:focus, textarea:focus {
            border-color: #3498db;
            outline: none;
            box-shadow: 0 0 0 2px rgba(52, 152, 219, 0.2);
        }

        textarea {
            min-height: 200px;
            resize: vertical;
        }

        input[type="submit"] {
            background-color: #3498db;
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s;
            align-self: flex-start;
        }

        input[type="submit"]:hover {
            background-color: #2980b9;
        }

        .actions {
            margin-top: 40px;
            display: flex;
            gap: 15px;
        }

        .actions a {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .inbox-link {
            background-color: #f39c12;
            color: white;
        }

        .inbox-link:hover {
            background-color: #d35400;
        }

        .logout-link {
            background-color: #e74c3c;
            color: white;
        }

        .logout-link:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Envoyer un courrier</h2>
        <form action="/send" method="post" enctype="multipart/form-data">
    <label for="destinataire">Destinataire (email) :</label>
    <input type="email" name="destinataire" required>

    <label for="sujet">Sujet :</label>
    <input type="text" name="sujet" required>

    <label for="message">Message :</label>
    <textarea name="message" required></textarea>

    <label for="fichier">Joindre un fichier :</label>
    <input type="file" name="fichier">

    <button type="submit">Envoyer</button>
</form>
        <div class="actions">
            <a href="/inbox" class="inbox-link">Voir les courriers reçus</a>
            <a href="/logout" class="logout-link">Se déconnecter</a>
        </div>
    </div>
</body>
</html>