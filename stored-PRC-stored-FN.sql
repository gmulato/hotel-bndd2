--------------------------------------------------------------------------------
-- STORED PROCEDURES (SP) E STORED FUNCTIONS (SF) ESSENCIAIS
-- PARA O SISTEMA DE GERENCIAMENTO DE HOTELARIA


-- Observações:
-- 1. Não está pronto ainda (03-10-2025 ultima atualização).
-- 2. Vcs preferem usar HTL_ ou PRC_ e FN_ para SP e SF ???

-- 3. As exceções estão comentadas para evitar interrupções durante testes iniciais.
--    Descomente e ajuste conforme necessário para o ambiente de produção.
-- 
-- 4. Vou colocar comentários detalhados para cada SP e SF, explicando sua finalidade e lógica. (neste final de semana)

-- 5. Algumas estão dando erro de compilação, revisar depois.
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------

-- ADICIONAR HOSPEDE
CREATE OR REPLACE PROCEDURE PRN_ADICIONAR_HOSPEDE ( -- podemos usar HTL_ADICIONAR_HOSPEDE
    p_criado_por_id  IN HTL_FUNCIONARIO.FUNCIONARIO_ID%TYPE,
    p_nome           IN HTL_HOSPEDE.NOME%TYPE,
    p_cpf            IN HTL_HOSPEDE.CPF%TYPE,
    p_rg             IN HTL_HOSPEDE.RG%TYPE DEFAULT NULL,
    p_sexo           IN HTL_HOSPEDE.SEXO%TYPE,
    p_nascimento     IN HTL_HOSPEDE.NASCIMENTO%TYPE,
    p_email          IN HTL_HOSPEDE.EMAIL%TYPE DEFAULT NULL,
    p_telefone       IN HTL_HOSPEDE.TELEFONE%TYPE DEFAULT NULL,
    p_hospede_id_out OUT HTL_HOSPEDE.HOSPEDE_ID%TYPE
)
AS
BEGIN
    INSERT INTO HTL_HOSPEDE (
        CRIADO_POR, NOME, CPF, RG, SEXO, NASCIMENTO, EMAIL, TELEFONE
    )
    VALUES (
        p_criado_por_id, p_nome, p_cpf, p_rg, p_sexo, p_nascimento, p_email, p_telefone
    )
    RETURNING HOSPEDE_ID INTO p_hospede_id_out; -- Captura o ID gerado

    COMMIT;
/*
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        -- Trata violação de restrições UNIQUE (CPF ou RG)
        RAISE_APPLICATION_ERROR(-20001, 'Erro: CPF ou RG já cadastrado.');
    WHEN OTHERS THEN
        -- Trata outras exceções
        RAISE_APPLICATION_ERROR(-20002, 'Erro ao adicionar hóspede: ' || SQLERRM);
*/
END PRC_ADICIONAR_HOSPEDE;


-- SP para Iniciar Check-in de Reserva (PRC_FAZER_CHECKIN)
-- Esta procedure realiza as duas ações necessárias para o check-in: atualiza a reserva e registra a mudança no histórico.

CREATE OR REPLACE PROCEDURE PRC_FAZER_CHECKIN (
    p_reserva_id IN HTL_RESERVA.RESERVA_ID%TYPE
)
AS
    v_status_ocupado_id HTL_RESERVA_STATUS.RESERVA_STATUS_ID%TYPE;
BEGIN
    -- 1. Busca o ID do status 'OCUPADO'
    SELECT RESERVA_STATUS_ID INTO v_status_ocupado_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'OCUPADO';

    -- 2. Atualiza a tabela HTL_RESERVA
    UPDATE HTL_RESERVA
    SET CHECK_IN = SYSTIMESTAMP,
        RESERVA_STATUS_ID = v_status_ocupado_id,
        ATUALIZADO_EM = SYSTIMESTAMP
    WHERE RESERVA_ID = p_reserva_id
      AND CHECK_IN IS NULL; -- Apenas se o check-in ainda não foi feito

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Reserva não encontrada ou check-in já realizado/status inválido.');
    END IF;

    -- 3. Insere o registro na tabela HTL_RESERVA_STATUS_HIST
    INSERT INTO HTL_RESERVA_STATUS_HIST (RESERVA_STATUS_ID, RESERVA_ID, STATUS_EM)
    VALUES (v_status_ocupado_id, p_reserva_id, SYSTIMESTAMP);

    COMMIT;
