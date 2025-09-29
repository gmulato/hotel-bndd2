Pessoal, liga não, só estou fazendo este arquivo pra colocar umas perguntas pra eu ir treinando, pode ignorar este arquivo
não se precupem
fica bagunçado se abrir pelo git hub


Lista de Exercícios - Sistema de Hotelaria
PARTE 1 - DDL (Data Definition Language)

Exercício 1.2 - Alteração de Tabela
Adicione uma coluna OBSERVACOES (texto até 500 caracteres) na tabela HTL_QUARTO.
Exercício 1.3 - Constraint
Crie uma constraint para garantir que na tabela HTL_QUARTO o valor da diária seja sempre maior que zero.

PARTE 2 - DML (Data Manipulation Language)
Exercício 2.1 - INSERT
Insira 3 novos quartos na tabela HTL_QUARTO:

Quarto 103 (STANDARD, R$ 230.00)
Quarto 203 (LUXO, R$ 370.00)
Quarto 302 (SUITE, R$ 520.00)

Exercício 2.2 - UPDATE
Atualize o valor da diária de todos os quartos do tipo 'STANDARD' aumentando em 10%.
Exercício 2.3 - DELETE
Delete todos os quartos que estão marcados como INATIVO = 1.

PARTE 3 - SELECT Básico
Exercício 3.1 - SELECT Simples
Liste todos os funcionários mostrando nome e email.
Exercício 3.2 - SELECT com WHERE
Liste todos os quartos do tipo 'LUXO' que custam menos de R$ 400,00.
Exercício 3.3 - SELECT com ORDER BY
Liste todos os serviços ordenados por valor (do mais caro para o mais barato).
Exercício 3.4 - SELECT com LIKE
Liste todos os hóspedes cujo nome contenha 'Silva' ou 'Santos'.
Exercício 3.5 - SELECT com BETWEEN
Liste todas as reservas com data de início entre '2025-09-20' and '2025-09-25'.

PARTE 4 - SELECT com JOIN
Exercício 4.1 - INNER JOIN Simples
Liste o nome de todos os funcionários e suas respectivas funções.
Exercício 4.2 - JOIN com 3 Tabelas
Liste todas as reservas mostrando: nome do hóspede, identificador do quarto, e status da reserva.
Exercício 4.3 - JOIN Complexo
Liste todas as reservas finalizadas mostrando: nome do hóspede, quarto, funcionário que criou a reserva, valor contratado e dias de hospedagem.
Exercício 4.4 - LEFT JOIN
Liste todos os quartos e suas reservas (incluindo quartos sem reservas).

PARTE 5 - Funções Agregadas e GROUP BY
Exercício 5.1 - COUNT
Quantos hóspedes do sexo feminino estão cadastrados?
Exercício 5.2 - SUM e AVG
Qual o valor total e a média das diárias de todos os quartos ativos?
Exercício 5.3 - GROUP BY
Quantas reservas existem por status? (Aguardando, Ocupado, Cancelado, Finalizado)
Exercício 5.4 - GROUP BY com HAVING
Quais tipos de quarto têm valor médio de diária superior a R$ 300,00?
Exercício 5.5 - MAX e MIN
Qual o maior e menor valor de serviço oferecido pelo hotel?

PARTE 6 - Consultas Avançadas
Exercício 6.1 - Subconsulta
Liste todos os funcionários que já criaram pelo menos uma reserva.
Exercício 6.2 - EXISTS
Liste todos os quartos que possuem pelo menos uma reserva.
Exercício 6.3 - IN
Liste todos os hóspedes que fizeram reservas nos quartos 101, 201 ou 301.
Exercício 6.4 - CASE WHEN
Crie uma consulta que mostre todos os quartos com uma coluna adicional "CATEGORIA_PRECO":

Até R$ 300: "ECONÔMICO"
De R$ 301 a R$ 500: "INTERMEDIÁRIO"
Acima de R$ 500: "PREMIUM"


PARTE 7 - Consultas de Negócio
Exercício 7.1 - Ocupação por Período
Quantos hóspedes ficaram no hotel entre '2025-09-15' e '2025-09-25'?
Exercício 7.2 - Receita por Tipo de Quarto
Qual a receita total gerada por cada tipo de quarto? (considere apenas reservas finalizadas)
Exercício 7.3 - Serviços Mais Consumidos
Quais os 3 serviços mais consumidos pelos hóspedes? (quantidade e valor total)
Exercício 7.4 - Funcionários por Performance
Liste os funcionários que criaram reservas, mostrando quantas reservas cada um criou e o valor total dessas reservas.
Exercício 7.5 - Análise de Cancelamentos
Qual o percentual de reservas canceladas em relação ao total de reservas?

PARTE 8 - PROCEDURES
Exercício 8.1 - Procedure Simples
Crie uma procedure que receba um ID de hóspede e retorne todas as informações dele formatadas.
Exercício 8.2 - Procedure com Parâmetros
Crie uma procedure que receba um período (data início e fim) e retorne quantas reservas foram criadas neste período.
Exercício 8.3 - Procedure de Negócio
Crie uma procedure que receba um ID de reserva e calcule o valor total da estadia (diárias + serviços consumidos).

