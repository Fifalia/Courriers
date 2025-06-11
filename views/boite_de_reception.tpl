<!DOCTYPE html>
<html>
<head>
    <title>Boîte de Réception</title>
</head>
<body>
    <h2>Courriers reçus</h2>

    % if courriers:
        <table border="1">
            <tr>
        <th>Expéditeur</th>
        <th>Sujet</th>
        <th>Message</th>
        <th>Fichier</th> <!-- Ajout -->
        <th>Date</th>
    </tr>
            % for c in courriers:
                <tr>
                    <td>{{c.expediteur}}</td>
                    <td>{{c.sujet}}</td>
                    <td>{{c.message}}</td>
                    <td>{{c.date_envoi}}</td>
                </tr>
            % end
        </table>
    % else:
        <p>Aucun courrier reçu.</p>
    % end
        <p><a href="/logout">Se déconnecter</a></p>
</body>
</html>