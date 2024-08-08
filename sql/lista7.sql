-- 1- Selecione o endereço e o salario do funcionário de nome ‘Luciana S. Santos’.
select *
from Funcionario
where nomeFunc = 'Luciana S. Santos'
-- 2-Selecione o nome e o salário dos funcionários que nasceram entre os anos de 1960 e
--1969, inclusive, do sexo feminino e que ganham menos de 1000.
 select nomeFunc, salario
 from Funcionario
 where sexo = 'F' and salario < 1000 and dataNasc >= '1960/01/01' and dataNasc <=
'1969/12/31'
-- 3. Selecione o nome dos dependentes do funcionário de nome ‘João B. Silva’.
 select d.nomeDep
 from Funcionario f
 JOIN Dependente d ON f.idFunc = d.idFunc
 WHERE f.nomeFunc = 'João B. Silva';
-- 4. Selecione o nome dos projetos que o funcionário de nome ‘Frank T. Santos’ trabalha.
 SELECT p.nomeProj
 FROM Funcionario f
 JOIN Trabalha t ON f.idFunc = t.idFunc
 JOIN Projeto p ON t.idProj = p.idProj
 WHERE f.nomeFunc = 'Frank T. Santos';
-- 5. Selecione o nome dos funcionários que trabalham em projetos controlados pelo
--departamento de nome ‘ Construção’.
 SELECT DISTINCT f.nomeFunc
 FROM Funcionario f
 JOIN Trabalha t ON f.idFunc = t.idFunc
 JOIN Projeto p ON t.idProj = p.idProj
 JOIN Departamento d ON p.idDepto = d.idDepto
 WHERE d.nomeDepto = 'Construção';
-- 6. Selecione o nome dos funcionários supervisionados pelo funcionário de nome ‘Frank
--T.Santos’.
SELECT f2.nomeFunc
FROM Funcionario f1
JOIN Funcionario f2 ON f1.idFunc = f2.idSuperv
WHERE f1.nomeFunc = 'Frank T. Santos';
-- 7. Selecione o nome e endereço dos funcionários que não tem nenhum dependente.
SELECT nomeFunc, endereco
FROM Funcionario f
WHERE NOT EXISTS (
SELECT 1
FROM Dependente d
WHERE d.idFunc = f.idFunc
);
-- 8. Selecione o nome dos funcionários que trabalham no departamento de nome ‘Pesquisa’ ou
-- que trabalham no projeto de nome ‘N. Benefícios’.
SELECT DISTINCT f.nomeFunc
FROM Funcionario f
JOIN Departamento d ON f.idDepto = d.idDepto
LEFT JOIN Trabalha t ON f.idFunc = t.idFunc
LEFT JOIN Projeto p ON t.idProj = p.idProj
WHERE d.nomeDepto = 'Pesquisa' OR p.nomeProj = 'N. Benefícios';
-- 9. Selecione o nome dos funcionários que trabalham em algum projeto controlado pelo
--departamento cujo gerente é o funcionário de nome ‘Júnia B. Mendes’
SELECT DISTINCT f.nomeFunc
FROM Funcionario f
JOIN Trabalha t ON f.idFunc = t.idFunc
JOIN Projeto p ON t.idProj = p.idProj
JOIN Departamento d ON p.idDepto = d.idDepto
WHERE d.idGerente = (
SELECT idFunc
FROM Funcionario
WHERE nomeFunc = 'Júnia B. Mendes'
);

-- 4. Selecione o nome dos projetos que o funcionário de nome ‘Frank T. Santos’ trabalha.
-- SELECT p.nomeProj
-- FROM Funcionario f
-- JOIN Trabalha t ON f.idFunc = t.idFunc
-- JOIN Projeto p ON t.idProj = p.idProj
-- WHERE f.nomeFunc = 'Frank T. Santos';

-- 11. Selecione o nome dos funcionários e o nome de seus dependentes. Deve incluir o nome dos
-- funcionários sem dependentes.
-- Select f.nomeFunc, d.nomeDep
-- From Funcionario f
-- left Join Dependente d On f.idFunc = d.idFunc

-- 12. Selecione a quantidade de funcionários que trabalham no departamento que controla o projeto
-- de nome ‘ProdZ’.
-- Select	Count(*)
-- From Funcionario f
-- Join Departamento d on f.idDepto = d.idDepto
-- Join Projeto p on d.idDepto = p.idDepto
-- WHERE p.nomeProj = 'ProdZ';