PARTE 9 - FUNCTIONS
Exercício 9.1 - Function de Cálculo
Crie uma function que receba duas datas e retorne a quantidade de dias entre elas.
Exercício 9.2 - Function de Status
Crie uma function que receba um ID de quarto e retorne se ele está "LIVRE", "OCUPADO" ou "RESERVADO" na data atual.
Exercício 9.3 - Function de Validação
Crie uma function que receba um CPF (string) e valide se está no formato correto (###.###.###-##).
Exercício 9.4 - Function Complexa
Crie uma function que receba um ID de hóspede e retorne seu "PERFIL DE CONSUMO":

"BÁSICO": só usa quartos STANDARD
"CONFORTO": usa quartos LUXO ou FAMÍLIA
"PREMIUM": usa quartos SUITE ou SUITE MASTER


PARTE 10 - Desafios Avançados
Exercício 10.1 - Relatório Completo
Crie uma consulta que gere um relatório mensal mostrando:

Número total de reservas
Receita total (diárias + serviços)
Taxa de ocupação média
Serviço mais consumido

Exercício 10.2 - Procedure de Check-in
Crie uma procedure para realizar check-in que:

Receba ID da reserva
Atualize o status para 'OCUPADO'
Registre a data/hora do check-in
Insira um registro no histórico de status

Exercício 10.3 - Function de Recomendação
Crie uma function que receba um orçamento máximo e retorne o quarto disponível que melhor se adequa ao valor (mais próximo do orçamento sem ultrapassar).







--BI303268X	C##BRIBND2_LUCAS_NOVAIS	Lucas Novais de Oliveira

-- Como fazer um select
-- O comando SELECT * FROM [nome_tabela] lista todas as colunas e todas as linhas da tabela.


--Diferença entre WHERE e JOIN
--WHERE serve para filtrar resultados de uma tabela (ou de várias já relacionadas)
SELECT * FROM CIDADE WHERE ID_CIDADE = 3;

--JOIN serve para "juntar" dados de tabelas diferentes
--exemplo: trazer os usuários com sua respectiva cidade
SELECT U.NOME_USUARIO, C.NOME_CIDADE
FROM USUARIO U
JOIN CIDADE C ON U.ID_CIDADE = C.ID_CIDADE;



--INNER JOIN → só traz registros que existem nas duas tabelas
SELECT U.NOME_USUARIO, C.NOME_CIDADE
FROM USUARIO U
INNER JOIN CIDADE C ON U.ID_CIDADE = C.ID_CIDADE;

--LEFT OUTER JOIN → traz todos os registros da esquerda (CIDADE),
--mesmo que não exista correspondente na direita (USUARIO)
SELECT C.NOME_CIDADE, U.NOME_USUARIO
FROM CIDADE C
LEFT OUTER JOIN USUARIO U ON U.ID_CIDADE = C.ID_CIDADE;

--RIGHT OUTER JOIN → traz todos da direita (USUARIO), mesmo sem cidade correspondente
SELECT C.NOME_CIDADE, U.NOME_USUARIO
FROM CIDADE C
RIGHT OUTER JOIN USUARIO U ON U.ID_CIDADE = C.ID_CIDADE;
--INNER = interseção, OUTER = união parcial.


-- FUNÇÕES BÁSICAS
SELECT COUNT(*) FROM CIDADE; -- CONTAGEM do número de registros na tabela CIDADE
SELECT MAX(NOTA) FROM ALUNO_AVALIACAO; -- Encontra o valor MÁXIMO da coluna NOTA
SELECT MIN(NOTA) FROM ALUNO_AVALIACAO; -- Encontra o valor MÍNIMO da coluna NOTA
SELECT AVG(NOTA) FROM ALUNO_AVALIACAO; -- Calcula a MÉDIA dos valores da coluna NOTA
SELECT ROUND(AVG(NOTA),2) FROM ALUNO_AVALIACAO; -- ARREDONDA a média das notas para 2 casas decimais
SELECT UPPER(NOME_ALUNO) FROM ALUNO; -- Converte o conteúdo da coluna NOME_ALUNO para letras MAIÚSCULAS
SELECT LOWER(NOME_ALUNO) FROM ALUNO; -- Converte o conteúdo da coluna NOME_ALUNO para letras MINÚSCULAS

SELECT IDADE FROM ALUNO WHERE MOD(IDADE,2)=0; -- Filtra alunos com IDADE PAR usando o operador MOD

SELECT to_char(SYSDATE, 'DD/MM/YYYY') FROM DUAL; -- Exibe a DATA ATUAL do sistema no formato 'DD/MM/YYYY'

select to_char(created_at, 'day' ) || ', ' || to_char(created_at, 'dd' ) || ' de ' -- Concatena partes da data para formatar por extenso
     || to_char(created_at, 'month' ) || ' de '      || to_char(created_at, 'YYYY' ) as "data_extenso"
     from cidade;

-- OPERADORES
SELECT * FROM CIDADE WHERE ID_CIDADE = 3; -- Filtra registros onde o ID_CIDADE é IGUAL a 3
SELECT * FROM CIDADE WHERE ID_CIDADE <> 3; -- Filtra registros onde o ID_CIDADE é DIFERENTE de 3
SELECT * FROM CIDADE WHERE ID_CIDADE > 3; -- Filtra registros onde o ID_CIDADE é MAIOR que 3
SELECT * FROM CIDADE WHERE ID_CIDADE > 1 AND ID_CIDADE < 5; -- Filtra com a INTERSECÇÃO (AND) de duas condições
SELECT * FROM CIDADE WHERE ID_CIDADE <= 1 OR ID_CIDADE >= 5; -- Filtra com a UNIÃO (OR) de duas condições
SELECT * FROM CIDADE WHERE NOT(ID_CIDADE <= 1 OR ID_CIDADE >= 5); -- Nega a condição, retornando o contrário
SELECT * FROM CIDADE WHERE NOME_CIDADE LIKE 'B%'; -- Filtra cidades que começam com 'B' (LIKE)
SELECT * FROM ALUNO WHERE IDADE BETWEEN 15 AND 17; -- Filtra alunos com idade entre 15 e 17

SELECT DISTINCT id_cidade FROM CIDADE; -- Seleciona valores únicos (DISTINCT) da coluna ID_CIDADE

WHERE ID_CIDADE IN (SELECT ID_CIDADE FROM USUARIO WHERE TIPO = 2); -- Retorna cidades que possuem USUÁRIOS do tipo 2 (ALUNO)
WHERE ID_CIDADE NOT IN (SELECT ID_CIDADE FROM USUARIO WHERE TIPO = 2); -- Retorna cidades que NÃO possuem USUÁRIOS do tipo 2 (ALUNO)

SELECT * FROM CIDADE C WHERE  EXISTS  (SELECT * FROM USUARIO U WHERE U.ID_CIDADE = C.ID_CIDADE AND U.TIPO = 2); -- Retorna cidades que existem em USUARIO e cujo TIPO é 2
SELECT * FROM CIDADE C WHERE  NOT EXISTS  (SELECT * FROM USUARIO U WHERE U.ID_CIDADE = C.ID_CIDADE AND U.TIPO = 2); -- Retorna cidades que NÃO existem em USUARIO com TIPO 2

### Diferença entre WHERE e JOIN

**JOIN**: Utilizado para combinar colunas de duas ou mais tabelas com base em um relacionamento (uma coluna comum) entre elas. O `JOIN` é a forma correta de trazer dados de diferentes tabelas para uma única consulta.

**WHERE**: Utilizado para filtrar os registros que são retornados pelo `SELECT`, `UPDATE` ou `DELETE`. Ele restringe o número de linhas baseado em uma ou mais condições.

**Exemplo**:
*   `JOIN`: `SELECT u.NOME_USUARIO, c.NOME_CIDADE FROM USUARIO u JOIN CIDADE c ON u.ID_CIDADE = c.ID_CIDADE;` — Combina as tabelas `USUARIO` e `CIDADE` para mostrar o nome do usuário e o nome da cidade.
*   `WHERE`: `SELECT * FROM CIDADE WHERE NOME_CIDADE = 'Birigui';` — Filtra registros da tabela `CIDADE` com o nome 'Birigui'.

No seu código:
`SELECT U.NOME_USUARIO, C.NOME_CIDADE FROM USUARIO U, CIDADE C WHERE U.ID_CIDADE = C.ID_CIDADE;`
A cláusula `WHERE` está sendo usada para criar um `INNER JOIN` implícito, o que é uma prática mais antiga. Em SQL moderno (ANSI), a sintaxe com `JOIN ... ON` é preferida, pois é mais clara e robusta.



### Diferença entre EXISTS e IN
--IN → compara diretamente valores
SELECT * FROM CIDADE
WHERE ID_CIDADE IN (SELECT ID_CIDADE FROM USUARIO WHERE TIPO = 2);

--EXISTS → verifica a existência de linhas
SELECT * FROM CIDADE C
WHERE EXISTS (SELECT 1 FROM USUARIO U WHERE U.ID_CIDADE = C.ID_CIDADE AND U.TIPO = 2);


### JOINS PADRÃO (INNER JOINS)
-- USUÁRIOS E CIDADES
SELECT U.NOME_USUARIO, C.NOME_CIDADE
  FROM USUARIO U INNER JOIN CIDADE C ON U.ID_CIDADE = C.ID_CIDADE; -- Sintaxe moderna ANSI, mais legível
 
  
-- DISCIPLINAS E PROFESSORES  
SELECT P.NOME_PROFESSOR, D.NOME_DISCIPLINA
  FROM PROFESSOR P INNER JOIN DISCIPLINA D ON D.ID_PROFESSOR = P.ID_PROFESSOR;    

-- JOIN PARA BUSCAR CIDADES DE ALUNOS E PROFESSORES (DUPLICAÇÃO DA TABELA NO FROM)
-- O JOIN abaixo é complexo e utiliza a sintaxe antiga. A sintaxe ANSI seria mais clara.
-- A consulta une várias tabelas para obter informações detalhadas de aluno, professor e disciplinas.
SELECT A.NOME_ALUNO, U.COD_USUARIO, C.NOME_CIDADE, D.NOME_DISCIPLINA, A.ID_USUARIO,
       P.NOME_PROFESSOR, U1.COD_USUARIO,
       C1.NOME_CIDADE
    FROM MATRICULA M, ALUNO A, USUARIO U, CIDADE C, DISCIPLINA D,
         PROFESSOR P, USUARIO U1, CIDADE C1
    WHERE M.ID_ALUNO = 1 AND  M.ID_DISCIPLINA = 1 AND -- Filtro de matrícula específico
          M.ID_ALUNO = A.ID_ALUNO AND -- Relaciona Matrícula com Aluno
          A.ID_USUARIO = U.ID_USUARIO AND -- Relaciona Aluno com Usuário
          U.ID_CIDADE = C.ID_CIDADE AND -- Relaciona Usuário (Aluno) com Cidade
          M.ID_DISCIPLINA = D.ID_DISCIPLINA AND -- Relaciona Matrícula com Disciplina
          D.ID_PROFESSOR = P.ID_PROFESSOR AND -- Relaciona Disciplina com Professor
          P.ID_USUARIO = U1.ID_USUARIO AND -- Relaciona Professor com Usuário
          U1.ID_CIDADE = C1.ID_CIDADE; -- Relaciona Usuário (Professor) com Cidade

### OUTER JOIN
-- LEFT OUTER JOIN: Retorna todos os registros da tabela "esquerda" (CIDADE) e os registros correspondentes da tabela "direita" (USUARIO).
-- Se não houver correspondência, o resultado para a tabela da direita será NULL.
SELECT C.NOME_CIDADE, U.NOME_USUARIO, U.TIPO
FROM CIDADE C
LEFT OUTER JOIN USUARIO U ON C.ID_CIDADE = U.ID_CIDADE AND U.TIPO = 2; -- Filtrando na cláusula ON

-- RIGHT OUTER JOIN: Retorna todos os registros da tabela "direita" (USUARIO) e os correspondentes da tabela "esquerda" (CIDADE).
-- Se não houver correspondência, o resultado para a tabela da esquerda será NULL.
SELECT C.NOME_CIDADE, U.NOME_USUARIO, U.TIPO
FROM CIDADE C
RIGHT OUTER JOIN USUARIO U ON C.ID_CIDADE = U.ID_CIDADE AND U.TIPO = 2; -- Filtrando na cláusula ON


### INSERT A PARTIR DE CONSULTA (SELECT)
-- Cria uma tabela temporária com base nos dados de outras tabelas.
-- Esta é uma forma eficiente de popular uma tabela com dados já existentes.
CREATE TABLE ALUNO_PROF_DISCIPLINA (NOME_PROFESSOR VARCHAR2(50) NOT NULL,
                                    NOME_DISCIPLINA VARCHAR2(50) NOT NULL,
                                    NOME_ALUNO VARCHAR2(50) NOT NULL,
                                    PRIMARY KEY(NOME_PROFESSOR, NOME_ALUNO, NOME_DISCIPLINA));
                                    
INSERT INTO ALUNO_PROF_DISCIPLINA (NOME_PROFESSOR, NOME_DISCIPLINA, NOME_ALUNO)
SELECT P.NOME_PROFESSOR, D.NOME_DISCIPLINA, A.NOME_ALUNO
  FROM ALUNO A, PROFESSOR P, DISCIPLINA D, MATRICULA M
  WHERE D.ID_PROFESSOR = P.ID_PROFESSOR AND
        M.ID_DISCIPLINA = D.ID_DISCIPLINA AND
        M.ID_ALUNO = A.ID_ALUNO;                                                                      

SELECT * FROM ALUNO_PROF_DISCIPLINA;
DROP TABLE ALUNO_PROF_DISCIPLINA;


### UPDATE COM FILTRO (WHERE)
-- O comando UPDATE modifica dados existentes em uma tabela.
-- A cláusula WHERE é crucial para especificar quais registros serão modificados.
-- Se o WHERE for omitido, TODOS os registros da tabela serão atualizados.
UPDATE ALUNO_PROF_DISCIPLINA
  SET nome_disciplina = 'LÓGICA 2'
  WHERE NOME_DISCIPLINA = 'Logica II';
 

### DELETE COM FILTRO (WHERE)
-- O comando DELETE remove registros de uma tabela.
-- A cláusula WHERE é utilizada para especificar quais registros serão removidos.
-- Se o WHERE for omitido, TODOS os registros da tabela serão removidos.
DELETE FROM ALUNO_PROF_DISCIPLINA
       WHERE NOME_DISCIPLINA LIKE 'L%'; -- Remove disciplinas que começam com 'L'
       
DELETE FROM ALUNO_PROF_DISCIPLINA; -- Remove todos os registros da tabela

DROP TABLE ALUNO_PROF_DISCIPLINA;         


### CASE WHEN
-- O CASE WHEN permite criar lógica condicional (IF-THEN-ELSE) dentro de uma consulta SQL.
-- Ele avalia uma série de condições e retorna um valor quando a primeira condição é atendida.
SELECT a.nome_aluno, a.idade,
  CASE 
    WHEN a.idade < 7 THEN 'Criança'
    WHEN a.idade < 18 THEN 'Adolescente'
    WHEN a.idade <= 65 THEN 'Adulto'
    ELSE 'Idoso'
  END "FAIXA ETÁRIA"
 FROM aluno a;       


### UNION e UNION ALL
-- UNION combina os resultados de duas ou mais consultas, removendo linhas duplicadas.
-- UNION ALL combina os resultados sem remover duplicatas, sendo mais rápido.
SELECT NOME_PROFESSOR "NOME" FROM PROFESSOR
UNION ALL -- Combina todos os nomes de professores e alunos, incluindo duplicatas se houver
SELECT NOME_ALUNO "NOME" FROM ALUNO;

--Diferença entre UNION e UNION ALL
--UNION → junta resultados e remove duplicados
SELECT NOME_PROFESSOR AS NOME FROM PROFESSOR
UNION
SELECT NOME_ALUNO AS NOME FROM ALUNO;

--UNION ALL → junta resultados e mantém duplicados
SELECT NOME_PROFESSOR AS NOME FROM PROFESSOR
UNION ALL
SELECT NOME_ALUNO AS NOME FROM ALUNO;



### VISÃO (VIEW)
-- O que é uma VIEW?
-- Uma view é uma tabela virtual baseada no resultado de uma consulta SQL.
-- Ela não armazena dados, mas sim a definição da consulta.
-- É útil para simplificar consultas complexas, limitar o acesso a dados e reutilizar lógicas.
CREATE VIEW ALUNO_PROF_DISCIPLINA AS
SELECT P.NOME_PROFESSOR, D.NOME_DISCIPLINA, A.NOME_ALUNO
  FROM ALUNO A, PROFESSOR P, DISCIPLINA D, MATRICULA M
  WHERE D.ID_PROFESSOR = P.ID_PROFESSOR AND
        M.ID_DISCIPLINA = D.ID_DISCIPLINA AND
        M.ID_ALUNO = A.ID_ALUNO; 

DROP VIEW ALUNO_PROF_DISCIPLINA;                                             


-- ÍNDICES
-- Índices são usados para acelerar a recuperação de dados.
-- Eles criam um ponteiro para os dados da tabela, de forma similar a um índice de livro.
-- Devem ser criados em colunas frequentemente usadas em cláusulas WHERE ou JOIN.
CREATE INDEX IND_PROF_NOME_PROFESSOR ON PROFESSOR(NOME_PROFESSOR);
CREATE INDEX IND_AL_NOME_ALUNO ON ALUNO(NOME_ALUNO);
CREATE INDEX IND_DISC_NOME_DISCIPLINA ON DISCIPLINA(NOME_DISCIPLINA);
CREATE INDEX IND_AVAL_DESCRICAO ON AVALIACAO(DESCRICAO);
DROP INDEX IND_PROF_NOME_PROFESSOR;
DROP INDEX IND_AL_NOME_ALUNO;
DROP INDEX IND_DISC_NOME_DISCIPLINA;
DROP INDEX IND_AVAL_DESCRICAO;


--ORDENAÇÃO (CRIAÇÃO DE ÍNDICES)
SELECT * FROM PROFESSOR ORDER BY COD_PROFESSOR ASC; -- Ordena os resultados pela coluna COD_PROFESSOR em ordem crescente (ASC)
SELECT * FROM PROFESSOR ORDER BY NOME_PROFESSOR ASC; -- Ordena os resultados pela coluna NOME_PROFESSOR em ordem crescente
SELECT * FROM PROFESSOR ORDER BY NOME_PROFESSOR DESC; -- Ordena os resultados pela coluna NOME_PROFESSOR em ordem decrescente (DESC)

CREATE INDEX IND_NOME_PROFESSOR ON PROFESSOR(NOME_PROFESSOR); -- Cria um índice para otimizar buscas por nome do professor
DROP INDEX IND_NOME_PROFESSOR; -- Remove um índice criado

select nota from aluno_avaliacao order by nota desc; -- Seleciona e ordena as notas dos alunos em ordem decrescente

create index ind_nota on aluno_avaliacao(nota); -- Cria um índice na coluna NOTA para otimizar consultas
drop index ind_nota; -- Remove o índice



-- Dos Exercícios básico:

-- Crie uma consulta que retorne o número total de alunos cadastrados na tabela ALUNO e a média de idade de todos os alunos, arredondando o resultado para duas casas decimais.

SELECT COUNT(*) AS TOTAL_ALUNOS, ROUND(AVG(IDADE), 2) AS MEDIA_IDADE FROM ALUNO;

-- Atualize o nome da disciplina 'Lógica I' para 'Lógica e Algoritmos I' na tabela DISCIPLINA e, em seguida, salve a alteração permanentemente no banco de dados.

SELECT * FROM DISCIPLINA WHERE NOME_DISCIPLINA LIKE 'Lógica%';

UPDATE DISCIPLINA SET NOME_DISCIPLINA = 'Lógica e Algoritmos I' WHERE NOME_DISCIPLINA = 'Lógica I';
COMMIT;

-- Crie uma consulta para remover todos os registros da tabela ALUNO_AVALIACAO onde a nota seja inválida (ou seja, menor que 0 ou maior que 10) e, depois, confirme a exclusão dos dados.

DELETE FROM ALUNO_AVALIACAO WHERE NOT (NOTA BETWEEN 0 AND 10);

-- OU
DELETE FROM ALUNO_AVALIACAO WHERE NOTA > 10 OR NOTA < 0; 
COMMIT;

SELECT * FROM ALUNO_AVALIACAO; -- Verifica se os dados foram removidos corretamente

-- Desenvolva uma consulta que liste o código e o nome de cada aluno, juntamente com o código e o nome das disciplinas nas quais eles foram avaliados. Para cada aluno e disciplina, exiba a média das notas obtidas, arredondando-a para duas casas decimais. Os resultados devem ser agrupados por aluno e disciplina e ordenados por código de aluno e código de disciplina.

SELECT A.COD_ALUNO, A.NOME_ALUNO, D.COD_DISCIPLINA, D.NOME_DISCIPLINA,
       ROUND(AVG(AA.NOTA), 2) AS MEDIA_NOTA
  FROM ALUNO A
  JOIN MATRICULA M ON A.ID_ALUNO = M.ID_ALUNO
  JOIN DISCIPLINA D ON M.ID_DISCIPLINA = D.ID_DISCIPLINA
  JOIN ALUNO_AVALIACAO AA ON A.ID_ALUNO = AA.ID_ALUNO AND D.ID_DISCIPLINA = AA.ID_DISCIPLINA
 GROUP BY A.COD_ALUNO, A.NOME_ALUNO, D.COD_DISCIPLINA, D.NOME_DISCIPLINA
 ORDER BY A.COD_ALUNO, D.COD_DISCIPLINA;

-- Outra forma (sem usar a tabela MATRICULA)

SELECT  
    A.COD_ALUNO, A.NOME_ALUNO, D.COD_DISCIPLINA, D.NOME_DISCIPLINA, ROUND(AVG(al_av.nota), 2), ROUND(SUM(AL_AV.NOTA)/COUNT(AL_AV.NOTA), 2) 
FROM 
    /*MATRICULA M,*/ ALUNO A, DISCIPLINA D, ALUNO_AVALIACAO AL_AV, AVALIACAO AV 
WHERE /*M.ID_ALUNO = A.ID_ALUNO AND M.ID_DISCIPLINA = d.id_disciplina AND*/ AL_AV.ID_ALUNO = A.ID_ALUNO AND 
    AL_AV.ID_AVALIACAO = AV.ID_AVALIACAO AND 
    av.id_disciplina = d.id_disciplina 
GROUP BY 
    A.COD_ALUNO, A.NOME_ALUNO, D.COD_DISCIPLINA, D.NOME_DISCIPLINA 
ORDER BY A.COD_ALUNO, D.COD_DISCIPLINA;



-- Estrutura básica - bloco PL/SQL

-- Habilita a exibição de saída na tela (via DBMS_OUTPUT.PUT_LINE)
SET SERVEROUTPUT ON

DECLARE
    v_Var   VARCHAR2(15);   -- Declara uma variável do tipo texto (string)
BEGIN                       -- SEÇÃO EXECUTÁVEL: Onde a lógica do código acontece
    v_Var := 'Hello World!'; -- Atribui o valor 'Hello World!' à variável
    
    DBMS_OUTPUT.put_line('Mensagem:' || v_Var);
END;


-- A unidade básica de PL/SQL é o bloco, que pode ser anônimo ou nomeado (procedimento, função, pacote).
-- Um bloco PL/SQL é composto por três seções principais: DECLARE, BEGIN, END.
-- A seção DECLARE é opcional e usada para declarar variáveis, constantes, tipos e cursores.
-- A seção BEGIN contém o código executável, onde a lógica do programa é implementada.
-- A seção END marca o fim do bloco PL/SQL.
-- Cada bloco deve terminar com um ponto e vírgula (;).
-- Exemplo de bloco PL/SQL anônimo:
DECLARE
    v_nome_aluno ALUNO.NOME_ALUNO%TYPE; -- Declara uma variável para armazenar o nome do aluno
    v_idade ALUNO.IDADE%TYPE; -- Declara uma variável para armazenar a idade do aluno
BEGIN
    -- Atribui valores às variáveis
    SELECT NOME_ALUNO, IDADE INTO v_nome_aluno, v_idade FROM ALUNO WHERE COD_ALUNO = 1;
    -- Exibe os valores das variáveis
    DBMS_OUTPUT.PUT_LINE('Nome do Aluno: ' || v_nome_aluno);
    DBMS_OUTPUT.PUT_LINE('Idade do Aluno: ' || v_idade);
END;

-- EXCEPTION são usadas para tratar erros em PL/SQL.
-- Elas permitem capturar e responder a erros que ocorrem durante a execução do bloco PL/SQL.
-- A seção EXCEPTION é opcional e deve ser colocada antes do END do bloco.
-- Exemplo de bloco PL/SQL com tratamento de exceção:
DECLARE
    v_nome_aluno ALUNO.NOME_ALUNO%TYPE;
    v_idade ALUNO.IDADE%TYPE;
BEGIN
    SELECT NOME_ALUNO, IDADE INTO v_nome_aluno, v_idade FROM ALUNO WHERE COD_ALUNO = 999; -- COD_ALUNO inexistente
    DBMS_OUTPUT.PUT_LINE('Nome do Aluno: ' || v_nome_aluno);
    DBMS_OUTPUT.PUT_LINE('Idade do Aluno: ' || v_idade);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Erro: Nenhum aluno encontrado com o código especificado.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro inesperado: ' || SQLERRM);
END;

-- IF/ELSE

DECLARE
    v_nome_aluno ALUNO.NOME_ALUNO%TYPE;
    v_idade ALUNO.IDADE%TYPE;
BEGIN
    -- **CORREÇÃO AQUI: Usando o ID_ALUNO (chave primária)**
    SELECT NOME_ALUNO, IDADE
    INTO v_nome_aluno, v_idade
    FROM ALUNO
    WHERE ID_ALUNO = 1; -- Seleciona ANDERSON CARDOSO DE OLIVEIRA (Idade: 18)

    DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome_aluno || ' | Idade: ' || v_idade);

    IF v_idade < 18 THEN
        DBMS_OUTPUT.PUT_LINE('Situação: Menor de idade');
    ELSIF v_idade BETWEEN 18 AND 65 THEN
        DBMS_OUTPUT.PUT_LINE('Situação: Adulto');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Situação: Idoso');
    END IF;