/*
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20004, 'Status "OCUPADO" não encontrado. Seed data inválido.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20005, 'Erro ao realizar check-in: ' || SQLERRM);
*/
END PRC_FAZER_CHECKIN;



--------------------------------------------------------------------------------
-- Stored Functions (SF) Essenciais
--------------------------------------------------------------------------------

-- SF para Calcular a Média do Valor da Diária por Tipo de Quarto (FN_MEDIA_DIARIA_TIPO)
-- Esta função retorna o preço médio da diária para um determinado tipo de quarto (e.g., 'LUXO').

CREATE OR REPLACE FUNCTION FN_MEDIA_DIARIA_TIPO (
    p_tipo_quarto IN HTL_QUARTO.TIPO%TYPE
)
RETURN NUMBER
AS
    v_media_diaria NUMBER(10,2);
BEGIN
    SELECT AVG(VALOR_DIARIA)
    INTO v_media_diaria
    FROM HTL_QUARTO
    WHERE TIPO = p_tipo_quarto
      AND INATIVO = 0; -- Apenas quartos ativos

    RETURN v_media_diaria;
/*
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN 0;
    WHEN OTHERS THEN
        -- Em um ambiente de produção, seria melhor registrar o erro
        RAISE;
*/
END FN_MEDIA_DIARIA_TIPO;


--------------------------------------------------------------------------------
-- SF para Calcular o Total de Serviços Consumidos em uma Reserva (FN_TOTAL_SERVICOS_RESERVA)
-- Esta função é crucial para o fechamento da conta, somando o valor de todos os serviços adicionais.


CREATE OR REPLACE FUNCTION FN_TOTAL_SERVICOS_RESERVA (
    p_reserva_id IN HTL_RESERVA.RESERVA_ID%TYPE
)
RETURN NUMBER
AS
    v_total_servicos NUMBER(10,2) := 0;
BEGIN
    SELECT SUM(VALOR)
    INTO v_total_servicos
    FROM HTL_RESERVA_SERVICO
    WHERE RESERVA_ID = p_reserva_id;

    -- Retorna 0 se não houver serviços (NULL do SUM vira 0)
    RETURN NVL(v_total_servicos, 0);
/*
EXCEPTION
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20006, 'Erro ao calcular total de serviços: ' || SQLERRM);
*/
END FN_TOTAL_SERVICOS_RESERVA;



--------------------------------------------------------------------------------
-- Abaixo as formas de usar as SP e SF criadas
--------------------------------------------------------------------------------

