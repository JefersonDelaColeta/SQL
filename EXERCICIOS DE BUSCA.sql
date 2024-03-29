-- SELECT DE TODOS OS FILMES COM ANO ANTERIOR A 2000


select *
from FILME
where ANO_FILME <2000

-- SELECT DE FILMES ENTRE 2005 E 2010

SELECT *
FROM FILME
WHERE ANO_FILME BETWEEN 2005 AND 2010

--SELECT DE FILMES ONDE CONTEM RAMBO NA COLUNA NOME_ORIGINAL_FILME

SELECT *
FROM FILME 
WHERE NOME_ORIGINAL_FILME LIKE '%RAMBO%'

--01 - SELECIONAR TODOS OS DIRETORES

SELECT *
FROM  DIRETOR

--02 - SELECIONAR TODOS OS ATORES

SELECT *
FROM ATOR

--03 - SELECIONAR TODOS OS GENEROS

SELECT *
FROM GENERO

--04 - SELECIONAR TODOS OS FILMES, EXCLU�DOS, OU N�O 

SELECT *
FROM FILME 


--05 - SELECIONAR OS DIRETORES EM ORDEM DE NOME 

SELECT *
FROM DIRETOR
ORDER BY NOME_DIRETOR

--06 - SELECIONAR OS ATORES EM ORDEM DE C�DIGO

SELECT *
FROM ATOR
ORDER BY ID_ATOR

--07 - SELECIONAR OS GENEROS EM ORDEM DECRESCENTE DO NOME

SELECT *
FROM GENERO
ORDER BY NOME_GENERO DESC

--08 - SELECIONAR O ANO, O NOME ORIGINAL, O NOME EM PORTUGU�S E O C�DIGO IMDB DOS FILMES

SELECT NOME_ORIGINAL_FILME, ANO_FILME, NOME_FILME, ID_IMDB_FILME
FROM FILME 


--09 - SELECIONAR O NOME ORIGINAL DO FILME, O NOME DO DIRETOR, OS NOMES DOS ATORES E O NOME DOS G�NEROS


SELECT NOME_ORIGINAL_FILME, NOME_DIRETOR, NOME_ATOR, NOME_GENERO
FROM FILME, DIRETOR, ATOR, GENERO

--10 - SELECIONAR TODOS OS G�NEROS COM AS QUANTIDADES DE FILMES DE CADA UM

SELECT GENERO.NOME_GENERO, COUNT(FILME_GENERO.ID_FILME) AS QNTD 
FROM GENERO
JOIN FILME_GENERO
ON FILME_GENERO.ID_GENERO = GENERO.ID_GENERO
GROUP BY GENERO.ID_GENERO, GENERO.NOME_GENERO
ORDER BY QNTD DESC

---SELECT COM TODOS OS FILMES DOS ANOS 2010,2012 E 2014

SELECT *
FROM FILME
WHERE ANO_FILME = 2010 OR ANO_FILME = 2012 OR ANO_FILME = 2014


---- SELECIONAR TODOS OS FILMES MAIS ANTIGOS DO ALIEN, OU SEJA, ONDE O ANO � MENOR QUE 2000 E TODOS OS FILMES NOVOS DO HIGHLANDER, OU SEJA, ONDE O ANO � POSTERIOR A 2000

SELECT *
FROM FILME 
WHERE ANO_FILME <2000 AND NOME_FILME LIKE '%ALIEN%' OR (ANO_FILME > 2000 AND NOME_FILME LIKE '%HIGHLANDER%')

--11 - SELECIONAR TODOS OS ANOS DOS FILMES, COM AS QUANTIDADES DE FILMES DE CADA UM, ORDENADO DO ANO MAIS RECENTE PARA O MAIS ANTIGO


SELECT ANO_FILME, COUNT(*) AS QNTD
FROM FILME
GROUP BY ANO_FILME
ORDER BY ANO_FILME DESC 

--11,5 - SELECIONAR TODOS OS ANOS DOS FILMES, COM AS QUANTIDADES DE FILMES DE CADA UM, ORDENADO DO ANO MAIS RECENTE PARA O MAIS ANTIGO, POREM RETORNAR APENAS OS ANOS QUE TIVEREM MAIS DE 5 FILMES