END;


-- O %TYPE é usado para declarar variáveis que herdam automaticamente o tipo de dado de uma coluna de tabela ou de outra variável.

-- Isso garante que a variável tenha o mesmo tipo de dado e tamanho da coluna referenciada, facilitando a manutenção do código.
-- Exemplo:
DECLARE
    v_nome ALUNO.NOME_ALUNO%TYPE; -- variável herda o tipo de NOME_ALUNO
BEGIN
    SELECT NOME_ALUNO
      INTO v_nome
      FROM ALUNO
     WHERE ID_ALUNO = 1;

    DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome);
END;


--- Variável que herda o tipo de outra variável
DECLARE
    v_idade ALUNO.IDADE%TYPE := 20; -- herda tipo da coluna IDADE
    v_idade_copia v_idade%TYPE;     -- herda tipo da variável v_idade
BEGIN
    v_idade_copia := v_idade + 5;

    DBMS_OUTPUT.PUT_LINE('Idade original: ' || v_idade);
    DBMS_OUTPUT.PUT_LINE('Idade + 5: ' || v_idade_copia);
END;


-- Aqui a variável v_id tem o mesmo tipo da PK ID_ALUNO, o que evita problemas se o tipo mudar (por exemplo, de NUMBER para VARCHAR2).
-- %TYPE = garante consistência e evita dor de cabeça se o schema mudar.

