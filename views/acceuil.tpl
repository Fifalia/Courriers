<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Boîte de réception - Gestion de Courrier</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" 
          integrity="sha512-papm0V0y0ZMyWzB0/j1NcYO46b9NNSNNzM0w1uQnl/5cABHZVFE7QTwWQwn5IvJXYJ54meIlLPQyWSC2n+UN5g==" 
          crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        body {
            background: #f7f9fc; 
            color: #2c3e50;
            padding: 20px;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        .container {
            max-width: 1100px;
            margin: 0 auto;
            background: #fff;
            border-radius: 10px;
            padding: 30px 40px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            font-size: 30px;
            font-weight: 700;
            color: #34495e;
            letter-spacing: 1.2px;
        }

        .card-actions {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
            margin-bottom: 40px;
        }

        .action-card {
            background-color: #ecf6ff;
            padding: 30px 20px;
            width: 250px;
            border-radius: 16px;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: #2c3e50;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
        }

        .action-card:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 25px rgba(0,0,0,0.2);
        }

        .action-card i {
            font-size: 36px;
            margin-bottom: 10px;
            color: #3498db;
        }

        .action-title {
            font-size: 18px;
            font-weight: 600;
            margin-top: 5px;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0 10px;
            margin-top: 10px;
        }

        th {
            background-color: #3498db;
            color: white;
            padding: 14px 20px;
            font-weight: 600;
            text-align: left;
            border-top-left-radius: 8px;
            border-top-right-radius: 8px;
        }

        td {
            background: #f9fbfd;
            padding: 14px 20px;
            color: #34495e;
            vertical-align: middle;
            border-bottom: 1px solid #dbe6f1;
            font-size: 15px;
            border-radius: 6px;
        }

        tr:nth-child(even) td {
            background-color: #eaf2f8;
        }

        tbody tr:hover td {
            background-color: #d6e9fb;
        }

        .message-cell {
            max-width: 280px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .top-bar {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 25px;
        }

        .logout-link {
            background-color: #e74c3c;
            color: white;
            padding: 11px 18px;
            border-radius: 8px;
            font-weight: 600;
            font-size: 14px;
            text-decoration: none;
            box-shadow: 0 5px 15px rgba(231,76,60,0.45);
            transition: background-color 0.3s ease;
        }

        .logout-link:hover {
            background-color: #c0392b;
            box-shadow: 0 6px 20px rgba(192,57,43,0.6);
        }

        .no-mails {
            text-align: center;
            font-size: 18px;
            color: #888;
            margin-top: 30px;
        }
    </style>
</head>
<body>
    <div class="top-bar">
        <a href="/logout" class="logout-link">
            <i class="fas fa-sign-out-alt"></i> Se déconnecter
        </a>
    </div>

    <div class="container">
        <h2>Gestion de Courriers</h2>

        <div class="card-actions">
            <div class="action-card" onclick="toggleInbox()">
                <i class="fas fa-inbox"></i>
                <div class="action-title">Boîte de réception</div>
            </div>
            <a href="/sent" class="action-card">
                <i class="fas fa-paper-plane"></i>
                <div class="action-title">Boîte d'envoi</div>
            </a>
            <a href="/send" class="action-card">
                <i class="fas fa-pen"></i>
                <div class="action-title">Envoyer un courrier</div>
            </a>
        </div>