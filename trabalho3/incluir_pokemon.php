<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado da Inclusão</title>
    <style>
        /* Reset básico */
        body, h2, p, a, button {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        /* Estilização do corpo da página */
        body {
            font-family: Arial, sans-serif;
            background: #f0f0f0;
            color: #333;
            text-align: center;
            margin: 20px;
            padding: 20px;
        }

        /* Estilo do contêiner da mensagem */
        .message-container {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 80%;
            max-width: 800px;
            margin: 20px auto;
        }

        /* Estilo da mensagem de sucesso */
        .success-message {
            color: #242221; /* Verde para sucesso */
            font-size: 20px;
            margin-bottom: 20px;
        }

        /* Estilo da mensagem de erro */
        .error-message {
            color: #f44336; /* Vermelho para erro */
            font-size: 20px;
            margin-bottom: 20px;
        }

        /* Estilo do botão */
        button {
            background-color: #f44336; /* Cor de fundo principal */
            border: none;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 20px;
        }

        button:hover {
            background-color: #d32f2f; /* Leve alteração de cor no hover */
        }

        /* Estilo do link */
        a {
            text-decoration: none;
        }
    </style>
</head>
<body>

<div class="message-container">
    <?php
    // Conectar ao banco de dados
    $servername = "localhost";
    $username = "root";
    $password = "";
    $dbname = "mydb";

    $conn = new mysqli($servername, $username, $password, $dbname);

    // Verificar a conexão
    if ($conn->connect_error) {
        die("Falha na conexão: " . $conn->connect_error);
    }

    // Receber dados do formulário
    $Natureza_idNatureza = $_POST['Natureza_idNatureza'];
    $numPokedex = $_POST['numPokedex'];
    $nome = $_POST['nome'];
    $altura = $_POST['altura'];
    $peso = $_POST['peso'];
    $nivel = $_POST['nivel'];

    // Prepara a instrução SQL
    $sql = "INSERT INTO Pokemon (Natureza_idNatureza, numPokedex, nome, altura, peso, nivel) 
            VALUES (?, ?, ?, ?, ?, ?)";

    $stmt = $conn->prepare($sql);

    if ($stmt) {
        // Vincula os parâmetros
        $stmt->bind_param("iissdi", $Natureza_idNatureza, $numPokedex, $nome, $altura, $peso, $nivel);

        // Executa a instrução
        if ($stmt->execute()) {
            echo "<p class='success-message'>Novo Pokémon inserido com sucesso!</p>";
            echo '<a href="index.php"><button type="button">Prosseguir</button></a>';
        } else {
            echo "<p class='error-message'>Erro ao inserir Pokémon: " . $stmt->error . "</p>";
        }

        // Fecha a instrução
        $stmt->close();
    } else {
        echo "<p class='error-message'>Erro na preparação da instrução: " . $conn->error . "</p>";
    }

    // Fecha a conexão
    $conn->close();
    ?>
</div>

</body>
</html>