SELECT *
FROM(
SELECT ANO_FILME, COUNT (ID_FILME) AS QNT  
FROM FILME
GROUP BY ANO_FILME
) AS RESULT 
WHERE RESULT.QNT > 5 
ORDER BY ANO_FILME DESC

--12 - SELECIONAR TODOS OS FILMES DE ANOS COM MAIS DE 3 FILMES

SELECT *
FROM (
SELECT ANO_FILME, COUNT(ID_FILME) AS QNTD
FROM FILME
group by ANO_FILME
) AS RESULT 
WHERE RESULT.QNTD >3


--13 - SELECIONAR TODOS OS DIRETORES QUE FIZERAM MAIS DE UM FILME

SELECT *
FROM FILME
WHERE ID_DIRETOR IN (SELECT ID_DIRETOR
FROM (
SELECT ID_DIRETOR,
COUNT(ID_FILME) AS QTDE
FROM FILME
GROUP BY ID_DIRETOR
) AS RESULT
WHERE RESULT.ID_DIRETOR > 1)


--14 - SELECIONAR TODOS OS FILMES EM QUE O PERSONAGEM SINESTRO APARECE (FAZER UTILIZANDO JOIN E SUB QUERY)
SELECT *
FROM FILME
JOIN (SELECT *
FROM FILME_ATOR
WHERE NOME_PERSONAGEM LIKE '%SINESTRO%') AS FILME_ATOR
ON FILME_ATOR.ID_FILME = FILME.ID_FILME



--15 - SELECIONAR TODOS OS FILMES EM QUE O ATOR JAMES EARL JONES TRABALHOU, RETORNAR TAMBEM A COLUNA COM O NOME DO ATOR

SELECT *
FROM FILME
JOIN FILME_ATOR
ON FILME_ATOR.ID_FILME = FILME.ID_FILME
JOIN ATOR 
ON ATOR.ID_ATOR = FILME_ATOR.ID_ATOR
WHERE NOME_ATOR = 'JAMES EARL JONES'




--16 - SELECIONAR TODOS OS FILMES DE 2012, EXCLU�DOS, OU N�O



SELECT *
FROM FILME
WHERE ANO_FILME = 2012



--17 - SELECIONAR TODOS OS FILMES DO DIRETOR RIDLEY SCOTT. RETORNAR TAMBEM A COLUNA COM O NOME DO DIRETOR

SELECT *
FROM FILME
JOIN DIRETOR
ON FILME.ID_DIRETOR = DIRETOR.ID_DIRETOR
WHERE DIRETOR.NOME_DIRETOR = 'RIDLEY SCOTT'

--18 - SELECIONAR OS NOMES DE TODOS OS ATORES QUE TAMB�M FORAM DIRETORES EM ALGUM FILME

SELECT A.NOME_ATOR, D.NOME_DIRETOR, F.NOME_FILME
FROM ATOR A 
JOIN FILME_ATOR FA
ON A.ID_ATOR = FA.ID_ATOR
JOIN FILME F
ON FA.ID_FILME = F.ID_DIRETOR
JOIN DIRETOR D
ON D.ID_DIRETOR= F.ID_DIRETOR

--19 - SELECIONAR OS NOMES DE TODOS OS ATORES QUE FORAM DIRETORES NO MESMO FILME

SELECT A.NOME_ATOR, D.NOME_DIRETOR, F.NOME_FILME
FROM ATOR A
JOIN FILME F
ON A.ID_ATOR = F.ID_FILME
JOIN DIRETOR D 
ON D.ID_DIRETOR = F.ID_DIRETOR

--20 - SELECIONAR OS TR�S DIRETORES QUE FIZERAM MAIS FILMES

SELECT TOP(3) WITH TIES D.NOME_DIRETOR, COUNT(ID_FILME) QTDFILMES
FROM FILME F
JOIN DIRETOR D
ON F.ID_DIRETOR = D.ID_DIRETOR
GROUP BY D.NOME_DIRETOR
ORDER BY 2 DESC


--21 - SELECIONAR OS CINCO G�NEROS COM MENOS FILMES

SELECT TOP(5) WITH TIES G.NOME_GENERO, COUNT(ID_FILME) AS QUANTIDADE
FROM GENERO G 
JOIN FILME_GENERO FG
ON G.ID_GENERO = FG.ID_GENERO
GROUP BY G.NOME_GENERO
ORDER BY  COUNT(ID_FILME)