-- 13. Selecione o nome dos funcionários e a quantidade de projetos que cada um trabalha mais de 10
-- horas.
-- Select f.nomeFunc, count(f.nomeFunc)
-- From Funcionario f
-- Join Trabalha t on f.idFunc = t.idFunc    
-- where numHoras > '10.0'
-- Group by nomeFunc

-- 14. Selecione o nome dos funcionários e a quantidade de projetos que cada um trabalha. Selecione
-- apenas os funcionários que trabalham em mais de um projeto.
-- select idFunc, nomeFunc, count(*)
-- from Funcionario natural join Trabalha
-- group by idFunc, nomeFunc
-- having count(*) > 1;

-- 15. Selecione a soma dos salários dos funcionários que trabalham em departamentos que controlam
-- mais de um projeto. O resultado deve vir agrupado por departamento.
-- select idDepto, nomeDepto, sum(salario)
-- from Funcionario natural join Departamento D
-- where D.idDepto in (select idDepto
 --                    from Projeto
-- 	            group by idDepto
 --                    having count(*) > 1)
-- group by idDepto, nomeDepto;

-- 16. Selecione o nome dos funcionários que ganham mais que o maior salário dos funcionários do
-- departamento de nome ‘Construção’. O resultado deve vir ordenado alfabeticamente pelo nome.
-- select nomeFunc
-- from Funcionario
-- where salario > (select max(salario)
-- 		 from Funcionario natural join Departamento
--                  where nomeDepto = 'Construção')
-- order by nomeFunc;

-- 17. Selecione o nome do funcionário e o nome do seu supervisor para todos os funcionários que
-- não são supervisionados pelo funcionario de nome 'Frank T. Santos'.
-- select F.nomeFunc, S.nomeFunc
-- from Funcionario F left outer join Funcionario S on S.idFunc = F.idSuperv
-- where S.nomeFunc != 'Frank T. Santos' or F.idSuperv is null;

-- 18. Aumente em 10% o salários de todos os funcionários que trabalham em mais de um projeto.
-- update Funcionario
-- set salario = salario * 1.10
-- where idFunc in (select idFunc
-- 		 from Trabalha
 --                 group by idFunc
 --                 having count(*) > 1);


-- 19. Exclua todos os projetos que não têm funcionários trabalhando neles.
-- delete from Projeto
-- where idProj not in (select idProj
-- from Trabalha);

-- 20. Crie uma visão que selecione, para cada departamento, sua identificação, seu nome, mais o
-- nome e o salário de seu gerente. Depois, mostre também exemplos de como usar a visão criada.
-- create view DeptoGerente as
-- select D.idDepto, nomeDepto, nomeFunc, salario
-- from Departamento D join Funcionario F on D.idGerente = F.idFunc;
-- 
-- select * from DeptoGerente;
-- 
-- select nomeDepto, nomeFunc, nomeProj
-- from DeptoGerente natural join Projeto;


-- 21. Crie um stored-procedure para reajustar o salário dos funcionários de um determinado
-- departamento. A identificação do departamento e o percentual de reajuste são passados como
-- parâmetros. Depois, mostre exemplos de uso do stored-procedure.
--DELIMITER // 
CREATE PROCEDURE ReajustaSalario(IN pIdDepto INT, IN percReajuste DECIMAL(5,2)) 
BEGIN 
   UPDATE Funcionario
   SET salario = salario + (salario * percReajuste / 100)
   WHERE idDepto = pIdDepto; 
END 
--DELIMITER ; 

SELECT nomeFunc, salario, idDepto
FROM Funcionario
ORDER BY idDepto;

CALL ReajustaSalario(1, 10);

SELECT nomeFunc, salario, idDepto
FROM Funcionario
ORDER BY idDepto;

CALL ReajustaSalario(2, 20);

SELECT nomeFunc, salario, idDepto
FROM Funcionario
ORDER BY idDepto;


