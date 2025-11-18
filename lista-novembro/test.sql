------------------------------------------------------------
-- LIMPAR DADOS (OPCIONAL, SÓ PRA FICAR REDONDO)
------------------------------------------------------------
DELETE FROM AMIGOSECRETO;
DELETE FROM LISTAPRESENTE;
DELETE FROM PRESENTE;
DELETE FROM AMIGO;

DELETE FROM ALUNO_AVALIACAO;
DELETE FROM AVALIACAO;
DELETE FROM MATRICULA;
DELETE FROM DISCIPLINA;
DELETE FROM ALUNO;

COMMIT;

------------------------------------------------------------
-- DADOS BÁSICOS PARA OS EXERCÍCIOS 1 a 4
------------------------------------------------------------
-- AMIGOS (1 e 3 são adultos, 2 é menor)
INSERT INTO AMIGO (AID, ANOME, SEXO, IDADE) VALUES (1, 'João Adulto', 'M', 30);
INSERT INTO AMIGO (AID, ANOME, SEXO, IDADE) VALUES (2, 'Maria Menor', 'F', 16);
INSERT INTO AMIGO (AID, ANOME, SEXO, IDADE) VALUES (3, 'Ana Adulta',  'F', 25);

-- PRESENTES
-- Valores pensados para testar limite de 500
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (1,  'Livro',        60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (2,  'Camisa',       60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (3,  'Jogo',         60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (4,  'Relógio',      60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (5,  'Caneca',       60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (6,  'Mochila',      60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (7,  'Fone',         60);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (8,  'Teclado',      60);
-- presentes baratinhos
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (9,  'Chaveiro',     30);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (10, 'Meias',        30);
INSERT INTO PRESENTE (PID, PDESCRICAO, PVALOR) VALUES (11, 'Pulseira',     30);
COMMIT;


============================================================
-- TESTES EXERCÍCIO 1
-- TRG_IMPEDIR_MENOR (impedir menores de 18 no amigo secreto)
============================================================

-- TESTE 1.1: adulto participando (DEVE FUNCIONAR)
INSERT INTO AMIGOSECRETO (AID, AID_AMIGO, PID_RECEBIDO)
VALUES (1, 3, 1);

-- TESTE 1.2: menor de idade participando (DEVE DAR ERRO -20010)
-- espere: "ERRO - Participante Maria Menor tem menos de 18 anos."
INSERT INTO AMIGOSECRETO (AID, AID_AMIGO, PID_RECEBIDO)
VALUES (2, 1, 1);


============================================================
-- TESTES EXERCÍCIO 2
-- TRG_QTDE_VALOR_MAX (max 10 itens e total <= 500)
============================================================

-- Vamos montar a lista de presentes do AID=1 até 8 itens (8 x 60 = 480)
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 1,  1);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 2,  2);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 3,  3);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 4,  4);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 5,  5);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 6,  6);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 7,  7);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (1, 8,  8);

COMMIT;

-- TESTE 2.1: tentar colocar o 9º item que estoura o valor > 500
-- 480 + 30 = 510 (DEVE DAR ERRO -20003)
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA)
VALUES (1, 9, 9);

-- Agora vamos testar o limite de quantidade com outro amigo (AID=3)
-- Vamos usar só presentes baratinhos para não estourar 500
-- 10 itens usando PID 9,10,11 (30 cada) -> total 300 (OK)

INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 9,  1);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 10, 2);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 11, 3);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 9,  4);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 10, 5);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 11, 6);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 9,  7);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 10, 8);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 11, 9);
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA) VALUES (3, 9,  10);

COMMIT;

-- TESTE 2.2: tentar inserir o 11º item na lista do AID=3 (DEVE DAR ERRO -20002)
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA)
VALUES (3, 10, 11);


============================================================
-- TESTES EXERCÍCIO 3
-- TRG_MIN_MAX_PRESENTES (garantir entre 1 e 10 itens na lista)
============================================================

-- Para testar o mínimo, vamos criar uma lista com 1 presente para o AID=2
INSERT INTO LISTAPRESENTE (AID, PID, PREFERÊNCIA)
VALUES (2, 9, 1);

COMMIT;

-- TESTE 3.1: tentar apagar o ÚNICO presente do AID=2
-- DEVE DAR ERRO -20031 (mínimo 1 presente) e o delete deve ser revertido
DELETE FROM LISTAPRESENTE
 WHERE AID = 2
   AND PID = 9;

