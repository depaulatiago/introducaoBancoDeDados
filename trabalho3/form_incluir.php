<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Incluir Pokémon</title>
    <style>
        /* Reset básico */
        body, h2, form, label, input, select {
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

        /* Estilo do título */
        h2 {
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
            max-width: 800px;
            margin: 20px auto;
        }

        /* Estilo dos labels */
        label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            text-align: left;
        }

        /* Estilo dos inputs e selects */
        input[type="number"], input[type="text"], select {
            border: 1px solid #ccc;
            border-radius: 5px;
            padding: 10px;
            width: calc(100% - 22px);
            margin-bottom: 10px;
            font-size: 16px;
        }

        /* Estilo dos botões */
        input[type="submit"] {
            background-color: #f44336; /* Cor de fundo principal */
            border: none;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin: 10px 0;
        }

        input[type="submit"]:hover {
            background-color: #d32f2f; /* Leve alteração de cor no hover */
        }
    </style>
</head>
<body>

<h2>Incluir Novo Pokémon</h2>

<form action="incluir_pokemon.php" method="post">
    <label for="numPokedex">Número da Pokédex:</label><br>
    <input type="number" id="numPokedex" name="numPokedex" required><br><br>
    
    <label for="nome">Nome:</label><br>
    <input type="text" id="nome" name="nome" required pattern="[A-Za-zÀ-ÿ\s]+" title="O nome deve conter apenas letras e espaços."><br><br>
    
    <label for="altura">Altura (em metros):</label><br>
    <input type="number" id="altura" name="altura" step="0.01" required><br><br>
    
    <label for="peso">Peso (em quilogramas):</label><br>
    <input type="number" id="peso" name="peso" step="0.01" required><br><br>
    
    <label for="nivel">Nível:</label><br>
    <input type="number" id="nivel" name="nivel" required><br><br>
    
    <label for="Natureza_idNatureza">Natureza:</label><br>
    <select id="Natureza_idNatureza" name="Natureza_idNatureza" required>
        <?php
        // Conectar ao banco de dados
        $con = mysqli_connect('127.0.0.1', 'root', '', 'mydb');

        // Verificar a conexão
        if (!$con) {
            die("Falha na conexão: " . mysqli_connect_error());
        }

        // Buscar as naturezas disponíveis no banco de dados
        $sql = "SELECT idNatureza, nomeNatureza FROM Natureza";
        $result = mysqli_query($con, $sql);

        // Gerar opções do select para cada natureza
        while ($row = mysqli_fetch_assoc($result)) {
            echo "<option value=\"" . $row['idNatureza'] . "\">" . $row['nomeNatureza'] . "</option>";
        }

        // Fechar a conexão
        mysqli_close($con);
        ?>
    </select><br><br>

    <input type="submit" value="Incluir Pokémon">
</form>

</body>
</html>
