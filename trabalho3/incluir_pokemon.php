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
        echo "Novo Pokémon inserido com sucesso!";
        echo '<br><br><a href="index.php"><button type="button">Prosseguir</button></a>';
    } else {
        echo "Erro ao inserir Pokémon: " . $stmt->error;
    }

    // Fecha a instrução
    $stmt->close();
} else {
    echo "Erro na preparação da instrução: " . $conn->error;
}

// Fecha a conexão
$conn->close();
?>