--22 - SELECIONAR OS G�NEROS DE TODOS OS FILMES DO ANO QUE TEM A MAIOR QUANTIDADE DE FILMES

SELECT TOP (1) WITH TIES F.ANO_FILME
FROM FILME F
GROUP BY F.ANO_FILME
ORDER BY COUNT (*) DESC

SELECT G.NOME_GENERO
FROM GENERO G
JOIN FILME_GENERO FG
ON FG.ID_GENERO = G.ID_GENERO
JOIN FILME F
ON F.ID_FILME = FG.ID_FILME
WHERE F.ANO_FILME IN (SELECT TOP(1) WITH TIES F.ANO_FILME
FROM FILME F
GROUP BY F.ANO_FILME
ORDER BY COUNT (*) DESC) 


--23 - SELECIONAR TODOS OS ATORES QUE TENHAM O MESMO NOME DO PERSONAGEM QUE ENCENARAM NOS FILMES

SELECT A.NOME_ATOR, FA.NOME_PERSONAGEM
FROM FILME_ATOR FA
JOIN ATOR A 
ON FA.ID_ATOR = A.ID_ATOR
WHERE NOME_ATOR=NOME_PERSONAGEM
 
 --24 - SELECIONAR TODOS OS ATORES QUE TENHAM FEITO MAIS DE UM PERSONAGEM NO MESMO FILME

 SELECT  A.NOME_ATOR, F.NOME_FILME, COUNT(FA.NOME_PERSONAGEM) AS QUANTIDADE
 FROM FILME_ATOR FA
 JOIN ATOR A
 ON FA.ID_ATOR = A.ID_ATOR
 JOIN FILME F
 ON FA.ID_FILME = F.ID_FILME
 GROUP BY A.NOME_ATOR, F.NOME_FILME
 HAVING COUNT(FA.NOME_PERSONAGEM) > 1


 --25 - SELECIONAR OS NOMES ORIGINAIS DE TODOS OS 
--FILMES QUE TENHAM MENOS DE 10 ATORES

SELECT F.NOME_FILME, A.ID_ATOR, COUNT(*) AS TOTAL
FROM FILME F 
JOIN FILME_ATOR FA
ON F.ID_FILME = FA.ID_FILME
JOIN ATOR A
ON A.ID_ATOR = FA.ID_ATOR
GROUP BY F.NOME_FILME, A.ID_ATOR
HAVING COUNT (*)>1


--26 - CONTAR QUANTOS FILMES DO DIRETOR JON FAVREAU EXISTEM NO CADASTRO

SELECT D.NOME_DIRETOR, COUNT(F.ID_DIRETOR) AS CADASTRO
FROM DIRETOR D
JOIN FILME F
ON F.ID_FILME = D.ID_DIRETOR
WHERE D.NOME_DIRETOR = 'JON FAVREAU'
GROUP BY (D.NOME_DIRETOR)


--27 - CONTAR QUANTOS PERSONAGENS EXISTEM NOS FILMES DO DIRETOR RIDLEY SCOTT

SELECT D.NOME_DIRETOR, COUNT (FA.NOME_PERSONAGEM) QNTD
FROM FILME F 
JOIN FILME_ATOR FA
ON FA.ID_FILME = F.ID_FILME
JOIN DIRETOR D 
ON D.ID_DIRETOR = F.ID_DIRETOR
WHERE D.NOME_DIRETOR = 'RIDLEY SCOTT'
GROUP BY  D.NOME_DIRETOR




--28 - SELECIONAR QUAIS ATORES FIZERAM FILMES DE ACTION OU CRIME OU THRILLER


SELECT A.NOME_ATOR, G.NOME_GENERO
FROM FILME F 
JOIN FILME_GENERO FG
ON FG.ID_FILME = F.ID_FILME
JOIN FILME_ATOR FA
ON FA.ID_FILME= F.ID_FILME
JOIN ATOR A 
ON FA.ID_ATOR = A.ID_ATOR
JOIN GENERO G 
ON G.ID_GENERO = FG.ID_GENERO
WHERE G.NOME_GENERO IN ('ACTION', 'CRIME', 'THRILLER')


--29 - SELECIONAR OS DIRETORES QUE N�O TEM FILMES ASSOCIADOS