-- 22. Crie um stored-procedure para adicionar um funcionário a um projeto. A identificação do
-- funcionário, a identificação do projeto e o número de horas trabalhadas são passados como
-- parâmetros. Depois, mostre exemplos de uso do stored-procedure.
-- DELIMITER // 
CREATE PROCEDURE AdicionaFuncProj (IN pIdFunc INT, IN pIdProj INT, IN pNumHoras DECIMAL(6,1)) 
BEGIN
   INSERT INTO Trabalha (idFunc, idProj, numHoras)
   VALUES (pIdFunc, pIdProj, pNumHoras);
END // 
DELIMITER ; 

SELECT * FROM Trabalha
ORDER BY idFunc, idProj;

CALL AdicionaFuncProj(1,3,3);
CALL AdicionaFuncProj(1,10,1.5);

SELECT * FROM Trabalha
ORDER BY idFunc, idProj;


-- 23, 24, 25, 26 Um funcionário não pode ter um salário maior do que o do seu supervisor. Implemente essa
-- restrição por meio de um conjunto de triggers. Depois, mostre exemplos de disparo dos triggers.
-- DROP PROCEDURE ComparaSalarioFuncSupervisor;
-- Cria um procedure auxiliar, pois o mesmo código vai ser usado pelos triggers de INSERT e UPDATE
DELIMITER // 
CREATE PROCEDURE ComparaSalarioFuncSupervisor (IN pSalarioFunc DECIMAL(8,2), IN pIdSuperv INT) 
BEGIN
   -- Obtém o salário do supervisor
   DECLARE vSalarioSupervisor DECIMAL(8,2);
   SELECT salario INTO vSalarioSupervisor
   FROM Funcionario
   WHERE idFunc = pIdSuperv;
   -- Compara salário do funcionário com o do seu supervisor
   IF pSalarioFunc > vSalarioSupervisor THEN
      SIGNAL SQLSTATE '45000'
	  SET MESSAGE_TEXT = 'O salário do funcionário não pode ser maior do que o do seu supervisor.';
   END IF;
END // 
DELIMITER ; 

-- DROP TRIGGER after_Funcionario_insert;
-- Cria trigger de INSERT
DELIMITER //
CREATE TRIGGER after_Funcionario_insert
BEFORE INSERT ON Funcionario
FOR EACH ROW
BEGIN
   CALL ComparaSalarioFuncSupervisor(NEW.salario, NEW.idSuperv);
END //
DELIMITER ;

-- DROP TRIGGER after_Funcionario_update;
-- Cria trigger de UPDATE
DELIMITER //
CREATE TRIGGER after_Funcionario_update
BEFORE UPDATE ON Funcionario
FOR EACH ROW
BEGIN
   CALL ComparaSalarioFuncSupervisor(NEW.salario, NEW.idSuperv);
END //
DELIMITER ;

-- mostra salário do supervisor (idFunc = 1)
SELECT idFunc, nomeFunc, salario
FROM Funcionario
WHERE idFunc = 1;

-- insere novo funcionario com salário maior do que seu supervisor (idFunc = 1)
INSERT INTO Funcionario
VALUES (9,'Juliana A. Mendes','R. Bahia, 111','1990-11-25','F',2000,1,2);
-- funcionário não foi inserido
SELECT *
FROM Funcionario
WHERE idFunc = 9;

-- insere novo funcionario com salário menor do que seu supervisor (idFunc = 1)
INSERT INTO Funcionario
VALUES (9,'Juliana A. Mendes','R. Bahia, 111','1990-11-25','F',490,1,2);
-- funcionário foi inserido
SELECT *
FROM Funcionario
WHERE idFunc = 9;

-- atualiza o salário do funcionário idFunc = 9 tornando-o maior do que o do seu supervisor
UPDATE Funcionario
SET salario = 2000
WHERE idFunc = 9;
-- salário não foi atualizado
SELECT *
FROM Funcionario
WHERE idFunc = 9;

-- atualiza o salário do funcionário idFunc = 9, porém com um valor menor do que o do seu supervisor
UPDATE Funcionario
SET salario = 495
WHERE idFunc = 9;
-- salário foi atualizado
SELECT *
FROM Funcionario
WHERE idFunc = 9;

------------
Executar UPDATE e DELETE quando a condição na WHERE não inclui uma chave:
SET SQL_SAFE_UPDATES = 0; -- desliga o "Safe Update Mode" temporariamente
SET SQL_SAFE_UPDATES = 1; -- liga o "Safe Update Mode"

