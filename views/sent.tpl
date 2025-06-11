<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Boîte d'envoi - Gestion de Courrier</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" 
          integrity="sha512-papm0V0y0ZMyWzB0/j1NcYO46b9NNSNNzM0w1uQnl/5cABHZVFE7QTwWQwn5IvJXYJ54meIlLPQyWSC2n+UN5g==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        body {
            background-color: #f8f9fa;
            padding: 20px;
            color: #333;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        h2 {
            color: #2c3e50;
            margin-bottom: 25px;
            padding-bottom: 10px;
            border-bottom: 1px solid #eee;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 25px;
        }

        th {
            background-color: #3498db;
            color: white;
            padding: 12px 15px;
            text-align: left;
        }

        td {
            padding: 12px 15px;
            border-bottom: 1px solid #eee;
            vertical-align: top;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #f1f1f1;
        }

        .no-mails {
            color: #7f8c8d;
            font-style: italic;
            padding: 20px;
            text-align: center;
            background-color: #f9f9f9;
            border-radius: 4px;
            margin-top: 30px;
        }

        .actions {
            margin-bottom: 25px;
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
            font-weight: 500;
            border: none;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        .inbox-btn {
            background-color: #2980b9;
            color: white;
        }

        .inbox-btn:hover {
            background-color: #2471a3;
        }

        .send-btn {
            background-color: #2ecc71;
            color: white;
        }

        .send-btn:hover {
            background-color: #27ae60;
        }

        .logout-btn {
            background-color: #e74c3c;
            color: white;
        }

        .logout-btn:hover {
            background-color: #c0392b;
        }

        .message-cell {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Boîte d'envoi</h2>
        <div class="actions">
            <a href="/send" class="btn send-btn">
                <i class="fas fa-pen"></i> Envoyer un courrier
            </a>

            <a href="/logout" class="btn logout-btn">
                <i class="fas fa-sign-out-alt"></i> Se déconnecter
            </a>
        </div>

        % if courriers:
            <table>
                <tr>
                    <th>Destinataire</th>
                    <th>Sujet</th>
                    <th>Message</th>
                    <th>Fichier</th>
                    <th>Date d'envoi</th>
                </tr>
                % for c in courriers:
                    <tr>
                        <td>{{c['destinataire']}}</td>
                        <td>{{c['sujet']}}</td>
                        <td class="message-cell">{{c['message']}}</td>
                        <td>
            % if c.get('fichier'):
            <a href="/uploads/{{c['fichier']}}" target="_blank">Télécharger</a>
            % else:
            Aucun fichier
            % end
            </td>
                        <td>{{c['date_envoi']}}</td>
                    </tr>
                % end
            </table>
        % else:
            <div class="no-mails">
                <p>Aucun message envoyé.</p>
            </div>
        % end
    </div>
</body>
</html>