SELECT D.NOME_DIRETOR
FROM DIRETOR D
LEFT JOIN  FILME F
ON F.ID_DIRETOR = D.ID_DIRETOR
WHERE F.ID_FILME IS NULL



--30 - SELECIONAR OS GENEROS QUE N�O TEM FILMES ASSOCIADOS



SELECT G.NOME_GENERO
FROM FILME_GENERO FG
JOIN FILME F
ON FG.ID_FILME= F.ID_FILME
RIGHT JOIN GENERO G
ON G.ID_GENERO = FG.ID_GENERO
WHERE F.ID_FILME IS NULL



--31 - SELECIONAR OS FILMES DO GENERO ACTION DO ANO 2009 QUE TENHAM SCARLETT JOHANSSON NO ELENCO

SELECT G.NOME_GENERO, F.ANO_FILME, A.NOME_ATOR
FROM FILME_GENERO FG
JOIN FILME F
ON FG.ID_FILME= F.ID_FILME
JOIN GENERO G
ON G.ID_GENERO = FG.ID_GENERO
JOIN FILME_ATOR FA 
ON FA.ID_FILME = F.ID_FILME
JOIN ATOR A 
ON A.ID_ATOR = FA.ID_ATOR
WHERE G.NOME_GENERO = 'ACTION' AND A.NOME_ATOR = 'SCARLETT JOHANSSON' AND F.ANO_FILME = 2009


--32 - SELECIONAR OS DIRETORES DOS FILMES EM QUE JON FAVREAU ATUOU

SELECT F.NOME_FILME, D.NOME_DIRETOR, A.NOME_ATOR
FROM ATOR A 
JOIN FILME_ATOR  FA
ON FA.ID_ATOR = A.ID_ATOR
JOIN FILME F 
ON F.ID_FILME = FA.ID_FILME
JOIN DIRETOR D
ON D.ID_DIRETOR = F.ID_DIRETOR
WHERE A.NOME_ATOR = 'JON FAVREAU'


--33 - SELECIONAR OS PERSONAGENS DO ATOR KARL URBAN, EXCLU�DOS, OU N�O



SELECT FA.NOME_PERSONAGEM, A.NOME_ATOR
FROM ATOR A 
JOIN FILME_ATOR  FA
ON FA.ID_ATOR = A.ID_ATOR
WHERE A.NOME_ATOR = 'KARL URBAN'



--34 - SELECIONAR OS ATORES QUE FIZERAM PERSONAGENS SEM NOME EM FILMES


SELECT DISTINCT A.NOME_ATOR, FA.NOME_PERSONAGEM
FROM ATOR A 
INNER JOIN FILME_ATOR FA
ON A.ID_ATOR = FA.ID_ATOR
INNER JOIN FILME F
ON FA.ID_FILME = F.ID_FILME
WHERE FA.NOME_PERSONAGEM = '' OR FA.NOME_PERSONAGEM IS NULL



--35 - SELECIONAR OS NOMES DOS FILMES EM QUE O ATOR KARL URBAN ATUOU



SELECT F.NOME_FILME, A.NOME_ATOR
FROM FILME_ATOR FA
JOIN ATOR A 
ON A.ID_ATOR = FA.ID_ATOR
JOIN FILME F 
ON F.ID_FILME = FA.ID_FILME
WHERE A.NOME_ATOR = 'KARL URBAN'


--36 - SELECIONAR OS ANOS DOS FILMES EM QUE O ATOR VIGGO MORTENSEN ATUOU


SELECT A.NOME_ATOR, F.ANO_FILME
FROM FILME_ATOR FA
JOIN ATOR A 
ON FA.ID_ATOR = A.ID_ATOR
JOIN FILME F 
ON F.ID_FILME = FA.ID_FILME
WHERE A.NOME_ATOR = 'VIGGO MORTENSEN'



--37 - SELECIONAR OS ATORES QUE N�O ATUARAM






--38 - SELECIONAR OS NOMES DE TODOS OS ATORES QUE INTERPRETARAM O PERSONAGEM CONAN



--39 - SELECIONAR OS NOMES DE TODOS OS ATORES QUE INTERPRETARAM O PERSONAGEM CONAN EM MAIS DE UM FILME



-- 40 DOS GENEROS QUE TEM MAIS FILMES, SELECIONAR APENAS DO 3� AO 5�


