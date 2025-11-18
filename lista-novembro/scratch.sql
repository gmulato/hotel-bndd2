------------------------------------------------------------
-- 1) Impedir menores de 18 anos (amigo secreto)
------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_IMPEDIR_MENOR
BEFORE INSERT OR UPDATE ON AMIGOSECRETO
FOR EACH ROW
DECLARE
    V_IDADE AMIGO.IDADE%TYPE;
    V_NOME  AMIGO.ANOME%TYPE;
BEGIN
    SELECT IDADE, ANOME
      INTO V_IDADE, V_NOME
      FROM AMIGO
     WHERE AID = :NEW.AID;

    IF V_IDADE < 18 THEN
        RAISE_APPLICATION_ERROR(
            -20010,
            'ERRO - Participante '||V_NOME||' tem menos de 18 anos.'
        );
    END IF;
END;

------------------------------------------------------------
-- 2) Limite 10 itens e valor máximo 500 (estilo professor)
------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_QTDE_VALOR_MAX
BEFORE INSERT OR UPDATE ON LISTAPRESENTE
FOR EACH ROW    
DECLARE
    QTDE_PRES NUMBER;
    VLR_PRES NUMBER;
    VLR_PRES_ANT NUMBER;
    VLR_TOTAL NUMBER;
    NOME_PRES PRESENTE.PDESCRICAO%TYPE;
    NOME_PRES_ANT PRESENTE.PDESCRICAO%TYPE;
    NOME_AMIGO AMIGO.ANOME%TYPE;
BEGIN  
    IF INSERTING THEN
        SELECT ANOME
            INTO NOME_AMIGO
            FROM AMIGO
            WHERE AID = :NEW.AID;
    
        SELECT COUNT(pid)
            INTO QTDE_PRES
            FROM LISTAPRESENTE
            WHERE AID = :NEW.AID;
            
        SELECT PDESCRICAO, PVALOR
            INTO NOME_PRES, VLR_PRES
            FROM PRESENTE
            WHERE PID = :NEW.PID;        

        IF (QTDE_PRES = 10) THEN            
            RAISE_APPLICATION_ERROR(
                -20002,
                'ERRO - Lista de presentes de '|| NOME_AMIGO ||
                ' já atingiu o limite (10) e não será possível acrescentar ' ||
                NOME_PRES ||'.'
            );
        ELSE            
            SELECT SUM(P.PVALOR)
                INTO VLR_TOTAL
                FROM LISTAPRESENTE LP, PRESENTE P
                WHERE AID = :NEW.AID AND P.PID = LP.PID;  
                
            IF (VLR_TOTAL+VLR_PRES > 500) THEN                
                RAISE_APPLICATION_ERROR(
                    -20003,
                    'ERRO - Lista de presentes de '|| NOME_AMIGO ||
                    ' vai ultrapassar o valor máximo (500) permitido e não '||
                    'será possível acrescentar ' || NOME_PRES ||'.'
                );
            END IF;
        /*ELSE --UPDATING
            SELECT SUM(P.PVALOR)
                INTO VLR_TOTAL
                FROM LISTAPRESENTE LP, PRESENTE P
                WHERE AID = :OLD.AID AND P.PID = LP.PID;
                
            SELECT PDESCRICAO, PVALOR
                INTO NOME_PRES_ANT, VLR_PRES_ANT
                FROM PRESENTE
                WHERE PID = :OLD.PID;     
                
            IF (VLR_TOTAL+VLR_PRES-VLR_PRES_ANT > 500) THEN                 
                RAISE_APPLICATION_ERROR(-20004,'ERRO - Lista de presentes de '|| NOME_AMIGO ||' vai ultrapassar o valor máximo (500) permitido e não será possível acrescentar ' || NOME_PRES ||' no lugar de '|| NOME_PRES_ANT ||' .');
            END IF;    */
        END IF;        
    END IF;    
END;

------------------------------------------------------------
-- View para UPDATE (mutating)
------------------------------------------------------------
CREATE OR REPLACE VIEW V_LISTAPRESENTE AS
SELECT * FROM LISTAPRESENTE;

------------------------------------------------------------
-- INSTEAD OF UPDATE na view (estilo professor)
------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_VALOR_MAX_UPD
INSTEAD OF UPDATE ON V_LISTAPRESENTE
FOR EACH ROW    
DECLARE
    QTDE_PRES NUMBER;
    VLR_PRES NUMBER;
    VLR_PRES_ANT NUMBER;
    VLR_TOTAL NUMBER;
    NOME_PRES PRESENTE.PDESCRICAO%TYPE;
    NOME_PRES_ANT PRESENTE.PDESCRICAO%TYPE;
    NOME_AMIGO AMIGO.ANOME%TYPE;
BEGIN    
    SELECT ANOME
        INTO NOME_AMIGO
        FROM AMIGO
        WHERE AID = :NEW.AID;

    SELECT COUNT(pid)
        INTO QTDE_PRES
        FROM LISTAPRESENTE
        WHERE AID = :NEW.AID;
        
    SELECT PDESCRICAO, PVALOR
        INTO NOME_PRES, VLR_PRES
        FROM PRESENTE
        WHERE PID = :NEW.PID;        

    IF UPDATING THEN
        SELECT SUM(P.PVALOR)
            INTO VLR_TOTAL
            FROM LISTAPRESENTE LP, PRESENTE P
            WHERE AID = :OLD.AID AND P.PID = LP.PID;
            
        SELECT PDESCRICAO, PVALOR
            INTO NOME_PRES_ANT, VLR_PRES_ANT
            FROM PRESENTE
            WHERE PID = :OLD.PID;     
            
        IF (VLR_TOTAL+VLR_PRES-VLR_PRES_ANT > 500) THEN                 
            RAISE_APPLICATION_ERROR(
                -20004,
                'ERRO - Lista de presentes de '|| NOME_AMIGO ||
                ' vai ultrapassar o valor máximo (500) permitido e não será '||
                'possível acrescentar ' || NOME_PRES ||
                ' no lugar de '|| NOME_PRES_ANT ||' .'
            );
        ELSE
            UPDATE LISTAPRESENTE
                SET PID = :NEW.PID
                WHERE PID = :OLD.PID AND AID = :OLD.AID;
        END IF;    
    END IF;    
END;

------------------------------------------------------------
-- 3) Garantir 1 a 10 itens (amigo secreto)
------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_MIN_MAX_PRESENTES
AFTER DELETE OR INSERT OR UPDATE ON LISTAPRESENTE
FOR EACH ROW
DECLARE
    V_QTDE NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO V_QTDE
      FROM LISTAPRESENTE
     WHERE AID = NVL(:NEW.AID, :OLD.AID);

    IF V_QTDE > 10 THEN
        RAISE_APPLICATION_ERROR(-20030,'ERRO - Máximo 10 presentes.');
    END IF;

    IF V_QTDE < 1 THEN
        RAISE_APPLICATION_ERROR(-20031,'ERRO - Mínimo 1 presente.');
    END IF;
END;

------------------------------------------------------------
-- 4) Presente deve estar na lista do participante
------------------------------------------------------------
CREATE OR REPLACE TRIGGER TRG_PRESENTE_INVALIDO
BEFORE INSERT OR UPDATE ON AMIGOSECRETO
FOR EACH ROW
DECLARE
    V_COUNT NUMBER;
BEGIN
    SELECT COUNT(*)
      INTO V_COUNT
      FROM LISTAPRESENTE
     WHERE AID = :NEW.AID
       AND PID = :NEW.PID_RECEBIDO;

    IF V_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(
            -20040,
            'ERRO - Presente não está na lista do participante.'
        );
    END IF;
END;

------------------------------------------------------------
-- 5) Média na MATRICULA (schema real)
--    Cria coluna MEDIA e atualiza após operações em ALUNO_AVALIACAO
------------------------------------------------------------
ALTER TABLE MATRICULA ADD MEDIA NUMBER(3,1);


CREATE OR REPLACE TRIGGER TRG_ATUALIZA_MEDIA
AFTER INSERT OR UPDATE OR DELETE ON ALUNO_AVALIACAO
FOR EACH ROW
DECLARE
    V_ID_ALUNO       ALUNO.ID_ALUNO%TYPE;
    V_ID_AVALIACAO   AVALIACAO.ID_AVALIACAO%TYPE;
    V_ID_DISCIPLINA  DISCIPLINA.ID_DISCIPLINA%TYPE;
    V_ID_MATRICULA   MATRICULA.ID_MATRICULA%TYPE;
    V_MEDIA          MATRICULA.MEDIA%TYPE;
BEGIN
    -- aluno/avaliação afetados
    V_ID_ALUNO     := NVL(:NEW.ID_ALUNO,     :OLD.ID_ALUNO);
    V_ID_AVALIACAO := NVL(:NEW.ID_AVALIACAO, :OLD.ID_AVALIACAO);

    -- descobrir disciplina da avaliação
    SELECT ID_DISCIPLINA
      INTO V_ID_DISCIPLINA
      FROM AVALIACAO
     WHERE ID_AVALIACAO = V_ID_AVALIACAO;

    -- matrícula respectiva (aluno + disciplina)
    SELECT ID_MATRICULA
      INTO V_ID_MATRICULA
      FROM MATRICULA
     WHERE ID_ALUNO      = V_ID_ALUNO
       AND ID_DISCIPLINA = V_ID_DISCIPLINA;

    -- média das notas do aluno nessa disciplina
    SELECT AVG(AA.NOTA)
      INTO V_MEDIA
      FROM ALUNO_AVALIACAO AA
      JOIN AVALIACAO AV
        ON AV.ID_AVALIACAO = AA.ID_AVALIACAO
     WHERE AA.ID_ALUNO      = V_ID_ALUNO
       AND AV.ID_DISCIPLINA = V_ID_DISCIPLINA;

    UPDATE MATRICULA
       SET MEDIA = NVL(V_MEDIA, 0)
     WHERE ID_MATRICULA = V_ID_MATRICULA;
END;

------------------------------------------------------------
-- 6) Situação na MATRICULA (schema real)
--    Cria coluna SITUACAO e atualiza conforme a média
------------------------------------------------------------
ALTER TABLE MATRICULA ADD SITUACAO VARCHAR2(15);
/

CREATE OR REPLACE TRIGGER TRG_ATUALIZA_SITUACAO
AFTER UPDATE OF MEDIA ON MATRICULA
FOR EACH ROW
DECLARE
    V_SIT VARCHAR2(15);
BEGIN
    IF :NEW.MEDIA >= 6 THEN
        V_SIT := 'APROVADO';
    ELSIF :NEW.MEDIA >= 4 THEN
        V_SIT := 'RECUPERAÇÃO';
    ELSE
        V_SIT := 'REPROVADO';
    END IF;

    UPDATE MATRICULA
       SET SITUACAO = V_SIT
     WHERE ID_MATRICULA = :NEW.ID_MATRICULA;
END;
