<!DOCTYPE html>
<html>
<head>
    <title>Inscription - Gestion de Courrier</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f5f5f5;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-image: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
        }

        .register-container {
            background-color: white;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
            text-align: center;
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 30px;
            font-size: 24px;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        input[type="text"],
        input[type="email"],
        input[type="password"] {
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            transition: border 0.3s;
            width: 100%;
        }

        input[type="text"]:focus,
        input[type="email"]:focus,
        input[type="password"]:focus {
            border-color: #3498db;
            outline: none;
        }

        input[type="submit"] {
            background-color: #2ecc71;
            color: white;
            padding: 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            transition: background-color 0.3s;
        }

        input[type="submit"]:hover {
            background-color: #27ae60;
        }

        .login-link {
            margin-top: 20px;
            color: #7f8c8d;
        }

        .login-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .logo {
            margin-bottom: 20px;
            font-size: 28px;
            font-weight: bold;
            color: #2c3e50;
        }
    </style>
</head>
<body>
    <div class="register-container">
    <div class="logo">Gestion de Courrier</div>
    <h2>Créer un compte</h2>
    <form action="/register" method="post">
        <input type="text" name="nom" placeholder="Nom complet" required>
        <input type="email" name="email" placeholder="Adresse email" required>
        <input type="password" name="mot_de_passe" placeholder="Mot de passe" required>

        <label for="role">Rôle :</label>
        <select name="role" id="role" required>
            <option value="" disabled selected>Choisir un rôle</option>
            <option value="utilisateur">Utilisateur</option>
            <option value="admin">Admin</option>
            <option value="DSIT">Service DSIT</option>
            <option value="SSARM">Service SSARM</option>
            <option value="Direction">Direction</option>
        </select>

        <input type="submit" value="S'inscrire">
    </form>
    <p class="login-link">Déjà un compte ? <a href="/login">Se connecter</a></p>
</div>

</body>
</html>
