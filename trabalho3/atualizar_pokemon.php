<!DOCTYPE html>
<html>
<head>
    <title>Atualizar Pokémon</title>
    <style>
        /* Reset básico */
        body, h3, table, input, select {
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
        }

        /* Estilo do título */
        h3 {
            color: #f44336;
            font-size: 24px;
            margin: 20px 0;
        }

        /* Estilo do formulário */
        form {
            background: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 80%;
            max-width: 600px; /* Ajustado para uma largura apropriada */
            margin: 20px auto;
        }

        /* Estilo dos campos de entrada */
        input[type="number"], input[type="text"], select {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            width: calc(100% - 22px);
            margin-bottom: 10px;
            font-size: 16px;
        }

        /* Estilo dos botões */
        input[type="button"], input[type="submit"], button {
            background-color: #f44336;
            border: none;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin: 5px;
        }

        input[type="button"]:hover, input[type="submit"]:hover, button:hover {
            background-color: #d32f2f; /* Leve alteração de cor no hover */
        }

        /* Estilo dos labels */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            text-align: left;
        }
    </style>
</head>
<body>
    <center><h3>Atualizar Pokémon</h3></center>
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

    // Verificar se os dados do formulário foram enviados via POST
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Receber dados do formulário
        $idPokemon = $_POST['idPokemon'];
        $Natureza_idNatureza = $_POST['Natureza_idNatureza'];
        $numPokedex = $_POST['numPokedex'];
        $nome = $_POST['nome'];
        $altura = $_POST['altura'];
        $peso = $_POST['peso'];
        $nivel = $_POST['nivel'];

        // Prepara a instrução SQL para atualizar o Pokémon
        $sql = "UPDATE Pokemon 
                SET Natureza_idNatureza = ?, numPokedex = ?, nome = ?, altura = ?, peso = ?, nivel = ? 
                WHERE idPokemon = ?";

        $stmt = $conn->prepare($sql);

        if ($stmt) {
            // Vincula os parâmetros
            $stmt->bind_param("iissdii", $Natureza_idNatureza, $numPokedex, $nome, $altura, $peso, $nivel, $idPokemon);

            // Executa a instrução
            if ($stmt->execute()) {
                echo "<p>Informações do Pokémon atualizadas com sucesso!</p>";
                echo '<a href="index.php"><button type="button">Voltar para a Tela Principal</button></a>';
            } else {
                echo "<p>Erro ao atualizar Pokémon: " . $stmt->error . "</p>";
            }

            // Fecha a instrução
            $stmt->close();
        } else {
            echo "<p>Erro na preparação da instrução: " . $conn->error . "</p>";
        }
    }

    // Fechar a conexão
    $conn->close();
    ?>
</body>
</html>