-- O %ROWTYPE é usado para declarar uma variável que representa uma linha inteira de uma tabela, view ou cursor.


-- Mais exemplos:

-- 2. Operações Matemáticas
-- Habilita a exibição de saída na tela
SET SERVEROUTPUT ON

-- SEÇÃO DE DECLARAÇÃO
DECLARE
    v_Salario  NUMBER;    -- Salário base
    v_PercAum  NUMBER;    -- Percentual de aumento (cuidado com a divisão de inteiros em alguns contextos)
    v_TotalSal NUMBER;    -- Salário final
BEGIN
    -- SEÇÃO EXECUTÁVEL
    v_Salario := 2500.00; -- Define o salário inicial
    v_PercAum := 30/100;  -- Calcula 0.3 (30%)
    
    -- Realiza o cálculo: Salário + (Salário * Percentual)
    v_TotalSal := v_Salario + (v_Salario * v_PercAum);
    
    -- Exibe o resultado da operação
    DBMS_OUTPUT.put_line('O novo salário é: ' || v_TotalSal);
END;


-- 3. Condicional (IF/ELSE)

DECLARE
    v_Salario  NUMBER := 4500;    -- Variável com atribuição inicial (inline)
    v_PercAum  NUMBER := 30/100;
    v_TotalSal NUMBER;
    v_Ativo    BOOLEAN;           -- Variável booleana (TRUE/FALSE)
BEGIN
    v_Ativo := FALSE; -- Define a condição como FALSA
    
    -- Início da estrutura condicional (IF)
    IF v_Ativo THEN -- Se v_Ativo for TRUE (neste caso, é FALSE, então pula para o ELSE)
        v_TotalSal:= v_Salario + (v_Salario * v_PercAum);
        DBMS_OUTPUT.put_line('O novo salário é: ' || v_TotalSal);
    ELSE -- Se a condição do IF não for atendida (v_Ativo é FALSE)
        DBMS_OUTPUT.put_line('Não houve aumento. ');
    END IF;
END;




-- 4. MANIPULAÇÃO DE VARIÁVEIS DO TIPO DATA

SET SERVEROUTPUT ON

DECLARE
    -- Variável DATE com atribuição inicial (o formato da string depende do NLS_DATE_FORMAT)
    data_pagamento DATE := '12/11/2020'; 
BEGIN
    -- Exibe a data inicial
    DBMS_OUTPUT.put_line('Data atual: ' || data_pagamento);
    
    -- Em PL/SQL, somar um número a uma data equivale a adicionar esse número de DIAS
    data_pagamento:= data_pagamento + 10;
    DBMS_OUTPUT.put_line('Data atual mais 10 dias: ' || data_pagamento);
    
    -- SYSDATE retorna a data e hora atual do servidor
    DBMS_OUTPUT.put_line('Data do servidor: ' || SYSDATE);
    
    -- Subtrair duas datas resulta no número de dias de diferença (com casas decimais)
    DBMS_OUTPUT.put_line('Diferença em dias (decimal): ' || (data_pagamento - SYSDATE));
    
    -- ROUND arredonda o número de dias para o número inteiro mais próximo
    DBMS_OUTPUT.put_line('Diferença em dias (arredondada): ' || ROUND(data_pagamento - SYSDATE)); 
END;



-- 5. BLOCOS ANONIMOS ANINHADOS (Escopo de Variáveis)

SET SERVEROUTPUT ON

-- Início do Bloco EXTERNO (Label usado para referência)
<<EXTERNO>>
DECLARE
    v_Salario  NUMBER := 4500;
    v_PercAum  NUMBER := 30/100;
    v_TotalSal NUMBER;             -- Variável v_TotalSal do bloco EXTERNO
    v_Ativo    BOOLEAN;
BEGIN
    v_Ativo := TRUE;
    
    -- Lógica do Bloco EXTERNO
    IF v_Ativo THEN 
        v_TotalSal:= v_Salario + (v_Salario * v_PercAum);
        DBMS_OUTPUT.put_line('EXTERNO - Novo salário: ' || v_TotalSal);
    ELSE 
        DBMS_OUTPUT.put_line('EXTERNO - Não houve aumento. ');
    END IF; 
    
    -- Início do Bloco INTERNO
    <<INTERNO>>
    DECLARE
        -- Variável v_TotalSal do bloco INTERNO (esconde/sobrescreve a do bloco EXTERNO)
        v_TotalSal NUMBER := 5000; 
    BEGIN
        -- Acessa a variável v_TotalSal do Bloco EXTERNO, usando o label
        DBMS_OUTPUT.put_line('INTERNO - Salário EXTERNO: ' || EXTERNO.v_TotalSal);
        
        -- Acessa a variável v_TotalSal do próprio Bloco INTERNO (sem label)
        DBMS_OUTPUT.put_line('INTERNO - Salário INTERNO: ' || v_TotalSal);
    END; -- Fim do Bloco INTERNO
END; -- Fim do Bloco EXTERNO




-- 6. SE-ENTÃO-SENÃO (IF Aninhado)

-- Habilita a exibição de saída na tela
SET SERVEROUTPUT ON

-- SEÇÃO DE DECLARAÇÃO
DECLARE
    v_Salario  NUMBER := 3500;
    v_Situacao BOOLEAN;
    v_PerAum   NUMBER := 30/100;
    v_Total    NUMBER;
BEGIN
    v_Situacao := FALSE;
    
    -- IF Principal: Verifica a situação
    IF v_Situacao THEN -- Condição 1 (TRUE)
        v_Total := v_Salario + (v_Salario * v_PerAum);
        DBMS_OUTPUT.PUT_LINE ('O novo salário é (Aumento): ' || v_Total);
    ELSE  -- Se a Condição 1 for FALSE, entra no ELSE, que contém outro IF
        
        -- IF Aninhado: Verifica o valor do salário
        IF v_Salario > 4000 THEN -- Condição 2 (FALSE, pois 3500 não é > 4000)
            v_Total := v_Salario;
        ELSE -- Entra no ELSE do IF Aninhado
            v_Total := v_Salario - 1000; -- Resultado esperado: 3500 - 1000 = 2500
        END IF; -- Fim do IF Aninhado
        
        DBMS_OUTPUT.PUT_LINE ('O novo salário é (Redução): ' || v_Total);
    END IF; -- Fim do IF Principal
END;



-- 7. CASE (Estrutura de Múltipla Escolha)

SET SERVEROUTPUT ON

DECLARE 
    MEDIA_TURMA NUMBER; -- Variável para armazenar a média
BEGIN
    -- OBSERVAÇÃO: A tabela ALUNO_DISP_AVAL não existe no DDL inicial.
    -- Esta linha simula a busca de uma média de notas (SELECT INTO)
    -- ASSUMINDO que o SELECT INTO funcione e MEDIA_TURMA seja preenchida.
    -- Para este exemplo, imagine que MEDIA_TURMA = 6.5.
    SELECT AVG(NOTA) 
    INTO MEDIA_TURMA
    FROM ALUNO_DISP_AVAL; 
    
    -- Início da estrutura CASE
    CASE
        -- Verifica se a média é menor ou igual a 5.0
        WHEN MEDIA_TURMA <= 5 THEN
            DBMS_OUTPUT.PUT_LINE ('Turma com baixo rendimento: ' || MEDIA_TURMA);
        
        -- Verifica se a média é menor ou igual a 7.0 (se a anterior foi FALSE)
        WHEN MEDIA_TURMA <= 7 THEN
            DBMS_OUTPUT.PUT_LINE ('Turma com rendimento médio: ' || MEDIA_TURMA);
    
    -- Se nenhuma das condições acima for TRUE, executa o ELSE
    ELSE
        DBMS_OUTPUT.PUT_LINE ('Turma com alto rendimento: ' || MEDIA_TURMA);
    END CASE;
END;



-- 8. INSERIR REGISTROS/EXIBIR RESULTADOS (DML em PL/SQL)

-- Cria a tabela temporária antes de rodar o bloco PL/SQL
CREATE TABLE TEMP_TABLE(
    NUM_COL NUMBER(1) NOT NULL CONSTRAINT PK_TEMP_TANBLE PRIMARY KEY,
    CHAR_COL VARCHAR2(50)
);

-- Habilita a exibição de saída na tela
SET SERVEROUTPUT ON
DECLARE
    v_Num1 NUMBER := 1;
    v_Num2 NUMBER := 2;
    v_String1 VARCHAR2(50):= 'Alô Mundo!';
    v_String2 VARCHAR2(50):= 'Essa mensagem te trouxe ao PL/SQL!';
    
    v_OutputStr VARCHAR2(50);
    v_OutputNbr NUMBER;