/*
DECLARE
    v_funcionario_ana_id  HTL_FUNCIONARIO.FUNCIONARIO_ID%TYPE;
    v_novo_hospede_id     HTL_HOSPEDE.HOSPEDE_ID%TYPE;
BEGIN
    -- 1. Buscar o ID do funcionário 'Ana Lima'
    SELECT FUNCIONARIO_ID INTO v_funcionario_ana_id
    FROM HTL_FUNCIONARIO WHERE EMAIL = 'ana.lima@hotel.com';

    -- 2. Chamar a procedure
    PRC_ADICIONAR_HOSPEDE (
        p_criado_por_id  => v_funcionario_ana_id,
        p_nome           => 'Júlia Diniz',
        p_cpf            => '999.888.777-66',
        p_rg             => 'ES-99.888.777',
        p_sexo           => 'FEMININO',
        p_nascimento     => DATE '1993-04-01',
        p_email          => 'julia.diniz@mail.com',
        p_telefone       => '(27) 91234-5678',
        p_hospede_id_out => v_novo_hospede_id
    );

    -- 3. Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('Hóspede Júlia Diniz cadastrada com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Novo HOSPEDE_ID gerado: ' || v_novo_hospede_id);

    -- Verificar no banco de dados
    COMMIT;
END;
/

-- Consulta para verificar o resultado
SELECT NOME, CPF, CRIADO_EM
FROM HTL_HOSPEDE
WHERE NOME = 'Júlia Diniz';
*/
/*
DECLARE
    v_reserva_pedro_id HTL_RESERVA.RESERVA_ID%TYPE;
BEGIN
    -- 1. Buscar o ID da reserva de 'Pedro Rocha' (Reserva 3 no DML)
    SELECT r.RESERVA_ID INTO v_reserva_pedro_id
    FROM HTL_RESERVA r
    JOIN HTL_HOSPEDE h ON h.HOSPEDE_ID = r.HOSPEDE_ID
    WHERE h.NOME = 'Pedro Rocha'
      AND r.CHECK_IN IS NULL; -- Deve estar AGUARDANDO

    -- 2. Chamar a procedure
    PRC_FAZER_CHECKIN (p_reserva_id => v_reserva_pedro_id);

    -- 3. Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('Check-in da Reserva ID ' || v_reserva_pedro_id || ' (Pedro Rocha) realizado com sucesso.');

END;
/

-- Consulta para verificar as alterações na tabela e no histórico
SELECT r.DATA_INICIO, r.CHECK_IN, s.STATUS, TO_CHAR(r.ATUALIZADO_EM, 'YYYY-MM-DD HH24:MI:SS') AS ATUALIZADO_EM
FROM HTL_RESERVA r
JOIN HTL_RESERVA_STATUS s ON s.RESERVA_STATUS_ID = r.RESERVA_STATUS_ID
JOIN HTL_HOSPEDE h ON h.HOSPEDE_ID = r.HOSPEDE_ID
WHERE h.NOME = 'Pedro Rocha';

SELECT s.STATUS, TO_CHAR(h.STATUS_EM, 'YYYY-MM-DD HH24:MI:SS') AS STATUS_EM
FROM HTL_RESERVA_STATUS_HIST h
JOIN HTL_RESERVA_STATUS s ON s.RESERVA_STATUS_ID = h.RESERVA_STATUS_ID
JOIN HTL_RESERVA r ON r.RESERVA_ID = h.RESERVA_ID
JOIN HTL_HOSPEDE hd ON hd.HOSPEDE_ID = r.HOSPEDE_ID
WHERE hd.NOME = 'Pedro Rocha'
ORDER BY h.STATUS_EM;
*/
/*
DECLARE
    v_media NUMBER;
BEGIN
    -- 1. Chamar a função
    v_media := FN_MEDIA_DIARIA_TIPO('LUXO');

    -- 2. Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('A diária média para o tipo LUXO é: R$' || TO_CHAR(v_media, 'FM9990.00'));

END;
*/
/*
DECLARE
    v_reserva_bruno_id HTL_RESERVA.RESERVA_ID%TYPE;
    v_total_servicos   NUMBER;
BEGIN
    -- 1. Buscar o ID da reserva de 'Bruno Almeida'
    SELECT r.RESERVA_ID INTO v_reserva_bruno_id
    FROM HTL_RESERVA r
    JOIN HTL_HOSPEDE h ON h.HOSPEDE_ID = r.HOSPEDE_ID
    WHERE h.NOME = 'Bruno Almeida';

    -- 2. Chamar a função
    v_total_servicos := FN_TOTAL_SERVICOS_RESERVA(v_reserva_bruno_id);

    -- 3. Exibir o resultado
    DBMS_OUTPUT.PUT_LINE('Total de serviços na reserva de Bruno Almeida (ID ' || v_reserva_bruno_id || '): R$' || TO_CHAR(v_total_servicos, 'FM9990.00'));

END;
/

-- Resultado esperado com base no DML:
-- Café da manhã (35.00) + Lavanderia (25.00) + Serviço de Quarto (40.00) = 100.00
*/