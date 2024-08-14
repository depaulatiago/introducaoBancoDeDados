SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS mydb DEFAULT CHARACTER SET utf8;
USE mydb;

-- -----------------------------------------------------
-- Table mydb.Natureza
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Natureza (
  idNatureza INT NOT NULL AUTO_INCREMENT,
  nomeNatureza VARCHAR(40) NOT NULL,
  PRIMARY KEY (idNatureza))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Tipos
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Tipos (
  idTipo INT NOT NULL AUTO_INCREMENT,
  nomeTipo VARCHAR(40) NOT NULL,
  PRIMARY KEY (idTipo))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.FormaDeEvoluir
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.FormaDeEvoluir (
  idFormaEvo INT NOT NULL AUTO_INCREMENT,
  nomeFormaEvo VARCHAR(40) NOT NULL,
  PRIMARY KEY (idFormaEvo))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.FormaDeAprender
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.FormaDeAprender (
  idFormaAprender INT NOT NULL AUTO_INCREMENT,
  nomeFormaAprender VARCHAR(40) NOT NULL,
  PRIMARY KEY (idFormaAprender))
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Movimento
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Movimento (
  idMovimento INT NOT NULL AUTO_INCREMENT,
  Tipos_idTipo INT NOT NULL,
  nome VARCHAR(40) NOT NULL,
  potencia INT NOT NULL,
  precisao INT NOT NULL,
  categoriaDoMovimento CHAR(1) NOT NULL,
  descricao VARCHAR(200) NOT NULL,
  PRIMARY KEY (idMovimento),
  INDEX fk_Movimento_Tipos1_idx (Tipos_idTipo ASC),
  CONSTRAINT fk_Movimento_Tipos1
    FOREIGN KEY (Tipos_idTipo)
    REFERENCES mydb.Tipos (idTipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Pokemon
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Pokemon (
  idPokemon INT NOT NULL AUTO_INCREMENT,
  Natureza_idNatureza INT NOT NULL,
  numPokedex INT NOT NULL,
  nome VARCHAR(40) NOT NULL,
  altura FLOAT NOT NULL,
  peso FLOAT NOT NULL,
  nivel INT NOT NULL,
  PRIMARY KEY (idPokemon),
  INDEX fk_Pokemon_Natureza1_idx (Natureza_idNatureza ASC),
  CONSTRAINT fk_Pokemon_Natureza1
    FOREIGN KEY (Natureza_idNatureza)
    REFERENCES mydb.Natureza (idNatureza)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Status
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Status (
  Pokemon_idPokemon INT NOT NULL,
  ataque INT NOT NULL,
  defesa INT NOT NULL,
  defesaEspecial INT NOT NULL,
  ataqueEspecial INT NOT NULL,
  velocidade INT NOT NULL,
  PRIMARY KEY (Pokemon_idPokemon),
  INDEX fk_Status_Pokemon1_idx (Pokemon_idPokemon ASC),
  CONSTRAINT fk_Status_Pokemon1
    FOREIGN KEY (Pokemon_idPokemon)
    REFERENCES mydb.Pokemon (idPokemon)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Pedra
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Pedra (
  idPedra INT NOT NULL AUTO_INCREMENT,
  nomePedra VARCHAR(40) NOT NULL,
  FormaDeEvoluir_idFormaEvo INT NOT NULL,
  PRIMARY KEY (idPedra),
  CONSTRAINT fk_Pedra_FormaDeEvoluir1
    FOREIGN KEY (FormaDeEvoluir_idFormaEvo)
    REFERENCES mydb.FormaDeEvoluir (idFormaEvo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Nivel
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Nivel (
  nivel INT NOT NULL,
  FormaDeAprender_idFormaAprender INT NOT NULL,
  PRIMARY KEY (FormaDeAprender_idFormaAprender),
  CONSTRAINT fk_Nivel_FormaDeAprender1
    FOREIGN KEY (FormaDeAprender_idFormaAprender)
    REFERENCES mydb.FormaDeAprender (idFormaAprender)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Disco
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Disco (
  idDisco INT NOT NULL AUTO_INCREMENT,
  nomeDisco VARCHAR(40) NOT NULL,
  FormaDeAprender_idFormaAprender INT NOT NULL,
  PRIMARY KEY (idDisco),
  CONSTRAINT fk_Disco_FormaDeAprender1
    FOREIGN KEY (FormaDeAprender_idFormaAprender)
    REFERENCES mydb.FormaDeAprender (idFormaAprender)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Treinador
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Treinador (
  nomeTreinador VARCHAR(40) NOT NULL,
  FormaDeAprender_idFormaAprender INT NOT NULL,
  PRIMARY KEY (FormaDeAprender_idFormaAprender),
  CONSTRAINT fk_Treinador_FormaDeAprender1
    FOREIGN KEY (FormaDeAprender_idFormaAprender)
    REFERENCES mydb.FormaDeAprender (idFormaAprender)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Deve_Possuir
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Deve_Possuir (
  Pokemon_idPokemon INT NOT NULL,
  Tipos_idTipo INT NOT NULL,
  PRIMARY KEY (Pokemon_idPokemon, Tipos_idTipo),
  INDEX fk_Pokemon_has_Tipos_Tipos1_idx (Tipos_idTipo ASC),
  INDEX fk_Pokemon_has_Tipos_Pokemon1_idx (Pokemon_idPokemon ASC),
  CONSTRAINT fk_Pokemon_has_Tipos_Pokemon1
    FOREIGN KEY (Pokemon_idPokemon)
    REFERENCES mydb.Pokemon (idPokemon)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pokemon_has_Tipos_Tipos1
    FOREIGN KEY (Tipos_idTipo)
    REFERENCES mydb.Tipos (idTipo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Pokemon_Aprende_Movimento_Atraves
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Pokemon_Aprende_Movimento_Atraves (
  Pokemon_idPokemon INT NOT NULL,
  Movimento_idMovimento INT NOT NULL,
  FormaDeAprender_idFormaAprender INT NOT NULL,
  PRIMARY KEY (Pokemon_idPokemon, Movimento_idMovimento, FormaDeAprender_idFormaAprender),
  INDEX fk_Pokemon_has_Movimento_Movimento1_idx (Movimento_idMovimento ASC),
  INDEX fk_Pokemon_has_Movimento_Pokemon1_idx (Pokemon_idPokemon ASC),
  INDEX fk_Pokemon_has_Movimento_FormaDeAprender1_idx (FormaDeAprender_idFormaAprender ASC),
  CONSTRAINT fk_Pokemon_has_Movimento_Pokemon1
    FOREIGN KEY (Pokemon_idPokemon)
    REFERENCES mydb.Pokemon (idPokemon)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pokemon_has_Movimento_Movimento1
    FOREIGN KEY (Movimento_idMovimento)
    REFERENCES mydb.Movimento (idMovimento)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Pokemon_has_Movimento_FormaDeAprender1
    FOREIGN KEY (FormaDeAprender_idFormaAprender)
    REFERENCES mydb.FormaDeAprender (idFormaAprender)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table mydb.Evolucao
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS mydb.Evolucao (
  numPokedexEvo INT NOT NULL,
  Pokemon_idPokemon INT NOT NULL,
  FormaDeEvoluir_idFormaEvo INT NOT NULL,
  nomePokemonEvo VARCHAR(40) NOT NULL,
  PRIMARY KEY (numPokedexEvo, Pokemon_idPokemon),
  INDEX fk_Evolucao_FormaDeEvoluir1_idx (FormaDeEvoluir_idFormaEvo ASC),
  INDEX fk_Evolucao_Pokemon1_idx (Pokemon_idPokemon ASC),
  CONSTRAINT fk_Evolucao_FormaDeEvoluir1
    FOREIGN KEY (FormaDeEvoluir_idFormaEvo)
    REFERENCES mydb.FormaDeEvoluir (idFormaEvo)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT fk_Evolucao_Pokemon1
    FOREIGN KEY (Pokemon_idPokemon)
    REFERENCES mydb.Pokemon (idPokemon)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