BEGIN
    -- Insere a primeira linha na tabela TEMP_TABLE, usando valores de variáveis
    INSERT INTO TEMP_TABLE(NUM_COL, CHAR_COL) 
    VALUES (v_Num1, v_String1);
    
    -- Insere a segunda linha
    INSERT INTO TEMP_TABLE(NUM_COL, CHAR_COL) 
    VALUES (v_Num2, v_String2);
  
    -- Seleciona e armazena o primeiro registro em variáveis locais (SELECT INTO)
    SELECT NUM_COL, CHAR_COL
    INTO v_OutputNbr, v_OutputStr
    FROM TEMP_TABLE
    WHERE NUM_COL = v_Num1;
  
    -- Exibe o resultado (PUT não quebra a linha, PUT_LINE quebra)
    DBMS_OUTPUT.PUT (v_OutputStr || '-');
    DBMS_OUTPUT.PUT_line (v_OutputNbr);
  
    -- Seleciona e armazena o segundo registro (reutiliza a variável de string)
    SELECT CHAR_COL
    INTO v_OutputStr
    FROM TEMP_TABLE
    WHERE NUM_COL = v_Num2;
  
    -- Exibe o segundo resultado, usando o número do primeiro registro (v_OutputNbr)
    DBMS_OUTPUT.PUT (v_OutputStr);
    DBMS_OUTPUT.PUT_line (v_OutputNbr);
  
    -- ROLLBACK desfaz as inserções de DML (INSERT) feitas neste bloco
    ROLLBACK; 
    -- COMMIT; -- Se estivesse ativo, salvaria as alterações permanentemente
END;


























-- QUESTÕES DE PL/SQL PARA TREINO com Respostas (12 exercícios)

1. Criar um bloco PL/SQL anônimo para imprimir a tabuada abaixo: 
5 X 1 = 5 
5 X 2 = 10 
... 
5 X 10 = 50 
DECLARE 
 V_N CONSTANT NUMBER(2) := 5; 
BEGIN 
 FOR I IN 1..10 LOOP 
  DBMS_OUTPUT.PUT_LINE(V_N || ' X ' || I || ' = ' || V_N*I); 
 END LOOP; 
END; 
/ 
2. Criar um bloco PL/SQL anônimo para imprimir as tabuadas abaixo: 
1 X 1 = 1 
1 X 2 = 2 
... 
10 X 9 = 90 
10 X 10 = 100 
BEGIN 
 FOR I IN 1..10 LOOP 
  FOR J IN 1..10 LOOP 
   DBMS_OUTPUT.PUT_LINE(I || ' X ' || J || ' = ' || I*J); 
  END LOOP; 
 END LOOP; 
END; 
/ 
3. Criar um bloco PL/SQL para apresentar os anos bissextos entre 2000 e 2100. Um ano será bissexto 
quando for possível dividi‐lo por 4, mas não por 100 ou quando for possível dividi‐lo por 400. 
DECLARE 
 V_ANO NUMBER(4); 
BEGIN 
 FOR V_ANO IN 2000..2100 LOOP 
  IF (MOD(V_ANO,4) = 0 AND MOD(V_ANO,100) != 0) OR (MOD(V_ANO,400) = 0) THEN 
   DBMS_OUTPUT.PUT_LINE(V_ANO); 
  END IF; 
 END LOOP; 
END; 
/ 
4. Criar um bloco PL/SQL para atualizar a tabela abaixo, conforme segue: 
Produtos categoria A deverão ser reajustados em 5% 
Produtos categoria B deverão ser reajustados em 10% 
Produtos categoria C deverão ser reajustados em 15% 
PRODUTO ------------------------ 
CODIGO  CATEGORIA  VALOR ------------------------ 
1001    A          7.55 
1002    B          5.95 
1003    C          3.45 ------------------------ 
CREATE TABLE PRODUTO ( 
CODIGO NUMBER(4), 
CATEGORIA CHAR(1), 
VALOR NUMBER(4,2)); 
INSERT INTO PRODUTO VALUES (1001,'A',7.55); 
INSERT INTO PRODUTO VALUES (1002,'B',5.95); 
INSERT INTO PRODUTO VALUES (1003,'C',3.45); --SOLUÇÃO 1 
DECLARE 
 CURSOR C_PRODUTO IS SELECT * FROM PRODUTO; 
 V_PRODUTO PRODUTO%ROWTYPE; 
BEGIN 
 FOR V_PRODUTO IN C_PRODUTO LOOP 
  IF V_PRODUTO.CATEGORIA = 'A' THEN 
   UPDATE PRODUTO SET VALOR = VALOR * 1.05 WHERE CODIGO = V_PRODUTO.CODIGO; 
  ELSIF V_PRODUTO.CATEGORIA = 'B' THEN 
   UPDATE PRODUTO SET VALOR = VALOR * 1.10 WHERE CODIGO = V_PRODUTO.CODIGO; 
  ELSE 
   UPDATE PRODUTO SET VALOR = VALOR * 1.15 WHERE CODIGO = V_PRODUTO.CODIGO; 
  END IF; 
 END LOOP; 
END; 
/ --SOLUÇÃO 2 
DECLARE 
 CURSOR C_PRODUTO IS SELECT * FROM PRODUTO; 
 V_PRODUTO PRODUTO%ROWTYPE; 
 V_REAJUSTE NUMBER(3,2); 
BEGIN 
 FOR V_PRODUTO IN C_PRODUTO LOOP 
  IF V_PRODUTO.CATEGORIA = 'A' THEN 
   V_REAJUSTE := 1.05; 
  ELSIF V_PRODUTO.CATEGORIA = 'B' THEN 
   V_REAJUSTE := 1.10; 
  ELSE 
   V_REAJUSTE := 1.15; 
  END IF; 
   UPDATE PRODUTO SET VALOR = VALOR * V_REAJUSTE WHERE CODIGO = 
V_PRODUTO.CODIGO; 
 END LOOP; 
END; 
/ 
5. Criar um bloco PL/SQL para imprimir a sequência de Fibonacci: 1  1  2  3  5  8  13  21  34  55 
DECLARE 
 V_A NUMBER(2) := 1; 
 V_B NUMBER(2) := 1; 
 V_C NUMBER(2) := 0; 
BEGIN 
 FOR V_I IN 1..11 LOOP 
  V_A := V_B; 
  V_B := V_C; 
  DBMS_OUTPUT.PUT_LINE(V_C); 
  V_C := V_A + V_B; 
 END LOOP; 
END; 
/ 
6. Criar uma procedure que deverá receber o código de um cliente e a partir deste dado imprimir o seu 
nome, e seu e‐mail. Os dados deverão ser obtidos a partir de uma tabela chamada CLIENTE com as 
seguintes colunas (COD_CLI,NOME_CLI,EMAIL_CLI). Exemplo: 
CLIENTE ----------------------------------------------- 
COD_CLI  NOME_CLI           EMAIL_CLI ----------------------------------------------- 
10       BEATRIZ BERNARDES  bb@dominio.com..br ----------------------------------------------- 
CREATE TABLE CLIENTE ( 
COD_CLI NUMBER(4) PRIMARY KEY, 
NOME_CLI VARCHAR2(30), 
EMAIL_CLI VARCHAR2(30)); 
INSERT INTO CLIENTE VALUES (10,'BEATRIZ BERNARDES','bb@dominio.com.br'); 
CREATE OR REPLACE PROCEDURE MOSTRA_CLIENTE ( 
  P_COD_CLI NUMBER) IS 
  V_CLIENTE CLIENTE%ROWTYPE; 
BEGIN 
  SELECT * INTO V_CLIENTE FROM CLIENTE WHERE COD_CLI = P_COD_CLI; 
  DBMS_OUTPUT.PUT_LINE(V_CLIENTE.NOME_CLI || ' - ' || V_CLIENTE.EMAIL_CLI); 
END MOSTRA_CLIENTE; 
/ 
7. Criar uma procedure que receberá um RA, um NOME e quatro notas conforme a sequência: 
(RA,NOME,A1,A2,A3,A4). A partir destes valores deverá efetuar o cálculo da média somando o maior valor 
entre A1 e A2 às notas A3 e A4 e dividindo o valor obtido por três (achando a média). Se a média for menor 
que 6 (seis) o aluno estará REPROVADO e se a média for igual ou superior a 6 (seis) o aluno estará 
APROVADO. A procedure deverá inserir os valores acima numa tabela denominada ALUNO com as 
seguintes colunas RA,NOME,A1,A2,A3,A4,MEDIA,RESULTADO. Exemplo: 
ALUNO -------------------------------------------------------- 
RA   NOME           A1   A2   A3   A4   MEDIA  RESULTADO -------------------------------------------------------- 
123  ANTONIO ALVES  6.5  3.5  9.5  5.0  7.0    APROVADO -------------------------------------------------------- 
CREATE TABLE ALUNO ( 
RA NUMBER(9), 
NOME VARCHAR2(30), 
NOTA1 NUMBER(3,1), 
NOTA2 NUMBER(3,1), 
NOTA3 NUMBER(3,1), 
NOTA4 NUMBER(3,1), 
MEDIA NUMBER(3,1), 
RESULTADO VARCHAR2(15)); 
CREATE OR REPLACE PROCEDURE CALCULA_MEDIA ( 
 RA NUMBER, 
 NOME VARCHAR2, 
 N1 NUMBER, 
 N2 NUMBER, 
 N3 NUMBER, 
 N4 NUMBER) IS 
 V_MAIOR NUMBER(3,1); 
 V_MEDIA NUMBER(3,1); 
 V_RESULTADO VARCHAR2(15); 
BEGIN 
 IF N1 > N2 THEN V_MAIOR := N1; 
 ELSE V_MAIOR := N2; 
 END IF; 
 V_MEDIA := (V_MAIOR + N3 + N4)/3; 
 IF V_MEDIA < 6 THEN V_RESULTADO := 'REPROVADO'; 
 ELSE V_RESULTADO := 'APROVADO'; 
 END IF; 
 INSERT INTO ALUNO VALUES (RA,NOME,N1,N2,N3,N4,V_MEDIA,V_RESULTADO); 
END CALCULA_MEDIA; 
/ 
8. Criar uma procedure que receberá o CÓDIGO de um PRODUTO. A partir deste dado deverá consultar 
uma tabela denominada PRODUTO e verificar a que CATEGORIA o produto pertence. Com base nesta 
informação deverá informar qual o valor (em Reais) do IPI consultando para isso uma tabela denominada 
ALIQUOTA. As tabelas PRODUTO e ALIQUOTA estão parcialmente representadas a seguir: 
PRODUTO ----------------------- 
COD_PRO  VALOR  COD_CAT ----------------------- 
1001    
120.00  A 
1002    
250.00  B ----------------------- 
ALIQUOTA --------------- 
COD_CAT     IPI --------------- 
A           10 
B           15 --------------- 
NOTA: Os valores do IPI estão representados em porcentagem (10%, 15%, etc.) 
CREATE TABLE PRODUTO ( 
COD_PRO NUMBER(4) PRIMARY KEY, 
VALOR NUMBER(6,2), 
COD_CAT CHAR(1)); 
CREATE TABLE ALIQUOTA ( 
COD_CAT CHAR(1) PRIMARY KEY, 
IPI NUMBER(2)); 
INSERT INTO PRODUTO VALUES (1001,120,'A'); 
INSERT INTO PRODUTO VALUES (1002,250,'B'); 
INSERT INTO ALIQUOTA VALUES ('A',10); 
INSERT INTO ALIQUOTA VALUES ('B',15); 
CREATE OR REPLACE PROCEDURE CALCULA_IPI ( 
 P_COD_PRO NUMBER) IS 
 V_VALOR PRODUTO.VALOR%TYPE; 
 V_IPI ALIQUOTA.IPI%TYPE; 
 V_VALOR_IPI NUMBER(6,2); 
BEGIN 
 SELECT VALOR INTO V_VALOR FROM PRODUTO WHERE COD_PRO = P_COD_PRO; 
 SELECT A.IPI INTO V_IPI FROM PRODUTO P INNER JOIN ALIQUOTA A 
  ON P.COD_CAT = A.COD_CAT WHERE COD_PRO = P_COD_PRO; 
 V_VALOR_IPI := V_VALOR * (V_IPI/100); 
 DBMS_OUTPUT.PUT_LINE(V_VALOR_IPI); 
END CALCULA_IPI; 
/ 
9. Uma empresa oferece um bônus a seus funcionários com base no lucro liquido (tabela LUCRO) obtido 
durante o ano e no valor do salário do funcionário (tabela SALARIO). O bônus é calculado conforme a 
seguinte formula: BONUS = LUCRO * 0.01 + SALARIO * 0.05. Crie uma procedure que receba o ano (tabela 
LUCRO) e número de matricula do funcionário e devolva (imprima) o valor do seu respectivo bônus. 
LUCRO ----------------- 
ANO   VALOR ----------------- 
2007  1200000 
2008  1500000 
2009  1400000 ----------------- 
SALARIO ----------------- 
MATRICULA  VALOR ----------------- 
1001       2500 
1002       3200 ----------------- 
CREATE TABLE LUCRO ( 
ANO NUMBER(4), 
VALOR NUMBER(9,2)); 
CREATE TABLE SALARIO ( 
MATRICULA NUMBER(4), 
VALOR NUMBER(7,2)); 
INSERT INTO LUCRO VALUES (2007,1200000); 
INSERT INTO LUCRO VALUES (2008,1500000); 
INSERT INTO LUCRO VALUES (2009,1400000); 
INSERT INTO SALARIO VALUES (1001,2500); 
INSERT INTO SALARIO VALUES (1002,3200); 
CREATE OR REPLACE PROCEDURE CALCULA_BONUS ( 
 P_ANO LUCRO.ANO%TYPE, 
 P_MAT SALARIO.MATRICULA%TYPE) IS 
 V_VL_LUCRO LUCRO.VALOR%TYPE; 
 V_VL_SALARIO SALARIO.VALOR%TYPE; 
 V_BONUS NUMBER(7,2); 
BEGIN 
 SELECT VALOR INTO V_VL_LUCRO FROM LUCRO 
  WHERE ANO = P_ANO; 
 SELECT VALOR INTO V_VL_SALARIO FROM SALARIO 
  WHERE MATRICULA = P_MAT; 
 V_BONUS := V_VL_LUCRO * 0.01 + V_VL_SALARIO * 0.05; 
 DBMS_OUTPUT.PUT_LINE ('Valor do Bonus: ' || V_BONUS); 
END; 
/ 
EXEC CALCULA_BONUS (2007,1001); 
10. Criar uma função que deverá receber um número inteiro e retornar se o mesmo é primo ou não. 
(Lembrete: Números primos são divisíveis somente por eles mesmos e por um). 
CREATE OR REPLACE FUNCTION PRIMO ( 
 V_N NUMBER)  
 RETURN VARCHAR2 IS 
 V_SQRT NUMBER(4); 
 V_DIVISOR NUMBER(4); 
 V_RESULTADO VARCHAR2(12) := 'É PRIMO'; 
BEGIN 
 V_SQRT := SQRT(V_N); 
 FOR V_I IN 2..V_SQRT LOOP 
  IF MOD(V_N,V_I) = 0 AND V_N <> V_I THEN 
   V_RESULTADO := 'NÃO É PRIMO'; 
   V_DIVISOR := V_I; 
  END IF; 
 END LOOP; 
 RETURN V_RESULTADO; 
END; 
/ 
 
11. Criar uma função que deverá receber um valor correspondente à temperatura em graus Fahrenheit e 
retornar o equivalente em graus Celsius. Fórmula para conversão: C = (F ‐ 32) / 1.8 
 
CREATE OR REPLACE FUNCTION F_TO_C ( 
 P_F NUMBER) 
 RETURN NUMBER IS 
 V_C NUMBER(4,1); 
BEGIN 
 V_C := (P_F - 32) / 1.8; 
 RETURN V_C; 
END F_TO_C; 
/ 
 
12. Criar uma função que deverá receber o número de matrícula de um funcionário e retornar o seu nome 
e o nome de seu departamento, conforme as seguintes tabelas: 
 
FUNCIONARIO ----------------------------- 
MATRICULA  NOME     COD_DEPTO ----------------------------- 
1001       ANTONIO  1 
1002       BEATRIZ  2 
1003       CLAUDIO  1 ----------------------------- 
 ----------------------------- 
DEPARTAMENTO ----------------------------- 
COD_DEPTO  NOME_DEPTO ----------------------------- 
1          ENGENHARIA 
2          INFORMATICA ----------------------------- 
 
 
CREATE TABLE FUNCIONARIO ( 
MATRICULA NUMBER(4), 
NOME VARCHAR2(30), 
COD_DEPTO NUMBER(2)); 
 
CREATE TABLE DEPARTAMENTO ( 
COD_DEPTO NUMBER(2), 
NOME_DEPTO VARCHAR2(20)); 
 
INSERT INTO FUNCIONARIO VALUES (1001,'ANTONIO',1); 
INSERT INTO FUNCIONARIO VALUES (1002,'BEATRIZ',2); 
INSERT INTO FUNCIONARIO VALUES (1003,'CLAUDIO',1); 
 
INSERT INTO DEPARTAMENTO VALUES (1,'ENGENHARIA'); 
INSERT INTO DEPARTAMENTO VALUES (2,'INFORMATICA'); 
CREATE OR REPLACE FUNCTION CONSULTA_FUNC( 
 P_MATRICULA NUMBER) 
 RETURN VARCHAR2 IS 
 V_NOME FUNCIONARIO.NOME%TYPE; 
 V_NOME_DEPTO DEPARTAMENTO.NOME_DEPTO%TYPE; 
 V_SAIDA VARCHAR2(100); 
BEGIN 
 SELECT NOME INTO V_NOME FROM FUNCIONARIO WHERE MATRICULA = P_MATRICULA; 
 SELECT NOME_DEPTO INTO V_NOME_DEPTO FROM FUNCIONARIO 
  INNER JOIN DEPARTAMENTO 
  ON FUNCIONARIO.COD_DEPTO = DEPARTAMENTO.COD_DEPTO 
  WHERE MATRICULA = P_MATRICULA; 
 V_SAIDA := (V_NOME || ' - ' || V_NOME_DEPTO); 
 RETURN V_SAIDA; 
END CONSULTA_FUNC; 













-- PARTE 1 - DDL (Data Definition Language)

-- Exercício 1.2 - Alteração de Tabela: Adicione uma coluna OBSERVACOES na tabela HTL_QUARTO.
ALTER TABLE HTL_QUARTO
ADD OBSERVACOES VARCHAR2(500) NULL;

-- Exercício 1.3 - Constraint: Crie uma constraint para garantir que na tabela HTL_QUARTO o valor da diária seja sempre maior que zero.
ALTER TABLE HTL_QUARTO
ADD CONSTRAINT CK_HTL_QUARTO_VALOR_DIARIA_POS CHECK (VALOR_DIARIA > 0);


-- PARTE 2 - DML (Data Manipulation Language)

-- Exercício 2.1 - INSERT: Insira 3 novos quartos na tabela HTL_QUARTO.
INSERT INTO HTL_QUARTO (IDENTIFICADOR, TIPO, VALOR_DIARIA)
VALUES ('103', 'STANDARD', 230.00);

INSERT INTO HTL_QUARTO (IDENTIFICADOR, TIPO, VALOR_DIARIA)
VALUES ('203', 'LUXO', 370.00);

INSERT INTO HTL_QUARTO (IDENTIFICADOR, TIPO, VALOR_DIARIA)
VALUES ('302', 'SUITE', 520.00);

-- Exercício 2.2 - UPDATE: Atualize o valor da diária de todos os quartos do tipo 'STANDARD' aumentando em 10%.
UPDATE HTL_QUARTO
SET VALOR_DIARIA = VALOR_DIARIA * 1.10
WHERE TIPO = 'STANDARD';

-- Exercício 2.3 - DELETE: Delete todos os quartos que estão marcados como INATIVO = 1.
DELETE FROM HTL_QUARTO
WHERE INATIVO = 1; -- Deleta o quarto '502'

COMMIT; -- Confirma as alterações DML


-- PARTE 3 - SELECT Básico

-- Exercício 3.1 - SELECT Simples: Liste todos os funcionários mostrando nome e email.
SELECT NOME, EMAIL
FROM HTL_FUNCIONARIO;

-- Exercício 3.2 - SELECT com WHERE: Liste todos os quartos do tipo 'LUXO' que custam menos de R$ 400,00.
SELECT IDENTIFICADOR, TIPO, VALOR_DIARIA
FROM HTL_QUARTO
WHERE TIPO = 'LUXO' AND VALOR_DIARIA < 400.00;

-- Exercício 3.3 - SELECT com ORDER BY: Liste todos os serviços ordenados por valor (do mais caro para o mais barato).
SELECT NOME, VALOR
FROM HTL_SERVICO
ORDER BY VALOR DESC;

-- Exercício 3.4 - SELECT com LIKE: Liste todos os hóspedes cujo nome contenha 'Silva' ou 'Santos'.
-- Obs: Não há 'Silva' no DML, mas a sintaxe está correta.
SELECT NOME, CPF
FROM HTL_HOSPEDE
WHERE NOME LIKE '%Silva%' OR NOME LIKE '%Santos%';

-- Exercício 3.5 - SELECT com BETWEEN: Liste todas as reservas com data de início entre '2025-09-20' and '2025-09-25'.
SELECT RESERVA_ID, DATA_INICIO, DATA_FIM
FROM HTL_RESERVA
WHERE DATA_INICIO BETWEEN TIMESTAMP '2025-09-20 00:00:00' AND TIMESTAMP '2025-09-25 23:59:59';


-- PARTE 4 - SELECT com JOIN

-- Exercício 4.1 - INNER JOIN Simples: Liste o nome de todos os funcionários e suas respectivas funções.
SELECT f.NOME AS Funcionario, fu.NAME AS Funcao
FROM HTL_FUNCIONARIO f
JOIN HTL_FUNCIONARIO_FUNCAO ff ON f.FUNCIONARIO_ID = ff.FUNCIONARIO_ID
JOIN HTL_FUNCAO fu ON ff.FUNCAO_ID = fu.FUNCAO_ID
ORDER BY f.NOME;

-- Exercício 4.2 - JOIN com 3 Tabelas: Liste todas as reservas mostrando: nome do hóspede, identificador do quarto, e status da reserva.
SELECT
    h.NOME AS Hospede,
    q.IDENTIFICADOR AS Quarto,
    rs.STATUS AS Status_Reserva
FROM HTL_RESERVA r
JOIN HTL_HOSPEDE h ON r.HOSPEDE_ID = h.HOSPEDE_ID
JOIN HTL_QUARTO q ON r.QUARTO_ID = q.QUARTO_ID
JOIN HTL_RESERVA_STATUS rs ON r.RESERVA_STATUS_ID = rs.RESERVA_STATUS_ID
ORDER BY r.RESERVA_ID;

-- Exercício 4.3 - JOIN Complexo: Liste todas as reservas finalizadas mostrando: nome do hóspede, quarto, funcionário que criou a reserva, valor contratado e dias de hospedagem.
SELECT
    h.NOME AS Hospede,
    q.IDENTIFICADOR AS Quarto,
    f.NOME AS Criado_Por,
    r.VALOR_CONTRATADO,
    -- Calcula a diferença em dias (pode precisar de ROUND ou TRUNC para dias inteiros)
    TRUNC(r.CHECK_OUT - r.CHECK_IN) AS Dias_Hospedagem
FROM HTL_RESERVA r
JOIN HTL_HOSPEDE h ON r.HOSPEDE_ID = h.HOSPEDE_ID
JOIN HTL_QUARTO q ON r.QUARTO_ID = q.QUARTO_ID
JOIN HTL_FUNCIONARIO f ON r.CRIADO_POR = f.FUNCIONARIO_ID
JOIN HTL_RESERVA_STATUS rs ON r.RESERVA_STATUS_ID = rs.RESERVA_STATUS_ID
WHERE rs.STATUS = 'FINALIZADO';

-- Exercício 4.4 - LEFT JOIN: Liste todos os quartos e suas reservas (incluindo quartos sem reservas).
SELECT
    q.IDENTIFICADOR AS Quarto,
    h.NOME AS Hospede_na_Reserva,
    rs.STATUS AS Status_Reserva
FROM HTL_QUARTO q
LEFT JOIN HTL_RESERVA r ON q.QUARTO_ID = r.QUARTO_ID
LEFT JOIN HTL_HOSPEDE h ON r.HOSPEDE_ID = h.HOSPEDE_ID
LEFT JOIN HTL_RESERVA_STATUS rs ON r.RESERVA_STATUS_ID = rs.RESERVA_STATUS_ID
ORDER BY q.IDENTIFICADOR;


-- PARTE 5 - Funções Agregadas e GROUP BY

-- Exercício 5.1 - COUNT: Quantos hóspedes do sexo feminino estão cadastrados?
SELECT COUNT(HOSPEDE_ID) AS Total_Hospedes_Feminino
FROM HTL_HOSPEDE
WHERE SEXO = 'FEMININO';

-- Exercício 5.2 - SUM e AVG: Qual o valor total e a média das diárias de todos os quartos ativos?
SELECT
    SUM(VALOR_DIARIA) AS Valor_Total_Diarias,
    AVG(VALOR_DIARIA) AS Media_Diarias
FROM HTL_QUARTO
WHERE INATIVO = 0;

-- Exercício 5.3 - GROUP BY: Quantas reservas existem por status?
SELECT
    rs.STATUS AS Status_Reserva,
    COUNT(r.RESERVA_ID) AS Total_Reservas
FROM HTL_RESERVA r
JOIN HTL_RESERVA_STATUS rs ON r.RESERVA_STATUS_ID = rs.RESERVA_STATUS_ID
GROUP BY rs.STATUS
ORDER BY Total_Reservas DESC;

-- Exercício 5.4 - GROUP BY com HAVING: Quais tipos de quarto têm valor médio de diária superior a R$ 300,00?
SELECT
    TIPO,
    AVG(VALOR_DIARIA) AS Media_Diaria
FROM HTL_QUARTO
GROUP BY TIPO
HAVING AVG(VALOR_DIARIA) > 300.00
ORDER BY Media_Diaria DESC;

-- Exercício 5.5 - MAX e MIN: Qual o maior e menor valor de serviço oferecido pelo hotel?
SELECT
    MAX(VALOR) AS Maior_Valor_Servico,
    MIN(VALOR) AS Menor_Valor_Servico
FROM HTL_SERVICO;





-- MAIS EXERCÍCIOS DE PL/SQL PARA TREINO


-- Exercício 1.0 - Funcionários que Criaram Reservas Ocupadas
SET SERVEROUTPUT ON
DECLARE
    -- Cursor para buscar funcionários e suas funções que têm reservas 'OCUPADO'
    CURSOR c_funcionarios_ativos IS
        SELECT DISTINCT
            f.NOME AS Nome_Funcionario,
            fu.NAME AS Funcao
        FROM HTL_FUNCIONARIO f
        JOIN HTL_FUNCIONARIO_FUNCAO ff ON f.FUNCIONARIO_ID = ff.FUNCIONARIO_ID
        JOIN HTL_FUNCAO fu ON ff.FUNCAO_ID = fu.FUNCAO_ID
        JOIN HTL_RESERVA r ON f.FUNCIONARIO_ID = r.CRIADO_POR
        JOIN HTL_RESERVA_STATUS rs ON r.RESERVA_STATUS_ID = rs.RESERVA_STATUS_ID
        WHERE rs.STATUS = 'OCUPADO';

    v_nome_func HTL_FUNCIONARIO.NOME%TYPE;
    v_funcao    HTL_FUNCAO.NAME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Funcionários com Reservas Ativas (OCUPADO) ---');
    DBMS_OUTPUT.PUT_LINE(RPAD('Funcionário', 30) || ' | Função');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 40, '-'));

    -- Abrir e iterar o cursor
    OPEN c_funcionarios_ativos;
    
    LOOP
        FETCH c_funcionarios_ativos INTO v_nome_func, v_funcao;
        EXIT WHEN c_funcionarios_ativos%NOTFOUND;
        
        -- Imprimir o resultado formatado
        DBMS_OUTPUT.PUT_LINE(RPAD(v_nome_func, 30) || ' | ' || v_funcao);
    END LOOP;
    
    IF c_funcionarios_ativos%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum funcionário com reservas OCUPADAS no momento.');
    END IF;
    
    CLOSE c_funcionarios_ativos;
END;




-- Exercício 2.0 - Hóspedes sem RG (Análise de Dados)
SET SERVEROUTPUT ON
DECLARE
    v_count_sem_rg NUMBER;
    
    -- Cursor para pegar os 3 hóspedes mais antigos sem RG
    CURSOR c_hospedes_sem_rg IS
        SELECT NOME, CPF, CRIADO_EM
        FROM HTL_HOSPEDE
        WHERE RG IS NULL
        ORDER BY CRIADO_EM ASC
        FETCH FIRST 3 ROWS ONLY; -- Limita a busca aos 3 mais antigos

    v_hospede_rec c_hospedes_sem_rg%ROWTYPE;
BEGIN
    -- 1. Verifica se existem hóspedes sem RG
    SELECT COUNT(*) INTO v_count_sem_rg
    FROM HTL_HOSPEDE
    WHERE RG IS NULL;
    
    DBMS_OUTPUT.PUT_LINE('--- Verificação de Hóspedes sem RG ---');

    IF v_count_sem_rg > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Total de hóspedes sem RG: ' || v_count_sem_rg);
        DBMS_OUTPUT.PUT_LINE(RPAD('Nome', 30) || ' | CPF' || RPAD(' ', 10) || ' | Criado em');
        DBMS_OUTPUT.PUT_LINE(RPAD('-', 65, '-'));

        -- 2. Itera sobre o cursor dos 3 mais antigos
        OPEN c_hospedes_sem_rg;
        
        LOOP
            FETCH c_hospedes_sem_rg INTO v_hospede_rec;
            EXIT WHEN c_hospedes_sem_rg%NOTFOUND;
            
            DBMS_OUTPUT.PUT_LINE(
                RPAD(v_hospede_rec.NOME, 30) || 
                ' | ' || v_hospede_rec.CPF || 
                ' | ' || TO_CHAR(v_hospede_rec.CRIADO_EM, 'DD/MM/YYYY HH24:MI:SS')
            );
        END LOOP;
        
        CLOSE c_hospedes_sem_rg;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Excelente! Todos os hóspedes têm RG cadastrado.');
    END IF;
END;






