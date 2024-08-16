<?php
// Configurações de conexão com o banco de dados
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'mydb';

// Cria a conexão com o banco de dados
$conn = new mysqli($host, $username, $password, $database);

// Verifica se a conexão foi bem-sucedida
if ($conn->connect_error) {
    die("Falha na conexão: " . $conn->connect_error);
}

// Mensagem inicial
$message = "";

// Verifica se o parâmetro 'idPokemon' foi passado via GET
if (isset($_GET['idPokemon'])) {
    $idPokemon = $_GET['idPokemon'];

    // Prepara a instrução SQL para excluir o Pokémon
    $sql = "DELETE FROM Pokemon WHERE idPokemon = ?";

    // Prepara a instrução usando o objeto de conexão $conn
    if ($stmt = $conn->prepare($sql)) {
        // Vincula o parâmetro $idPokemon à instrução SQL
        $stmt->bind_param("i", $idPokemon);

        // Executa a instrução
        if ($stmt->execute()) {
            $message = "Pokémon excluído com sucesso!";
        } else {
            $message = "Erro ao excluir Pokémon: " . $stmt->error;
        }

        // Fecha a instrução
        $stmt->close();
    } else {
        $message = "Erro ao preparar a instrução: " . $conn->error;
    }
} else {
    $message = "ID do Pokémon não foi especificado.";
}

// Fecha a conexão com o banco de dados
$conn->close();
?>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Excluir Pokémon</title>
    <style>
        /* Reset básico */
        body, .message, .button {
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

        /* Estilo da mensagem */
        .message {
            margin-bottom: 20px;
            font-size: 16px;
        }

        /* Estilo dos botões */
        .button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            color: white;
            background-color: #f44336; /* Cor de fundo principal */
            border: none;
            border-radius: 5px;
            text-decoration: none;
            text-align: center;
        }

        .button:hover {
            background-color: #d32f2f; /* Leve alteração de cor no hover */
        }
    </style>
</head>
<body>
    <div class="message">
        <?php echo htmlspecialchars($message); ?>
    </div>
    <a href="index.php" class="button">Prosseguir para a Tela Principal</a>
</body>
</html>