-- Conferir que o item ainda está lá
SELECT * FROM LISTAPRESENTE WHERE AID = 2;


============================================================
-- TESTES EXERCÍCIO 4
-- TRG_PRESENTE_INVALIDO (presente deve estar na lista do participante)
============================================================

-- Lembrando: AID=1 já tem presentes PID 1..8 na lista
-- TESTE 4.1: tentar dar para AID=1 um presente QUE NÃO ESTÁ na lista,
-- por exemplo PID=11 (DEVE DAR ERRO -20040)
INSERT INTO AMIGOSECRETO (AID, AID_AMIGO, PID_RECEBIDO)
VALUES (1, 3, 11);

-- TESTE 4.2: dar para AID=1 um presente que ESTÁ na lista (ex: PID=1)
-- DEVE FUNCIONAR
INSERT INTO AMIGOSECRETO (AID, AID_AMIGO, PID_RECEBIDO)
VALUES (1, 3, 1);

COMMIT;


============================================================
-- TESTES EXERCÍCIOS 5 e 6
-- TRG_ATUALIZA_MEDIA e TRG_ATUALIZA_SITUACAO
============================================================

-- CRIAR DADOS MÍNIMOS DA BASE EXEMPLO
-- Ajuste os tipos se necessário para a sua base.

-- ALUNOS
INSERT INTO ALUNO (ID_ALUNO, NOME) VALUES (1, 'Carlos');
INSERT INTO ALUNO (ID_ALUNO, NOME) VALUES (2, 'Bruna');
INSERT INTO ALUNO (ID_ALUNO, NOME) VALUES (3, 'Diego');

-- DISCIPLINAS
INSERT INTO DISCIPLINA (ID_DISCIPLINA, DESCRICAO) VALUES (10, 'Banco de Dados');

-- MATRÍCULAS (um por aluno na mesma disciplina 10)
INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA, MEDIA, SITUACAO)
VALUES (100, 1, 10, NULL, NULL);  -- Carlos
INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA, MEDIA, SITUACAO)
VALUES (101, 2, 10, NULL, NULL);  -- Bruna
INSERT INTO MATRICULA (ID_MATRICULA, ID_ALUNO, ID_DISCIPLINA, MEDIA, SITUACAO)
VALUES (102, 3, 10, NULL, NULL);  -- Diego

-- AVALIAÇÕES (mesma disciplina)
INSERT INTO AVALIACAO (ID_AVALIACAO, ID_DISCIPLINA, DESCRICAO)
VALUES (1000, 10, 'Prova 1');
INSERT INTO AVALIACAO (ID_AVALIACAO, ID_DISCIPLINA, DESCRICAO)
VALUES (1001, 10, 'Prova 2');

COMMIT;

------------------------------------------------------------
-- TESTE 5/6.1: aluno com média >= 6 (APROVADO)
------------------------------------------------------------
-- Carlos: notas 7.0 e 9.0 => média 8.0 (APROVADO)
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (1, 1000, 7.0);
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (1, 1001, 9.0);

------------------------------------------------------------
-- TESTE 5/6.2: aluno com média entre 4 e 6 (RECUPERAÇÃO)
------------------------------------------------------------
-- Bruna: notas 4.0 e 5.0 => média 4.5 (RECUPERAÇÃO)
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (2, 1000, 4.0);
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (2, 1001, 5.0);

------------------------------------------------------------
-- TESTE 5/6.3: aluno com média < 4 (REPROVADO)
------------------------------------------------------------
-- Diego: notas 2.0 e 3.0 => média 2.5 (REPROVADO)
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (3, 1000, 2.0);
INSERT INTO ALUNO_AVALIACAO (ID_ALUNO, ID_AVALIACAO, NOTA)
VALUES (3, 1001, 3.0);

COMMIT;

------------------------------------------------------------
-- VER RESULTADOS (MÉDIA e SITUAÇÃO)
------------------------------------------------------------
SELECT M.ID_MATRICULA,
       A.NOME,
       D.DESCRICAO AS DISCIPLINA,
       M.MEDIA,
       M.SITUACAO
  FROM MATRICULA M
  JOIN ALUNO A      ON A.ID_ALUNO = M.ID_ALUNO
  JOIN DISCIPLINA D ON D.ID_DISCIPLINA = M.ID_DISCIPLINA
 ORDER BY M.ID_MATRICULA;