-- Exercício 3.0 - Faturamento Detalhado por Serviço ('Spa')
SET SERVEROUTPUT ON
DECLARE
    v_servico_nome CONSTANT VARCHAR2(100) := 'Spa';
    
    -- Variáveis para armazenar os resultados da agregação
    v_total_faturado NUMBER(10, 2);
    v_total_consumido NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Análise de Faturamento do Serviço: ' || v_servico_nome || ' ---');
    
    -- 1. Realiza a agregação em SQL puro
    SELECT 
        NVL(SUM(rs.VALOR), 0),
        COUNT(rs.SERVICO_ID)
    INTO 
        v_total_faturado, 
        v_total_consumido
    FROM HTL_RESERVA_SERVICO rs
    JOIN HTL_SERVICO s ON rs.SERVICO_ID = s.SERVICO_ID
    WHERE s.NOME = v_servico_nome;
    
    -- 2. Imprime os resultados
    DBMS_OUTPUT.PUT_LINE('Total de Registros de Consumo: ' || v_total_consumido);
    
    IF v_total_consumido > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Valor Total Faturado: R$ ' || TO_CHAR(v_total_faturado, 'FM999,990.00'));
        DBMS_OUTPUT.PUT_LINE('Valor Médio por Consumo: R$ ' || 
            TO_CHAR(v_total_faturado / v_total_consumido, 'FM999,990.00'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum consumo registrado para este serviço.');
    END IF;

END;










-- CREATE OR REPLACE

-- Exercício 1.1 - Function para Calcular Gasto Total do Hóspede
CREATE OR REPLACE FUNCTION FNC_CALC_GASTO_TOTAL_HOSPEDE (
    p_hospede_id IN INTEGER
)
RETURN NUMBER
IS
    v_gasto_diarias  NUMBER(10, 2) := 0;
    v_gasto_servicos NUMBER(10, 2) := 0;
BEGIN
    -- 1. Soma dos valores contratados (Diárias)
    SELECT NVL(SUM(VALOR_CONTRATADO), 0) INTO v_gasto_diarias
    FROM HTL_RESERVA
    WHERE HOSPEDE_ID = p_hospede_id;
    
    -- 2. Soma dos valores de serviços consumidos
    SELECT NVL(SUM(rs.VALOR), 0) INTO v_gasto_servicos
    FROM HTL_RESERVA_SERVICO rs
    JOIN HTL_RESERVA r ON rs.RESERVA_ID = r.RESERVA_ID
    WHERE r.HOSPEDE_ID = p_hospede_id;
    
    -- 3. Retorna o total
    RETURN v_gasto_diarias + v_gasto_servicos;
    
END FNC_CALC_GASTO_TOTAL_HOSPEDE;
/

-- Bloco de Execução (Teste da Function)
SET SERVEROUTPUT ON
DECLARE
    v_gasto_bruno NUMBER;
    v_bruno_id    NUMBER;
BEGIN
    SELECT HOSPEDE_ID INTO v_bruno_id FROM HTL_HOSPEDE WHERE NOME = 'Bruno Almeida';

    v_gasto_bruno := FNC_CALC_GASTO_TOTAL_HOSPEDE(v_bruno_id);
    
    DBMS_OUTPUT.PUT_LINE('--- Teste FNC_CALC_GASTO_TOTAL_HOSPEDE ---');
    DBMS_OUTPUT.PUT_LINE('Gasto Total de Bruno Almeida: R$ ' || TO_CHAR(v_gasto_bruno, 'FM999,990.00'));
END;




-- Exercício 1.2 - Procedure para Identificar o Hóspede Mais Gastador
CREATE OR REPLACE PROCEDURE PRC_HOSPEDE_MAIS_GASTADOR
IS
    v_hospede_id HTL_HOSPEDE.HOSPEDE_ID%TYPE;
    v_hospede_nome HTL_HOSPEDE.NOME%TYPE;
    v_gasto_atual NUMBER(10, 2);
    
    v_max_gasto NUMBER(10, 2) := 0;
    v_nome_max_gastador HTL_HOSPEDE.NOME%TYPE;
    
    -- Cursor para iterar sobre todos os hóspedes
    CURSOR c_todos_hospedes IS
        SELECT HOSPEDE_ID, NOME
        FROM HTL_HOSPEDE;
        
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Análise do Hóspede com Maior Gasto Total ---');
    
    OPEN c_todos_hospedes;
    
    LOOP
        FETCH c_todos_hospedes INTO v_hospede_id, v_hospede_nome;
        EXIT WHEN c_todos_hospedes%NOTFOUND;
        
        -- Chama a função criada no Exercício 1.1
        v_gasto_atual := FNC_CALC_GASTO_TOTAL_HOSPEDE(v_hospede_id);
        
        -- Lógica para encontrar o máximo
        IF v_gasto_atual > v_max_gasto THEN
            v_max_gasto := v_gasto_atual;
            v_nome_max_gastador := v_hospede_nome;
        END IF;
        
    END LOOP;
    
    CLOSE c_todos_hospedes;
    
    -- Exibir o resultado final
    IF v_nome_max_gastador IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('O hóspede mais gastador é: ' || v_nome_max_gastador);
        DBMS_OUTPUT.PUT_LINE('Gasto Total (Diárias + Serviços): R$ ' || TO_CHAR(v_max_gasto, 'FM999,990.00'));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum hóspede com gastos registrados.');
    END IF;
    
END PRC_HOSPEDE_MAIS_GASTADOR;
/

-- Bloco de Execução (Teste da Procedure)
SET SERVEROUTPUT ON
BEGIN
    PRC_HOSPEDE_MAIS_GASTADOR;
END;



/*
Procedure: Hóspedes por Período de Estadia E Serviço
Crie uma procedure que receba um período de datas (p_data_inicio, p_data_fim) e um nome de serviço (p_servico_nome). A procedure deve listar os nomes dos hóspedes que tiveram um check-in dentro desse período E consumiram o serviço especificado.
*/

-- Exercício 2.0 - Procedure para Listar Hóspedes por Período e Serviço Consumido
CREATE OR REPLACE PROCEDURE PRC_HOSPEDES_POR_PERIODO_E_SERVICO (
    p_data_inicio IN DATE,
    p_data_fim IN DATE,
    p_servico_nome IN VARCHAR2
)
IS
    v_servico_id HTL_SERVICO.SERVICO_ID%TYPE;
    
    -- Cursor para obter hóspedes que atenderam aos critérios de filtro
    CURSOR c_hospedes IS
        SELECT DISTINCT h.NOME
        FROM HTL_RESERVA r
        JOIN HTL_HOSPEDE h ON r.HOSPEDE_ID = h.HOSPEDE_ID
        JOIN HTL_RESERVA_SERVICO rs ON r.RESERVA_ID = rs.RESERVA_ID
        WHERE 
            -- Filtra pelo período de CHECK-IN
            TRUNC(r.CHECK_IN) BETWEEN p_data_inicio AND p_data_fim
            -- Filtra pelo ID do serviço
            AND rs.SERVICO_ID = v_servico_id;
            
    v_hospede_nome HTL_HOSPEDE.NOME%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--- Buscando Hóspedes ---');
    
    -- 1. Obter o ID do serviço. Se não existir, a exceção NO_DATA_FOUND será lançada.
    SELECT SERVICO_ID INTO v_servico_id
    FROM HTL_SERVICO
    WHERE NOME = p_servico_nome;
    
    DBMS_OUTPUT.PUT_LINE('Serviço: ' || p_servico_nome || ' (ID: ' || v_servico_id || ')');
    DBMS_OUTPUT.PUT_LINE('Período de Check-in: ' || TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || ' a ' || TO_CHAR(p_data_fim, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Hóspedes Encontrados:');
    
    -- 2. Abrir e iterar o cursor
    OPEN c_hospedes;
    
    LOOP
        FETCH c_hospedes INTO v_hospede_nome;
        EXIT WHEN c_hospedes%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('- ' || v_hospede_nome);
    END LOOP;
    
    -- 3. Verifica se encontrou resultados
    IF c_hospedes%ROWCOUNT = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Nenhum hóspede encontrado com check-in no período e que usou este serviço.');
    END IF;
    
    CLOSE c_hospedes;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('ERRO: O serviço "' || p_servico_nome || '" não foi encontrado na base de dados.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('ERRO INESPERADO: ' || SQLERRM);
END PRC_HOSPEDES_POR_PERIODO_E_SERVICO;
/

-- Bloco de Execução (Teste da Procedure)
SET SERVEROUTPUT ON
BEGIN
    -- Bruno Almeida fez check-in em 15/09/2025 e usou o serviço "Serviço de Quarto"
    PRC_HOSPEDES_POR_PERIODO_E_SERVICO(
        p_data_inicio  => DATE '2025-09-14',
        p_data_fim     => DATE '2025-09-16',
        p_servico_nome => 'Serviço de Quarto'
    );
END;


/*
3. Function: Analisar Ocupação por Tipo de Quarto
Crie uma função que receba o nome do tipo de quarto (ex: 'LUXO') e retorne a quantidade de quartos desse tipo que estão atualmente ocupados.
*/

-- Exercício 3.0 - Function para Contar Quartos Ocupados por Tipo
CREATE OR REPLACE FUNCTION FNC_QUARTOS_OCUPADOS_POR_TIPO (
    p_tipo_quarto IN VARCHAR2
)
RETURN NUMBER
IS
    v_qtd_ocupados NUMBER := 0;
    v_status_ocupado_id HTL_RESERVA_STATUS.RESERVA_STATUS_ID%TYPE;
BEGIN
    -- 1. Obter o ID do status 'OCUPADO'
    SELECT RESERVA_STATUS_ID INTO v_status_ocupado_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'OCUPADO';
    
    -- 2. Contar as reservas ativas (OCUPADO) para o tipo de quarto
    SELECT COUNT(r.RESERVA_ID) INTO v_qtd_ocupados
    FROM HTL_RESERVA r
    JOIN HTL_QUARTO q ON r.QUARTO_ID = q.QUARTO_ID
    WHERE q.TIPO = p_tipo_quarto
    AND r.RESERVA_STATUS_ID = v_status_ocupado_id;
    
    -- Retorna o número de quartos ocupados
    RETURN v_qtd_ocupados;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        -- Caso o status 'OCUPADO' ou o tipo de quarto não seja encontrado
        RETURN -1; -- Retorna um valor de erro para tratamento
END FNC_QUARTOS_OCUPADOS_POR_TIPO;
/

-- Bloco de Execução (Teste da Function)
SET SERVEROUTPUT ON
DECLARE
    v_tipo_luxo VARCHAR2(30) := 'LUXO';
    v_tipo_suite VARCHAR2(30) := 'SUITE';
    v_ocupados_luxo NUMBER;
    v_ocupados_suite NUMBER;
BEGIN
    v_ocupados_luxo := FNC_QUARTOS_OCUPADOS_POR_TIPO(v_tipo_luxo);
    v_ocupados_suite := FNC_QUARTOS_OCUPADOS_POR_TIPO(v_tipo_suite);

    DBMS_OUTPUT.PUT_LINE('--- Análise de Ocupação Atual ---');
    
    IF v_ocupados_luxo >= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Total de quartos "' || v_tipo_luxo || '" Ocupados: ' || v_ocupados_luxo);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERRO: Não foi possível obter dados para o tipo "' || v_tipo_luxo || '".');
    END IF;
    
    IF v_ocupados_suite >= 0 THEN
        DBMS_OUTPUT.PUT_LINE('Total de quartos "' || v_tipo_suite || '" Ocupados: ' || v_ocupados_suite);
    ELSE
        DBMS_OUTPUT.PUT_LINE('ERRO: Não foi possível obter dados para o tipo "' || v_tipo_suite || '".');
    END IF;

END;

























