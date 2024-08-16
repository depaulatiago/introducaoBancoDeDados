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

// Verificar se o parâmetro 'idPokemon' foi passado via GET
$idPokemon = isset($_GET['idPokemon']) ? $_GET['idPokemon'] : 0;

// Buscar informações do Pokémon para pré-preencher o formulário
$sql = "SELECT * FROM Pokemon WHERE idPokemon = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("i", $idPokemon);
$stmt->execute();
$result = $stmt->get_result();
$pokemon = $result->fetch_assoc();

// Buscar as naturezas disponíveis para o select
$sqlNaturezas = "SELECT idNatureza, nomeNatureza FROM Natureza";
$resultNaturezas = $conn->query($sqlNaturezas);
?>

<!DOCTYPE html>
<html>
<head>
    <title>Editar Pokémon</title>
    <style>
        /* Reset básico */
        body, h2, form, input, select, label {
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
            max-width: 600px; /* Ajustado para uma largura apropriada */
            margin: 20px auto;
            text-align: left; /* Alinhamento dos labels e inputs */
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
        input[type="submit"] {
            background-color: #f44336;
            border: none;
            border-radius: 5px;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
            margin-top: 10px;
        }

        input[type="submit"]:hover {
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

<h2>Editar Pokémon</h2>

<form action="atualizar_pokemon.php" method="post">
    <input type="hidden" name="idPokemon" value="<?php echo htmlspecialchars($pokemon['idPokemon']); ?>">
    
    <label for="numPokedex">Número da Pokédex:</label><br>
    <input type="number" id="numPokedex" name="numPokedex" value="<?php echo htmlspecialchars($pokemon['numPokedex']); ?>" required><br><br>
    
    <label for="nome">Nome:</label><br>
    <input type="text" id="nome" name="nome" value="<?php echo htmlspecialchars($pokemon['nome']); ?>" required><br><br>
    
    <label for="altura">Altura (em metros):</label><br>
    <input type="number" id="altura" name="altura" step="0.01" value="<?php echo htmlspecialchars($pokemon['altura']); ?>" required><br><br>
    
    <label for="peso">Peso (em quilogramas):</label><br>
    <input type="number" id="peso" name="peso" step="0.01" value="<?php echo htmlspecialchars($pokemon['peso']); ?>" required><br><br>
    
    <label for="nivel">Nível:</label><br>
    <input type="number" id="nivel" name="nivel" value="<?php echo htmlspecialchars($pokemon['nivel']); ?>" required><br><br>
    
    <label for="Natureza_idNatureza">Natureza:</label><br>
    <select id="Natureza_idNatureza" name="Natureza_idNatureza" required>
        <?php
        while ($row = $resultNaturezas->fetch_assoc()) {
            $selected = ($row['idNatureza'] == $pokemon['Natureza_idNatureza']) ? 'selected' : '';
            echo "<option value=\"" . htmlspecialchars($row['idNatureza']) . "\" $selected>" . htmlspecialchars($row['nomeNatureza']) . "</option>";
        }
        ?>
    </select><br><br>

    <input type="submit" value="Salvar Alterações">
</form>

</body>
</html>

<?php
// Fechar a conexão
$conn->close();
?>
