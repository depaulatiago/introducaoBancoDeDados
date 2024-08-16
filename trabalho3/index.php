<!DOCTYPE html>
<html>
<head>
    <title>Pokémon</title>
    <link rel="stylesheet" type="text/css" href="css/styles.css">
</head>
<body>
<center><h3>Pokémon</h3></center>
<form name="form1" method="POST" action="form_incluir.php">
<table border="0" align="center" width="80%">
<?php
include("./config.php");
$con = mysqli_connect('127.0.0.1', 'root', '', 'mydb');

// Verifica a conexão
if (!$con) {
    die("Falha na conexão: " . mysqli_connect_error());
}

// Ajuste na consulta SQL para ordenar por numPokedex
$sql = "SELECT p.idPokemon, p.numPokedex, p.nome, p.altura, p.peso, p.nivel, n.nomeNatureza 
        FROM Pokemon p 
        JOIN Natureza n ON p.Natureza_idNatureza = n.idNatureza 
        ORDER BY p.numPokedex"; // Ordenar por número da Pokédex
$tabela = mysqli_query($con, $sql);

if (mysqli_num_rows($tabela) == 0) {
?>
  <tr><td align="center">Não há nenhum Pokémon cadastrado.</td></tr>
  <tr><td align="center"><input type="submit" value="Incluir Pokémon"></td></tr>
<?php
} else {
?>
    <tr>
        <th>Número Pokédex</th>
        <th>Nome</th>
        <th>Altura</th>
        <th>Peso</th>
        <th>Nível</th>
        <th>Natureza</th>
        <th>Ações</th>
    </tr>
<?php
  while ($dados = mysqli_fetch_assoc($tabela)) {
?>
  <tr>
      <td><?php echo htmlspecialchars($dados['numPokedex']); ?></td>
      <td><?php echo htmlspecialchars($dados['nome']); ?></td>
      <td><?php echo htmlspecialchars($dados['altura']); ?></td>
      <td><?php echo htmlspecialchars($dados['peso']); ?></td>
      <td><?php echo htmlspecialchars($dados['nivel']); ?></td>
      <td><?php echo htmlspecialchars($dados['nomeNatureza']); ?></td>
      <td align="center">
        <input type="button" value="Excluir" onclick="location.href='excluir.php?idPokemon=<?php echo htmlspecialchars($dados['idPokemon']); ?>'">
        <input type="button" value="Editar" onclick="location.href='form_editar_pokemon.php?idPokemon=<?php echo htmlspecialchars($dados['idPokemon']); ?>'">
      </td>
  </tr>
<?php
  }
?>
<tr><td colspan="7" height="5"></td></tr>
<?php
mysqli_close($con);
?>
<tr><td colspan="7" align="center"><input type="submit" value="Incluir Novo Pokémon"></td></tr>
<?php
}
?>
</table>
</form>
</body>
</html>
