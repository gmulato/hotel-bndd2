--------------------------------------------------------------------------------
-- STORED PROCEDURES (SP) E STORED FUNCTIONS (SF) ESSENCIAIS
-- PARA O SISTEMA DE GERENCIAMENTO DE HOTELARIA

-- Observações (Lucas Novais de Oliveira):
-- (05-10-2025) Mudado para HTL_SP e HTL_SF para manter padrão com tabelas HTL_
-- Colocado o 'OUT' para retornar o ID do hóspede criado.

-- 1. Está pronto ainda (05-10-2025 ultima atualização).
-- 2. As exceções estão comentadas para evitar interrupções durante testes iniciais.
-- 3. Descomente e ajuste conforme necessário, está funcional.
-- 
-- 4. Vou colocar comentários detalhados para cada SP e SF, explicando sua finalidade e lógica.

--------------------------------------------------------------------------------
-- Sobre STORED PROCEDURES (SP) e STORED FUNCTIONS (SF): Exemplo:

-- IN: Você envia o Nome, CPF, etc.
-- Ação: A procedure executa o INSERT e o banco gera o ID (ex: 100).
-- RETURNING INTO: Captura o ID 100 dentro da procedure.
-- OUT: O ID 100 é entregue de volta para a variável que chamou a procedure.

--------------------------------------------------------------------------------

-- ==========================================
-- 1 - ADICIONAR HOSPEDE
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_ADICIONAR_HOSPEDE (
    p_criado_por     IN INTEGER,
    p_nome           IN VARCHAR2,
    p_cpf            IN VARCHAR2,
    p_rg             IN VARCHAR2 DEFAULT NULL,
    p_sexo           IN VARCHAR2,
    p_nascimento     IN DATE,
    p_email          IN VARCHAR2 DEFAULT NULL,
    p_telefone       IN VARCHAR2 DEFAULT NULL,
    -- NOVO: Parâmetro de SAÍDA para retornar o ID gerado (por causa da linha abaixo, tem que criar variavel no DECLARE)
    p_hospede_id_out OUT INTEGER 
)
AS
BEGIN
    INSERT INTO HTL_HOSPEDE (
        CRIADO_POR, NOME, CPF, RG, SEXO, NASCIMENTO, EMAIL, TELEFONE
    )
    VALUES (
        p_criado_por, p_nome, p_cpf, p_rg, p_sexo, p_nascimento, p_email, p_telefone
    )
    -- CLÁUSULA RETURNING INTO: Captura o ID gerado pelo banco
    RETURNING HOSPEDE_ID INTO p_hospede_id_out;
    
    -- Precisa do SET SERVEROUTPUT ON; para funcionar
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Hóspede adicionado com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Nome: ' || p_nome);
    DBMS_OUTPUT.PUT_LINE('CPF: ' || p_cpf);
    -- NOVO: Exibe o ID retornado
    DBMS_OUTPUT.PUT_LINE('ID Gerado: ' || p_hospede_id_out);
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
/*
-- ==========================================
-- Até o SP já está funcional, e antes do END HTL_SP_ADICIONAR_HOSPEDE; vou colocar um TUTORIAL

-- Por que usar OUT?
-- 1. Saber qual ID foi criado sem fazer SELECT depois
-- 2. Usar o ID para operações seguintes (ex: criar reserva logo após)
-- 3. É possivel saber o próximo ID com o comando abaixo:
-- SELECT MAX(HOSPEDE_ID) + 1 AS PROXIMO_ID FROM HTL_HOSPEDE;

-- ==========================================
-- PARTE 1 - USANDO O SP: HTL_SP_ADICIONAR_HOSPEDE mas Passando todos os parâmetros
--
-- Para excluir use: DELETE FROM HTL_HOSPEDE WHERE HOSPEDE_ID = X; (OR ou BETWEEN pra deletar mais do que um)
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_novo_id INTEGER;
BEGIN
    HTL_SP_ADICIONAR_HOSPEDE(
        p_criado_por     => 1, -- Maria Souza
        p_nome           => 'Carlos Silva',
        p_cpf            => '999.888.777-66',
        p_rg             => 'SP-12.345.678',
        p_sexo           => 'MASCULINO',
        p_nascimento     => DATE '1985-06-15',
        p_email          => 'carlos.silva@email.com',
        p_telefone       => '(11) 99999-8888',
        p_hospede_id_out => v_novo_id -- Variável OUT
    );
    -- O valor de v_novo_id pode ser usado aqui para outras ações, se necessário
    -- DBMS_OUTPUT.PUT_LINE('Hóspede salvo com o ID ' || v_novo_id);

    -- Exemplo: Usando o ID retornado no mesmo bloco:

    -- FOR rec IN (SELECT NOME, CPF FROM HTL_HOSPEDE WHERE HOSPEDE_ID = v_novo_id) LOOP
        -- DBMS_OUTPUT.PUT_LINE('Verificado: ' || rec.NOME || ' - ' || rec.CPF);
    -- END LOOP;

END;
-- ==========================================
-- OU apenas os obrigatórios
-- ==========================================
DECLARE
    v_novo_id INTEGER; -- Variavel OBRIGATORIA, não vai funcionar sem este DECLARE
BEGIN
    HTL_SP_ADICIONAR_HOSPEDE(
        p_criado_por     => 1, -- Maria Souza
        p_nome           => 'Maria Santos',
        p_cpf            => '888.777.666-55',
        p_sexo           => 'FEMININO',
        p_nascimento     => DATE '1990-12-20',
        p_hospede_id_out => v_novo_id -- Variável OUT
        -- RG, email e telefone são omitidos, usando DEFAULT NULL
    );
END;

-- ==========================================
-- SELECT, CONSULTAS EXEMPLO NA TABELA HTL_HOSPEDE
-- ==========================================

-- 1) MAIS SIMPLES - Ver todos os hóspedes
SELECT * FROM HTL_HOSPEDE;

-- 2) Selecionar colunas específicas
SELECT HOSPEDE_ID, NOME, CPF, EMAIL 
FROM HTL_HOSPEDE;

-- 3) Filtrar por CPF específico
SELECT HOSPEDE_ID, NOME, CPF, EMAIL
FROM HTL_HOSPEDE
WHERE CPF = '999.888.777-66';

-- 4) Buscar pelo nome (usando LIKE)
SELECT HOSPEDE_ID, NOME, CPF, EMAIL
FROM HTL_HOSPEDE
WHERE NOME LIKE '%Carlos%';

-- 5) Ordenar por nome
SELECT HOSPEDE_ID, NOME, CPF, EMAIL
FROM HTL_HOSPEDE
ORDER BY NOME;

-- 6) Ver o último hóspede cadastrado
SELECT HOSPEDE_ID, NOME, CPF, EMAIL, CRIADO_EM
FROM HTL_HOSPEDE
ORDER BY CRIADO_EM DESC
FETCH FIRST 1 ROW ONLY;

-- 7) Com JOIN - Ver hóspede e quem cadastrou
SELECT 
  h.HOSPEDE_ID,
  h.NOME AS HOSPEDE_NOME,
  h.CPF,
  f.NOME AS CADASTRADO_POR
FROM HTL_HOSPEDE h
JOIN HTL_FUNCIONARIO f ON h.CRIADO_POR = f.FUNCIONARIO_ID
WHERE h.CPF = '999.888.777-66';

-- 8) MAIS COMPLETO - Hóspede com todas as informações do funcionário
SELECT 
  h.HOSPEDE_ID,
  h.NOME AS HOSPEDE,
  h.CPF,
  h.EMAIL AS HOSPEDE_EMAIL,
  h.TELEFONE,
  h.SEXO,
  h.NASCIMENTO,
  TO_CHAR(h.CRIADO_EM, 'DD/MM/YYYY HH24:MI:SS') AS DATA_CADASTRO,
  f.NOME AS CADASTRADO_POR,
  f.EMAIL AS EMAIL_FUNCIONARIO
FROM HTL_HOSPEDE h
JOIN HTL_FUNCIONARIO f ON h.CRIADO_POR = f.FUNCIONARIO_ID
WHERE h.CPF = '999.888.777-66';

-- 9) Hóspedes cadastrados hoje
SELECT HOSPEDE_ID, NOME, CPF, CRIADO_EM
FROM HTL_HOSPEDE
WHERE TRUNC(CAST(CRIADO_EM AS DATE)) = TRUNC(SYSDATE)
ORDER BY CRIADO_EM DESC;

-- 10) Hóspedes cadastrados nas últimas 24 horas
SELECT HOSPEDE_ID, NOME, CPF, CRIADO_EM
FROM HTL_HOSPEDE
WHERE CRIADO_EM >= SYSTIMESTAMP - INTERVAL '24' HOUR
ORDER BY CRIADO_EM DESC;

-- 11) Ver hóspedes cadastrados em um mês/ano específico (ex: Outubro/2025)
SELECT  HOSPEDE_ID, NOME, CPF, CRIADO_EM
FROM    HTL_HOSPEDE
WHERE   EXTRACT(YEAR FROM CRIADO_EM) = 2025 AND
        EXTRACT(MONTH FROM CRIADO_EM) = 10
ORDER BY CRIADO_EM DESC;
*/
-- ==========================================
-- EXCEPTIONS (Descomente para usar em produção)
-- ==========================================
/*
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK; -- Reverte a transação
        DBMS_OUTPUT.PUT_LINE('ERRO: CPF já cadastrado!');
        RAISE_APPLICATION_ERROR(-20001, 'CPF já cadastrado.'); -- Mensagem para aplicação, da pra usar no java depois
        
    WHEN OTHERS THEN
        IF SQLCODE = -2291 THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO: Funcionário não encontrado.');
            RAISE_APPLICATION_ERROR(-20002, 'Funcionário inexistente (ID: ' || p_criado_por || ')');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO: ' || SQLERRM);
            RAISE_APPLICATION_ERROR(-20099, 'Erro ao adicionar hóspede: ' || SQLERRM);
        END IF;
-- Por que usar RAISE_APPLICATION_ERROR?
-- Permite retornar códigos de erro personalizados (-20001 a -20999) para a aplicação
-- POR EXEMPLO:
*/
/*
try {
    connection.call("HTL_SP_ADICIONAR_HOSPEDE", ...);
} catch (SQLException e) {
    if (e.getErrorCode() == 20001) {
        System.out.println("CPF duplicado! Tente outro.");
    } 
    else if (e.getErrorCode() == 20002) {
        System.out.println("Funcionário não existe!");
    }
}
*/
-- ==========================================
-- Final do TUTORIAL
-- ==========================================

END HTL_SP_ADICIONAR_HOSPEDE;




-- ==========================================
-- 2 - ADICIONAR QUARTO
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_ADICIONAR_QUARTO (
    p_identificador  IN VARCHAR2,
    p_tipo           IN VARCHAR2,
    p_valor_diaria   IN NUMBER,
    -- Parâmetro de SAÍDA para retornar o ID gerado
    p_quarto_id_out  OUT INTEGER 
)
AS
BEGIN
    INSERT INTO HTL_QUARTO (
        IDENTIFICADOR, TIPO, VALOR_DIARIA
    )
    VALUES (
        p_identificador, p_tipo, p_valor_diaria
    )
    -- CLÁUSULA RETURNING INTO: Captura o ID gerado pelo banco
    RETURNING QUARTO_ID INTO p_quarto_id_out;
    
    -- Precisa do SET SERVEROUTPUT ON; para funcionar
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Quarto adicionado com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Identificador: ' || p_identificador);
    DBMS_OUTPUT.PUT_LINE('Tipo: ' || p_tipo);
    DBMS_OUTPUT.PUT_LINE('Valor Diária: ' || p_valor_diaria);
    DBMS_OUTPUT.PUT_LINE('ID Gerado: ' || p_quarto_id_out);
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;

/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_ADICIONAR_QUARTO
-- ==========================================

-- Propósito: Inserir um novo quarto no sistema.
-- O campo INATIVO é omitido, pois usa o DEFAULT 0 (Ativo).

-- ==========================================
-- PARTE 1 - TESTE DE SUCESSO
-- Adiciona um novo quarto do tipo STANDARD com valor 250
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_novo_quarto_id INTEGER;
BEGIN
    HTL_SP_ADICIONAR_QUARTO(
        p_identificador  => '601',
        p_tipo           => 'STANDARD',
        p_valor_diaria   => 250,
        p_quarto_id_out  => v_novo_quarto_id -- Variável OUT
    );
    -- Usando o ID retornado para confirmar no bloco anônimo:
    DBMS_OUTPUT.PUT_LINE('Confirmação do Bloco: Quarto ' || v_novo_quarto_id || ' criado.');
END;

-- ==========================================
-- PARTE 2 - TESTE DE FALHA (Identificador Duplicado)
-- Tenta adicionar o quarto '101' novamente (que já existe no DML)
-- Este teste deve retornar o erro: ORA-20030: Identificador de quarto já existe.
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_novo_quarto_id INTEGER;
BEGIN
    HTL_SP_ADICIONAR_QUARTO(
        p_identificador  => '101', 
        p_tipo           => 'LUXO',
        p_valor_diaria   => 350,
        p_quarto_id_out  => v_novo_quarto_id
    );
END;

-- ==========================================
-- PARTE 3 - CONSULTAS EXEMPLO NA TABELA HTL_QUARTO
-- ==========================================

-- 1) Ver todos os quartos e seus valores
SELECT QUARTO_ID, IDENTIFICADOR, TIPO, VALOR_DIARIA, INATIVO
FROM HTL_QUARTO;

-- 2) Ver apenas os quartos ATIVOS e ordenar por identificador
SELECT QUARTO_ID, IDENTIFICADOR, TIPO, VALOR_DIARIA
FROM HTL_QUARTO
WHERE INATIVO = 0
ORDER BY IDENTIFICADOR;

-- 3) Consultar o valor de uma diária específica (ex: '201')
SELECT VALOR_DIARIA
FROM HTL_QUARTO
WHERE IDENTIFICADOR = '201';

-- 4) Contar quantos quartos de cada TIPO existem
SELECT TIPO, COUNT(*) AS QUANTIDADE
FROM HTL_QUARTO
GROUP BY TIPO
ORDER BY QUANTIDADE DESC;

*/
-- ==========================================
-- EXCEPTIONS (Descomente para usar em produção)
-- ==========================================
/*
EXCEPTION
    -- ORA-00001 (DUP_VAL_ON_INDEX): Identificador é UNIQUE e já existe
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('ERRO: Identificador de quarto (' || p_identificador || ') já existe.');
        RAISE_APPLICATION_ERROR(-20030, 'Identificador de quarto já existe.'); 
        
    -- Erro de Campo Obrigatório ou Valor Inválido
    WHEN OTHERS THEN
        IF SQLCODE = -1400 THEN -- ORA-01400: NOT NULL violada (ex: p_identificador NULL)
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO: Campo obrigatório faltando (NULL).');
            RAISE_APPLICATION_ERROR(-20031, 'Um campo obrigatório (Identificador, Tipo ou Valor Diária) não foi fornecido.');
        ELSIF SQLCODE = -2290 THEN -- ORA-02290: CHECK constraint violada (ex: INATIVO, embora não seja alterável aqui)
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO: Valor inválido para uma coluna.');
            RAISE_APPLICATION_ERROR(-20032, 'Valor inválido para uma coluna (verifique tipo de dados ou INATIVO).');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
            RAISE_APPLICATION_ERROR(-20099, 'Erro ao adicionar quarto: ' || SQLERRM);
        END IF;
*/
END HTL_SP_ADICIONAR_QUARTO;



-- ==========================================
-- 3 - MANUTENÇÃO QUARTO (ATIVAR/INATIVAR E ATUALIZAR DIÁRIA)
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_MANUTENCAO_QUARTO (
    p_quarto_id      IN INTEGER,
    p_novo_valor     IN NUMBER DEFAULT NULL, -- Novo valor da diária (opcional)
    p_inativo        IN NUMBER DEFAULT NULL  -- 0 para Ativar, 1 para Inativar (opcional)
)
AS
    v_valor_diaria_atual NUMBER(10,2);
    v_diaria_atualizada  BOOLEAN := FALSE;
    v_status_atualizado  BOOLEAN := FALSE;
BEGIN
    -- 1. Tenta atualizar o registro. O uso do NVL garante que se o parâmetro for NULL,
    -- o valor original da coluna é mantido (VALOR_DIARIA ou INATIVO).
    UPDATE HTL_QUARTO
    SET 
        VALOR_DIARIA = NVL(p_novo_valor, VALOR_DIARIA),
        INATIVO = NVL(p_inativo, INATIVO)
    WHERE QUARTO_ID = p_quarto_id
    RETURNING VALOR_DIARIA INTO v_valor_diaria_atual; -- Captura o novo valor após o UPDATE

    -- 2. Lógica de Feedback Simplificada
    
    -- Checa se a diária foi realmente alterada para o feedback
    IF p_novo_valor IS NOT NULL AND p_novo_valor <> v_valor_diaria_atual THEN
        v_diaria_atualizada := TRUE;
    END IF;

    -- Checa se o status foi realmente alterado para o feedback
    IF p_inativo IS NOT NULL THEN
        v_status_atualizado := TRUE;
    END IF;

    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Manutenção aplicada ao Quarto ID: ' || p_quarto_id);
    DBMS_OUTPUT.PUT_LINE('Status Atual: ' || CASE NVL(p_inativo, 9) WHEN 0 THEN 'ATIVO' WHEN 1 THEN 'INATIVO' ELSE 'Não Alterado' END);
    
    -- Mensagens de atualização
    IF v_diaria_atualizada THEN
        -- Saída simples, sem formatação de moeda complexa
        DBMS_OUTPUT.PUT_LINE('Valor Diária: Atualizado para R$ ' || v_valor_diaria_atual); 
    ELSE
        -- Retorna o valor que já estava na coluna se não foi alterado
        DBMS_OUTPUT.PUT_LINE('Valor Diária: R$ ' || v_valor_diaria_atual);
    END IF;

    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_MANUTENCAO_QUARTO
-- ==========================================

-- PRE-REQUISITO: Encontrar um ID e seus dados atuais
SELECT QUARTO_ID, IDENTIFICADOR, VALOR_DIARIA, INATIVO 
FROM HTL_QUARTO WHERE IDENTIFICADOR = '101'; 
-- (Supondo ID 1, Valor 220, INATIVO 0)

-- ==========================================
-- PARTE 1 - TESTE: Apenas INATIVAR o Quarto (ID 1)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_MANUTENCAO_QUARTO(
        p_quarto_id      => 1,
        p_novo_valor     => NULL, -- Não altera o valor
        p_inativo        => 1     -- Inativa (1)
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT VALOR_DIARIA, INATIVO FROM HTL_QUARTO WHERE QUARTO_ID = 1;


-- ==========================================
-- PARTE 2 - TESTE: Apenas Atualizar Diária (ID 1)
-- =posição: Inativo (1)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_MANUTENCAO_QUARTO(
        p_quarto_id      => 1,
        p_novo_valor     => 300,   -- Novo Valor (R$ 300,00)
        p_inativo        => NULL   -- Não altera o status
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT VALOR_DIARIA, INATIVO FROM HTL_QUARTO WHERE QUARTO_ID = 1;

-- ==========================================
-- PARTE 3 - TESTE DE FALHA: ID Inexistente
-- Deve retornar: ORA-01403: no data found (tratado na exception)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_MANUTENCAO_QUARTO(
        p_quarto_id      => 999,
        p_novo_valor     => 500,
        p_inativo        => 0
    );
END;

*/
-- ==========================================
-- EXCEPTIONS (Com foco no tratamento de não encontrado)
-- ==========================================
/*
EXCEPTION
    -- ORA-01403: NO DATA FOUND é retornado quando o RETURNING INTO não encontra linha.
    WHEN NO_DATA_FOUND THEN 
        ROLLBACK;
        -- Novo erro -20050 dedicado à manutenção de quarto
        RAISE_APPLICATION_ERROR(-20050, 'Quarto com ID ' || p_quarto_id || ' não encontrado para manutenção.');

    WHEN OTHERS THEN
        IF SQLCODE = -2290 THEN -- ORA-02290: CHECK constraint (p_inativo não é 0 ou 1)
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20051, 'Valor inválido. O status deve ser 0 (Ativo) ou 1 (Inativo).');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
            RAISE_APPLICATION_ERROR(-20099, 'Erro geral ao executar manutenção do quarto: ' || SQLERRM);
        END IF;
*/
END HTL_SP_MANUTENCAO_QUARTO;











-- ==========================================
-- 4 - ATUALIZAR DADOS DO HÓSPEDE
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_ATUALIZAR_HOSPEDE (
    p_hospede_id IN INTEGER,
    p_nome       IN VARCHAR2 DEFAULT NULL,
    p_cpf        IN VARCHAR2 DEFAULT NULL,
    p_telefone   IN VARCHAR2 DEFAULT NULL,
    p_email      IN VARCHAR2 DEFAULT NULL
)
AS  -- Variável para capturar o nome atualizado
    v_hospede_nome VARCHAR2(100); -- Para capturar o nome atualizado
BEGIN
    -- 1. Tenta atualizar o registro. Usando NVL para manter o valor original se o parâmetro for NULL.
    UPDATE HTL_HOSPEDE
    SET 
        NOME = NVL(p_nome, NOME),
        CPF = NVL(p_cpf, CPF),
        TELEFONE = NVL(p_telefone, TELEFONE),
        EMAIL = NVL(p_email, EMAIL)
    WHERE HOSPEDE_ID = p_hospede_id
    -- Captura o nome após a atualização para uso no feedback
    RETURNING NOME INTO v_hospede_nome; 

    -- 2. Lógica de Feedback Simplificada
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Hóspede ID ' || p_hospede_id || ' (' || v_hospede_nome || ') atualizado com sucesso!');
    
    IF p_cpf IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('CPF atualizado.');
    END IF;
    IF p_email IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Email atualizado.');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_ATUALIZAR_HOSPEDE
-- ==========================================

-- PRE-REQUISITO: Encontrar um ID e seus dados atuais (Ex: ID 1)
SELECT HOSPEDE_ID, NOME, CPF, TELEFONE, EMAIL FROM HTL_HOSPEDE WHERE NOME LIKE 'João%'; 
-- (Supondo ID 1)

-- ==========================================
-- PARTE 1 - TESTE: Atualiza Apenas Email e Telefone (ID 1)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_ATUALIZAR_HOSPEDE(
        p_hospede_id => 1,
        p_nome       => NULL,
        p_cpf        => NULL,
        p_telefone   => '5531998765432', -- Novo Telefone
        p_email      => 'joao.silva.novo@email.com' -- Novo Email
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT TELEFONE, EMAIL FROM HTL_HOSPEDE WHERE HOSPEDE_ID = 1;


-- ==========================================
-- PARTE 2 - TESTE: Atualiza Apenas o Nome (ID 1)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_ATUALIZAR_HOSPEDE(
        p_hospede_id => 1,
        p_nome       => 'João Silva Neto',
        p_cpf        => NULL,
        p_telefone   => NULL,
        p_email      => NULL
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT NOME FROM HTL_HOSPEDE WHERE HOSPEDE_ID = 1;

-- ==========================================
-- PARTE 3 - TESTE DE FALHA: ID Inexistente
-- Deve retornar: ORA-01403: no data found (tratado na exception)
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_ATUALIZAR_HOSPEDE(
        p_hospede_id => 9999,
        p_nome       => 'Teste Falha',
        p_cpf        => NULL
    );
END;
*/
-- ==========================================
-- EXCEPTIONS
-- ==========================================
/*
EXCEPTION
    -- ORA-01403: NO DATA FOUND é retornado quando o RETURNING INTO não encontra linha.
    WHEN NO_DATA_FOUND THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20070, 'Hóspede com ID ' || p_hospede_id || ' não encontrado para atualização.');

    -- ORA-00001 (DUP_VAL_ON_INDEX): Ex: Tentar mudar CPF para um que já existe
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20071, 'CPF ou Email fornecido já está registrado para outro hóspede.');
        
    -- Tratamento Geral
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Erro geral ao atualizar hóspede: ' || SQLERRM);
*/
END HTL_SP_ATUALIZAR_HOSPEDE;





-- ==========================================
-- 5 - ADICIONAR FUNCIONÁRIO (APENAS CADASTRO BÁSICO)
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_ADICIONAR_FUNCIONARIO (
    p_nome               IN VARCHAR2,
    p_email              IN VARCHAR2,
    p_senha              IN VARCHAR2,
    p_funcionario_id_out OUT INTEGER 
)
AS
BEGIN
    -- 1. Inserir o novo funcionário na HTL_FUNCIONARIO
    INSERT INTO HTL_FUNCIONARIO (
        NOME, EMAIL, SENHA
    )
    VALUES (
        p_nome, p_email, p_senha
    )
    RETURNING FUNCIONARIO_ID INTO p_funcionario_id_out;
    
    -- 2. Lógica de Feedback Simplificada
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Funcionário cadastrado com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Nome: ' || p_nome);
    DBMS_OUTPUT.PUT_LINE('Email: ' || p_email);
    DBMS_OUTPUT.PUT_LINE('ID Gerado: ' || p_funcionario_id_out);
    DBMS_OUTPUT.PUT_LINE('AVISO: Nenhuma função foi atribuída. Use HTL_SP_ATRIBUIR_FUNCAO.');
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_ADICIONAR_FUNCIONARIO
-- ==========================================

-- Propósito: Cadastrar um novo funcionário.

-- ==========================================
-- PARTE 1 - TESTE DE SUCESSO:
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_novo_func_id INTEGER;
BEGIN
    HTL_SP_ADICIONAR_FUNCIONARIO(
        p_nome               => 'Mariana Lima',
        p_email              => 'mariana.l@hotel.com',
        p_senha              => 'senha123',
        p_funcionario_id_out => v_novo_func_id
    );
    DBMS_OUTPUT.PUT_LINE('Confirmação do Bloco: Funcionário ' || v_novo_func_id || ' criado.');
END;

*/
-- [EXCEPTIONS do ADICIONAR FUNCIONARIO]
/*
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK; 
        RAISE_APPLICATION_ERROR(-20080, 'Erro de duplicidade: E-mail já cadastrado.'); 
        
    WHEN OTHERS THEN
        IF SQLCODE = -1400 THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20081, 'Campo obrigatório (Nome, Email ou Senha) faltando.');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
            RAISE_APPLICATION_ERROR(-20099, 'Erro ao cadastrar funcionário: ' || SQLERRM);
        END IF;
*/
END HTL_SP_ADICIONAR_FUNCIONARIO;



-- ==========================================
-- 6 - ATRIBUIR FUNÇÃO AO FUNCIONÁRIO (VINCULA OS IDs)
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_ATRIBUIR_FUNCAO (
    p_funcionario_id IN INTEGER,
    p_funcao_id      IN INTEGER
)
AS
    v_nome_func HTL_FUNCIONARIO.NOME%TYPE;
    v_nome_funcao HTL_FUNCAO.NAME%TYPE;
BEGIN
    -- 1. Captura NOME do Funcionário e NOME da Função para feedback e validação
    SELECT F.NOME, A.NAME 
    INTO v_nome_func, v_nome_funcao
    FROM HTL_FUNCIONARIO F, HTL_FUNCAO A
    WHERE F.FUNCIONARIO_ID = p_funcionario_id
      AND A.FUNCAO_ID = p_funcao_id;
    
    -- 2. Insere o vínculo na tabela de junção
    INSERT INTO HTL_FUNCIONARIO_FUNCAO (
        FUNCIONARIO_ID, FUNCAO_ID
    )
    VALUES (
        p_funcionario_id, p_funcao_id
    );

    -- 3. Lógica de Feedback Simplificada
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('Vínculo de Função criado com sucesso!');
    DBMS_OUTPUT.PUT_LINE('Funcionário: ' || v_nome_func || ' (ID: ' || p_funcionario_id || ')');
    DBMS_OUTPUT.PUT_LINE('Função Atribuída: ' || v_nome_funcao || ' (ID: ' || p_funcao_id || ')');
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_ATRIBUIR_FUNCAO
-- ==========================================

-- PRE-REQUISITO:
-- 1. Funcionário deve existir (ex: ID 1)
-- 2. Função deve existir (ex: ID 1 para 'GERENTE')

-- ==========================================
-- PARTE 1 - TESTE DE SUCESSO: Atribui a função
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    HTL_SP_ATRIBUIR_FUNCAO(
        p_funcionario_id => 1,
        p_funcao_id      => 1
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT F.NOME, A.NAME AS FUNCAO
FROM HTL_FUNCIONARIO_FUNCAO HF
JOIN HTL_FUNCIONARIO F ON HF.FUNCIONARIO_ID = F.FUNCIONARIO_ID
JOIN HTL_FUNCAO A ON HF.FUNCAO_ID = A.FUNCAO_ID
WHERE F.FUNCIONARIO_ID = 1;


-- ==========================================
-- PARTE 2 - TESTE DE FALHA: ID Inexistente ou Vínculo Duplicado
-- ==========================================
SET SERVEROUTPUT ON;
--
BEGIN
    -- Falha se o ID não existir ou se a combinação (1, 1) já tiver sido inserida
    HTL_SP_ATRIBUIR_FUNCAO(
        p_funcionario_id => 999,
        p_funcao_id      => 1
    );
END;
*/
-- ==========================================
-- EXCEPTIONS
-- ==========================================
/*
EXCEPTION
    -- ORA-01403: NO DATA FOUND é retornado se o SELECT INTO não encontrar Funcionario ou Funcao
    WHEN NO_DATA_FOUND THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20090, 'Funcionário ID ou Função ID fornecidos são inválidos/inexistentes.');

    -- ORA-00001 (DUP_VAL_ON_INDEX): Primary Key duplicada na tabela de junção
    WHEN DUP_VAL_ON_INDEX THEN 
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20091, 'O funcionário já possui esta função atribuída.');
        
    -- Tratamento Geral
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20099, 'Erro ao atribuir função: ' || SQLERRM);
*/
END HTL_SP_ATRIBUIR_FUNCAO;








-- ==========================================
-- 7 - CRIAR NOVA RESERVA
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_CRIAR_RESERVA (
    p_quarto_id          IN INTEGER,
    p_hospede_id         IN INTEGER,
    p_criado_por_func_id IN INTEGER,
    p_data_inicio        IN DATE,
    p_data_fim           IN DATE,
    p_reserva_id_out     OUT INTEGER
)
AS
    v_valor_diaria      NUMBER(10,2);
    v_valor_total       NUMBER(10,2);
    v_dias_reserva      INTEGER;
    v_status_conf_id    INTEGER; -- ID para o status 'AGUARDANDO CHECK-IN'
BEGIN
    -- 1. Buscar dados necessários: Valor da Diária do Quarto e ID do Status
    
    -- Busca o valor da diária. Se o ID do quarto for inválido, lança NO_DATA_FOUND
    SELECT VALOR_DIARIA INTO v_valor_diaria
    FROM HTL_QUARTO
    WHERE QUARTO_ID = p_quarto_id AND INATIVO = 0;
    
    -- Busca o ID do status 'AGUARDANDO CHECK-IN'
    SELECT RESERVA_STATUS_ID INTO v_status_conf_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'AGUARDANDO CHECK-IN';
    
    -- 2. Cálculos: Diárias e Valor Total
    -- O cálculo de datas deve ser feito em dias.
    v_dias_reserva := TRUNC(p_data_fim) - TRUNC(p_data_inicio);
    
    -- Se a data de fim for igual à de início, conta como 1 diária.
    IF v_dias_reserva = 0 THEN
        v_dias_reserva := 1;
    END IF;
    
    v_valor_total := v_valor_diaria * v_dias_reserva;
    
    -- 3. Inserir a Reserva
    INSERT INTO HTL_RESERVA (
        QUARTO_ID, HOSPEDE_ID, CRIADO_POR, RESERVA_STATUS_ID,
        VALOR_CONTRATADO, DATA_INICIO, DATA_FIM
    )
    VALUES (
        p_quarto_id, p_hospede_id, p_criado_por_func_id, v_status_conf_id,
        v_valor_total, p_data_inicio, p_data_fim
    )
    RETURNING RESERVA_ID INTO p_reserva_id_out;
    
    -- 4. Feedback
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('RESERVA CRIADA COM SUCESSO!');
    DBMS_OUTPUT.PUT_LINE('ID da Reserva: ' || p_reserva_id_out);
    DBMS_OUTPUT.PUT_LINE('Quarto: ' || p_quarto_id);
    DBMS_OUTPUT.PUT_LINE('Período: ' || TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || ' a ' || TO_CHAR(p_data_fim, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Valor Total: R$ ' || v_valor_total);
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_CRIAR_RESERVA
-- ==========================================

-- PRE-REQUISITO:
-- 1. Quarto ID 1 existe e está ATIVO.
-- 2. Hóspede ID 1 existe.
-- 3. Funcionário ID 1 existe.
-- 4. Status 'AGUARDANDO CHECK-IN' deve estar cadastrado em HTL_RESERVA_STATUS.

-- ==========================================
-- PARTE 1 - TESTE: Criação de uma reserva de 3 dias
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
    v_amanha DATE := TRUNC(SYSDATE) + 1;
    v_depois DATE := TRUNC(SYSDATE) + 4; -- 3 diárias (Amanhã ao dia 4)
BEGIN
    HTL_SP_CRIAR_RESERVA(
        p_quarto_id          => 1,
        p_hospede_id         => 1,
        p_criado_por_func_id => 1,
        p_data_inicio        => v_amanha,
        p_data_fim           => v_depois,
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- PARTE 1A - TESTE: Criação de uma reserva de 1 dias
-- ==========================================
SET SERVEROUTPUT ON;

DECLARE
    v_nova_reserva_id INTEGER;
    v_hoje DATE := TRUNC(SYSDATE);
    v_amanha DATE := TRUNC(SYSDATE) + 1;
BEGIN
    -- Cria uma reserva de 1 dia, que DEVE ter o status 'AGUARDANDO CHECK-IN'
    HTL_SP_CRIAR_RESERVA(
        p_quarto_id          => 1,
        p_hospede_id         => 1,
        p_criado_por_func_id => 1,
        p_data_inicio        => v_hoje,
        p_data_fim           => v_amanha,
        p_reserva_id_out     => v_nova_reserva_id
    );
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    DBMS_OUTPUT.PUT_LINE('RESERVA LIMPA CRIADA COM SUCESSO. ID: ' || v_nova_reserva_id);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;


-- VERIFICAÇÃO PÓS-INSERT
-- este comando abaixo deve ser executado APÓS rodar o bloco anônimo acima
-- para ver a reserva criada.
SELECT * FROM HTL_RESERVA WHERE RESERVA_ID = &v_nova_reserva_id;
*/
-- ==========================================
-- SELECT PRA VER STATUS DO QUARTO (DISPONIBILIDADE)
-- ==========================================
/*
SELECT q.QUARTO_ID, q.IDENTIFICADOR
FROM HTL_QUARTO q
WHERE q.QUARTO_ID = 1
    AND q.INATIVO = 0
    AND NOT EXISTS (
        SELECT 1 FROM HTL_RESERVA r
        WHERE r.QUARTO_ID = q.QUARTO_ID
            AND r.RESERVA_STATUS_ID IN (
                SELECT RESERVA_STATUS_ID FROM HTL_RESERVA_STATUS 
                WHERE STATUS IN ('AGUARDANDO CHECK-IN', 'OCUPADO')
            )
            AND r.DATA_INICIO <= DATE '2025-12-31'
            AND r.DATA_FIM >= DATE '2025-12-25'
  );
*/
-- ==========================================
-- EXCEPTIONS (Focada em NO_DATA_FOUND e regras de negócio)
-- ==========================================
/*
EXCEPTION
    -- Captura falhas na busca (Quarto, Hóspede, Funcionário, Status inválidos)
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20100, 'ID de Quarto, Hóspede, Funcionário ou Status "AGUARDANDO CHECK-IN" inválido/não encontrado. Verifique os IDs ou se o quarto está inativo.');

    -- Regra de negócio: Data Fim deve ser maior que Data Início
    WHEN OTHERS THEN
        IF p_data_fim < p_data_inicio THEN
            ROLLBACK;
            RAISE_APPLICATION_ERROR(-20101, 'Data Fim (' || TO_CHAR(p_data_fim, 'DD/MM/YYYY') || ') deve ser igual ou posterior à Data Início.');
        ELSE
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
            RAISE_APPLICATION_ERROR(-20199, 'Erro ao criar reserva: ' || SQLERRM);
        END IF;
*/

END HTL_SP_CRIAR_RESERVA;





-- ==========================================
-- 8 - REALIZAR CHECK-IN (Corrigido)
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_FAZER_CHECKIN (
    p_reserva_id IN INTEGER
)
AS
    v_aguardando_id INTEGER;
    v_ocupado_id    INTEGER;
    
    -- Correção do Ponto 1: Variáveis para RETURNING
    v_quarto_id     INTEGER;
    v_hospede_id    INTEGER;
    
    -- Correção do Ponto 5: Variável para Feedback do Quarto
    v_identificador_quarto HTL_QUARTO.IDENTIFICADOR%TYPE; 
    
    -- Variável para o Ponto 2
    v_reserva_existe INTEGER; 

    -- Ponto 3: Remoção do PRAGMA desnecessário
BEGIN
    -- 1. Obter IDs dos Status para validação e atualização
    -- Se um dos status não existir, lança NO_DATA_FOUND, que é tratada no final.
    SELECT RESERVA_STATUS_ID INTO v_aguardando_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'AGUARDANDO CHECK-IN';
    
    SELECT RESERVA_STATUS_ID INTO v_ocupado_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'OCUPADO';

    -- 2. Tenta atualizar a reserva APENAS se estiver AGUARDANDO CHECK-IN
    UPDATE HTL_RESERVA
    SET 
        CHECK_IN = SYSTIMESTAMP,
        RESERVA_STATUS_ID = v_ocupado_id,
        ATUALIZADO_EM = SYSTIMESTAMP
    WHERE 
        RESERVA_ID = p_reserva_id
        AND RESERVA_STATUS_ID = v_aguardando_id 
    -- Ponto 1: Corrigido para retornar o ID do Hóspede
    RETURNING QUARTO_ID, HOSPEDE_ID INTO v_quarto_id, v_hospede_id; 

    -- 3. Validação (Ponto 2: Lógica mais simples)
    IF SQL%ROWCOUNT = 0 THEN
        -- Verifica se a Reserva existe (mas estava no status errado)
        SELECT COUNT(*) INTO v_reserva_existe
        FROM HTL_RESERVA 
        WHERE RESERVA_ID = p_reserva_id;
        
        IF v_reserva_existe = 0 THEN
            -- Reserva não existe
            RAISE_APPLICATION_ERROR(-20111, 'Reserva ID ' || p_reserva_id || ' não encontrada.');
        ELSE
            -- Reserva existe, mas não está AGUARDANDO CHECK-IN
            RAISE_APPLICATION_ERROR(-20110, 'A Reserva ID ' || p_reserva_id || ' não está no status "AGUARDANDO CHECK-IN". Status atual é incorreto para Check-in.');
        END IF;
    END IF;

    -- 4. Inserir no Histórico de Status (Ponto 4)
    INSERT INTO HTL_RESERVA_STATUS_HIST (
        RESERVA_STATUS_ID, RESERVA_ID, STATUS_EM
    )
    VALUES (
        v_ocupado_id, p_reserva_id, SYSTIMESTAMP
    );

    -- 5. Buscar o IDENTIFICADOR do Quarto para Feedback (Ponto 5)
    SELECT IDENTIFICADOR INTO v_identificador_quarto
    FROM HTL_QUARTO
    WHERE QUARTO_ID = v_quarto_id;

    -- 6. Feedback
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('CHECK-IN REALIZADO COM SUCESSO!');
    DBMS_OUTPUT.PUT_LINE('Reserva ID: ' || p_reserva_id);
    DBMS_OUTPUT.PUT_LINE('Quarto: ' || v_identificador_quarto); -- Uso da variável corrigida
    DBMS_OUTPUT.PUT_LINE('Novo Status: OCUPADO');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    COMMIT;
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_FAZER_CHECKIN
-- ==========================================

-- PRE-REQUISITO:
-- 1. Uma reserva deve existir (ex: ID 1) e estar em status 'AGUARDANDO CHECK-IN' (ex: STATUS_ID 1).
-- 2. Status 'OCUPADO' deve estar cadastrado (ex: STATUS_ID 2).

-- ==========================================
-- PARTE 1 - TESTE: Realiza Check-in na Reserva 1
-- ==========================================
SET SERVEROUTPUT ON;

-- VERIFICAÇÃO PRÉ-UPDATE
SELECT R.RESERVA_ID, RS.STATUS
FROM HTL_RESERVA R
JOIN HTL_RESERVA_STATUS RS ON R.RESERVA_STATUS_ID = RS.RESERVA_STATUS_ID
WHERE R.RESERVA_ID = 1;

BEGIN
    HTL_SP_FAZER_CHECKIN(
        p_reserva_id => 1   -- ID da reserva que está AGUARDANDO CHECK-IN vai ficar marcado como OCUPADO
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT CHECK_IN, R.RESERVA_STATUS_ID, RS.STATUS
FROM HTL_RESERVA R
JOIN HTL_RESERVA_STATUS RS ON R.RESERVA_STATUS_ID = RS.RESERVA_STATUS_ID
WHERE RESERVA_ID = 1;
*/

-- ==========================================
-- EXCEPTIONS
-- ==========================================
/*
EXCEPTION
    -- Captura falhas na busca dos status (Se 'AGUARDANDO CHECK-IN' ou 'OCUPADO' não estiverem cadastrados)
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20112, 'Os status "AGUARDANDO CHECK-IN" ou "OCUPADO" não estão cadastrados na tabela HTL_RESERVA_STATUS. Ajuste o seed data.');
        
    -- Captura o erro específico lançado no passo 3
    WHEN e_reserva_invalida THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20110, SQLERRM);
        
    -- Tratamento Geral
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20199, 'Erro ao realizar Check-in: ' || SQLERRM);
*/
END HTL_SP_FAZER_CHECKIN;





-- ==========================================
-- 9 - REALIZAR CHECK-OUT (Finaliza a Ocupação)
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_FAZER_CHECKOUT (
    p_reserva_id IN INTEGER
)
AS
    v_ocupado_id    INTEGER;       -- ID do status 'OCUPADO' (para validação)
    v_finalizado_id INTEGER;    -- ID do status 'FINALIZADO' (para atualização)
    
    -- Variáveis para RETURNING (para feedback e histórico)
    v_quarto_id     INTEGER;
    v_hospede_id    INTEGER;
    
    -- Variável para Feedback do Quarto
    v_identificador_quarto HTL_QUARTO.IDENTIFICADOR%TYPE; 
    
    -- Variável para validação de existência
    v_reserva_existe INTEGER; 
    
    -- Remoção das declarações desnecessárias de EXCEPTION/PRAGMA
BEGIN
    -- 1. Obter IDs dos Status
    -- Busca os IDs para garantir que os status existem na tabela e para uso no UPDATE/INSERT.
    SELECT RESERVA_STATUS_ID INTO v_ocupado_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'OCUPADO';
    
    SELECT RESERVA_STATUS_ID INTO v_finalizado_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'FINALIZADO';
    
    -- 2. Tenta atualizar a reserva APENAS se estiver OCUPADO
    UPDATE HTL_RESERVA
    SET 
        CHECK_OUT = SYSTIMESTAMP,       -- Registra a hora exata do Check-out
        RESERVA_STATUS_ID = v_finalizado_id, -- Atualiza para FINALIZADO
        ATUALIZADO_EM = SYSTIMESTAMP
    WHERE 
        RESERVA_ID = p_reserva_id
        AND RESERVA_STATUS_ID = v_ocupado_id -- Condição crucial: deve estar OCUPADO
    RETURNING QUARTO_ID, HOSPEDE_ID INTO v_quarto_id, v_hospede_id; 

    -- 3. Validação: Checa se a linha foi atualizada (SQL%ROWCOUNT = 0)
    IF SQL%ROWCOUNT = 0 THEN
        -- Verifica se a Reserva existe (mas estava no status errado)
        SELECT COUNT(*) INTO v_reserva_existe
        FROM HTL_RESERVA 
        WHERE RESERVA_ID = p_reserva_id;
        
        IF v_reserva_existe = 0 THEN
            -- Caso 1: Reserva não existe (-20121)
            RAISE_APPLICATION_ERROR(-20121, 'Reserva ID ' || p_reserva_id || ' não encontrada.');
        ELSE
            -- Caso 2: Reserva existe, mas não está OCUPADO (-20120)
            RAISE_APPLICATION_ERROR(-20120, 'A Reserva ID ' || p_reserva_id || ' não está no status "OCUPADO". Status atual é incorreto para Check-out.'); 
        END IF;
    END IF;

    -- 4. Inserir no Histórico de Status (Rastreabilidade)
    INSERT INTO HTL_RESERVA_STATUS_HIST (
        RESERVA_STATUS_ID, RESERVA_ID, STATUS_EM
    )
    VALUES (
        v_finalizado_id, p_reserva_id, SYSTIMESTAMP
    );

    -- 5. Buscar o IDENTIFICADOR do Quarto para Feedback
    SELECT IDENTIFICADOR INTO v_identificador_quarto
    FROM HTL_QUARTO
    WHERE QUARTO_ID = v_quarto_id;

    -- 6. Feedback
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('CHECK-OUT REALIZADO COM SUCESSO!');
    DBMS_OUTPUT.PUT_LINE('Reserva ID: ' || p_reserva_id);
    DBMS_OUTPUT.PUT_LINE('Quarto: ' || v_identificador_quarto);
    DBMS_OUTPUT.PUT_LINE('Novo Status: FINALIZADO');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_FAZER_CHECKOUT
-- ==========================================

-- PRE-REQUISITO:
-- 1. Uma reserva deve existir (ex: ID 2) e estar em status 'OCUPADO'.
-- 2. Status 'FINALIZADO' deve estar cadastrado em HTL_RESERVA_STATUS.

-- ==========================================
-- PARTE 1 - TESTE: Realiza Check-out
-- ==========================================
SET SERVEROUTPUT ON;

-- VERIFICAÇÃO PRÉ-UPDATE
-- O ID da reserva (ex: 2) deve mostrar STATUS = 'OCUPADO' e CHECK_IN preenchido.
SELECT R.RESERVA_ID, RS.STATUS, R.CHECK_IN, R.CHECK_OUT
FROM HTL_RESERVA R
JOIN HTL_RESERVA_STATUS RS ON R.RESERVA_STATUS_ID = RS.RESERVA_STATUS_ID
WHERE R.RESERVA_ID = 2; 

BEGIN
    HTL_SP_FAZER_CHECKOUT(
        p_reserva_id => 2 -- Use o ID que está OCUPADO
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
-- Deve mostrar STATUS = 'FINALIZADO' e CHECK_OUT preenchido com a hora atual.
SELECT R.RESERVA_ID, RS.STATUS, R.CHECK_IN, R.CHECK_OUT
FROM HTL_RESERVA R
JOIN HTL_RESERVA_STATUS RS ON R.RESERVA_STATUS_ID = RS.RESERVA_STATUS_ID
WHERE RESERVA_ID = 2;
*/

-- ==========================================
-- EXCEPTIONS
-- ==========================================
/*
EXCEPTION
    -- ORA-01403: NO DATA FOUND é retornado se os Status IDs ('OCUPADO' ou 'FINALIZADO') não forem encontrados.
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20122, 'Os status "OCUPADO" ou "FINALIZADO" não estão cadastrados na tabela HTL_RESERVA_STATUS. Ajuste o seed data.');
        
    -- Tratamento Geral, que captura também os erros -20120 e -20121 lançados no corpo do código.
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        -- Re-lança o erro original, seja ele -20120, -20121, ou um erro inesperado do banco.
        RAISE_APPLICATION_ERROR(-20199, 'Erro ao realizar Check-out: ' || SQLERRM);
*/
END HTL_SP_FAZER_CHECKOUT;




-- ==========================================
-- 10 - CANCELAR RESERVA
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_CANCELAR_RESERVA (
    p_reserva_id IN INTEGER
)
AS
    v_cancelado_id      INTEGER;
    v_aguardando_id     INTEGER;
    v_ocupado_id        INTEGER;
    
    -- Variável que guardará o status atual para validação
    v_status_atual_id   INTEGER; 
        
    v_quarto_id         INTEGER;
    v_hospede_id        INTEGER;
    v_identificador_quarto HTL_QUARTO.IDENTIFICADOR%TYPE; 
    
    -- v_reserva_existe removida (Ponto 1)
BEGIN
    -- 1. Obter IDs dos Status necessários
    SELECT RESERVA_STATUS_ID INTO v_cancelado_id
    FROM HTL_RESERVA_STATUS WHERE STATUS = 'CANCELADO';
    
    SELECT RESERVA_STATUS_ID INTO v_aguardando_id
    FROM HTL_RESERVA_STATUS WHERE STATUS = 'AGUARDANDO CHECK-IN';
    
    SELECT RESERVA_STATUS_ID INTO v_ocupado_id
    FROM HTL_RESERVA_STATUS WHERE STATUS = 'OCUPADO';
    
    
    -- 2. Validar ANTES: Verificar se a reserva existe e pegar o status atual
    BEGIN
        SELECT RESERVA_STATUS_ID INTO v_status_atual_id
        FROM HTL_RESERVA
        WHERE RESERVA_ID = p_reserva_id;
        
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Erro -20131: Reserva não existe (Tratado aqui, não no bloco final)
            RAISE_APPLICATION_ERROR(-20131, 'Reserva ID ' || p_reserva_id || ' não encontrada.');
    END;
        
    -- 3. Verificar se pode cancelar
    -- Permite cancelamento apenas se o status atual for AGUARDANDO CHECK-IN ou OCUPADO.
    IF v_status_atual_id NOT IN (v_aguardando_id, v_ocupado_id) THEN
        -- Erro -20130: Status não permite cancelamento
        RAISE_APPLICATION_ERROR(-20130, 'Reserva ID ' || p_reserva_id || ' não pode ser cancelada. Status atual não permite esta ação.');
    END IF;
        
    -- 4. UPDATE (agora sabemos que o status é válido e a linha existe)
    UPDATE HTL_RESERVA
    SET 
        RESERVA_STATUS_ID = v_cancelado_id,
        ATUALIZADO_EM = SYSTIMESTAMP
    WHERE 
        RESERVA_ID = p_reserva_id
    RETURNING QUARTO_ID, HOSPEDE_ID INTO v_quarto_id, v_hospede_id;
    

    -- 5. Inserir no Histórico de Status
    INSERT INTO HTL_RESERVA_STATUS_HIST (
        RESERVA_STATUS_ID, RESERVA_ID, STATUS_EM
    )
    VALUES (
        v_cancelado_id, p_reserva_id, SYSTIMESTAMP
    );

    -- 6. Buscar o IDENTIFICADOR do Quarto para Feedback
    SELECT IDENTIFICADOR INTO v_identificador_quarto
    FROM HTL_QUARTO
    WHERE QUARTO_ID = v_quarto_id;

    -- 7. Feedback
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('RESERVA CANCELADA COM SUCESSO!');
    DBMS_OUTPUT.PUT_LINE('Reserva ID: ' || p_reserva_id);
    DBMS_OUTPUT.PUT_LINE('Quarto: ' || v_identificador_quarto);
    DBMS_OUTPUT.PUT_LINE('Novo Status: CANCELADO');
    DBMS_OUTPUT.PUT_LINE('========================================');
    
    COMMIT;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_CANCELAR_RESERVA
-- ==========================================

-- PRE-REQUISITO:
-- 1. Uma reserva deve existir (ex: ID 3) e estar em status 'AGUARDANDO CHECK-IN' ou 'OCUPADO'.

-- PARTE 1 - TESTE: Cancela uma Reserva
SET SERVEROUTPUT ON;

-- Suponha que a Reserva 3 esteja AGUARDANDO CHECK-IN
BEGIN
    HTL_SP_CANCELAR_RESERVA(
        p_reserva_id => 3
    );
END;

-- VERIFICAÇÃO PÓS-UPDATE
SELECT R.RESERVA_ID, RS.STATUS
FROM HTL_RESERVA R
JOIN HTL_RESERVA_STATUS RS ON R.RESERVA_STATUS_ID = RS.RESERVA_STATUS_ID
WHERE R.RESERVA_ID = 3;
*/

-- ==========================================
-- EXCEPTIONS
-- ==========================================

/* (Ponto 2: Bloco EXCEPTION comentado)
EXCEPTION
    -- ORA-01403: NO DATA FOUND é retornado APENAS se algum dos Status IDs na busca inicial (passo 1) não for encontrado. (Ponto 3: Comentário ajustado)
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        RAISE_APPLICATION_ERROR(-20132, 'Um dos status necessários ("CANCELADO", "AGUARDANDO CHECK-IN" ou "OCUPADO") não está cadastrado. Ajuste o seed data.');
        
    -- Tratamento Geral, que captura também os erros -20130 e -20131.
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        RAISE_APPLICATION_ERROR(-20199, 'Erro ao cancelar reserva: ' || SQLERRM);
*/
END HTL_SP_CANCELAR_RESERVA;








-- ==========================================
-- 11 - CALCULAR DIÁRIAS (HTL_SF_CALCULAR_DIARIAS)
-- Objetivo: Retorna o número de diárias (noites) entre p_data_inicio e p_data_fim.
-- ==========================================
CREATE OR REPLACE FUNCTION HTL_SF_CALCULAR_DIARIAS (
    p_data_inicio IN DATE,
    p_data_fim    IN DATE
)
RETURN INTEGER
IS
    v_diarias INTEGER;
BEGIN
    -- 1. Validação Básica: Checa se alguma data de entrada é nula.
    IF p_data_fim IS NULL OR p_data_inicio IS NULL THEN
        RETURN 0; 
    END IF;

    -- 2. Cálculo da Diferença de Dias (Diárias)
    -- TRUNC() remove a parte da hora, garantindo que a diferença seja exata em dias (noites).
    v_diarias := TRUNC(p_data_fim) - TRUNC(p_data_inicio);

    -- 3. Validação Adicional: Garante que o número de diárias seja positivo.
    -- Se a data final for anterior ou igual à inicial (estadia de 0 ou -X dias), retorna 0.
    IF v_diarias <= 0 THEN
        RETURN 0; 
    END IF;
    RETURN v_diarias;
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SF_CALCULAR_DIARIAS
-- (Testes alinhados com a sua base de 2025)
-- ==========================================
SET SERVEROUTPUT ON;

-- EXEMPLO 1: Cálculo de 2 diárias da Reserva 1 (15/09 a 17/09)
SELECT 
    HTL_SF_CALCULAR_DIARIAS(
        p_data_inicio => DATE '2025-09-15',
        p_data_fim    => DATE '2025-09-17'
    ) AS DIARIAS_RESERVA_1
FROM DUAL; 
-- Resultado esperado: 2

-- EXEMPLO 2: Cálculo de 4 diárias da Reserva 2 (22/09 a 26/09)
SELECT 
    HTL_SF_CALCULAR_DIARIAS(
        p_data_inicio => DATE '2025-09-22',
        p_data_fim    => DATE '2025-09-26'
    ) AS DIARIAS_RESERVA_2
FROM DUAL;
-- Resultado esperado: 4

-- EXEMPLO 3: Teste de datas inválidas (data fim anterior à data início)
SELECT 
    HTL_SF_CALCULAR_DIARIAS(
        p_data_inicio => DATE '2025-09-30',
        p_data_fim    => DATE '2025-09-29'
    ) AS DIARIAS_INVALIDAS
FROM DUAL;
-- Resultado esperado: 0
*/

END HTL_SF_CALCULAR_DIARIAS;



-- ==========================================
-- 12 - VERIFICAR QUARTO DISPONÍVEL (HTL_SF_VERIFICAR_QUARTO_DISPONIVEL)
-- Objetivo: Retorna 1 se o quarto estiver DISPONÍVEL, 0 se estiver OCUPADO/INATIVO no período.
-- ==========================================
CREATE OR REPLACE FUNCTION HTL_SF_VERIFICAR_QUARTO_DISPONIVEL (
    p_quarto_id   IN INTEGER,
    p_data_inicio IN DATE,
    p_data_fim    IN DATE
)
RETURN INTEGER
IS
    v_quarto_inativo INTEGER;
    v_conflito_existe INTEGER;
BEGIN
    -- 1. Verificação de existência e status INATIVO do Quarto
    BEGIN
        SELECT 
            INATIVO INTO v_quarto_inativo
        FROM 
            HTL_QUARTO
        WHERE 
            QUARTO_ID = p_quarto_id;

        IF v_quarto_inativo = 1 THEN
            RETURN 0; -- Quarto inativo = indisponível
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN 0; -- Quarto não existe = indisponível
    END;

    -- 2. Tenta encontrar uma reserva ATIVA que conflite com o período de busca.
    SELECT 
        COUNT(1) INTO v_conflito_existe
    FROM 
        HTL_RESERVA r
    WHERE 
        r.QUARTO_ID = p_quarto_id
        
        -- Filtra apenas status que bloqueiam o quarto (Ativas)
        AND r.RESERVA_STATUS_ID IN (
            SELECT RESERVA_STATUS_ID 
            FROM HTL_RESERVA_STATUS 
            WHERE STATUS IN ('AGUARDANDO CHECK-IN', 'OCUPADO')
        )
        
        -- 3. Lógica de Sobreposição de Datas (CORREÇÃO FINAL: TRUNC() + <= e >=)
        -- O TRUNC() resolve o conflito de hora (TIMESTAMP) e a lógica garante o bloqueio no check-out.
        AND TRUNC(r.DATA_INICIO) <= TRUNC(p_data_fim)
        AND TRUNC(r.DATA_FIM) >= TRUNC(p_data_inicio);

    -- 4. Retorno Lógico
    IF v_conflito_existe > 0 THEN
        RETURN 0; -- Conflito encontrado = INDISPONÍVEL
    ELSE
        RETURN 1; -- Nenhum conflito = DISPONÍVEL
    END IF;
    
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SF_VERIFICAR_QUARTO_DISPONIVEL
-- (COM IDS CORRIGIDOS BASEADOS NA ORDEM DE INSERÇÃO)
-- ==========================================

SELECT COUNT(1)
FROM HTL_RESERVA r
WHERE r.QUARTO_ID = 3
AND r.RESERVA_STATUS_ID IN (
    SELECT RESERVA_STATUS_ID 
    FROM HTL_RESERVA_STATUS 
    WHERE STATUS IN ('AGUARDANDO CHECK-IN', 'OCUPADO')
)
AND TRUNC(r.DATA_INICIO) <= TRUNC(DATE '2025-09-24')
AND TRUNC(r.DATA_FIM) >= TRUNC(DATE '2025-09-23');



SET SERVEROUTPUT ON;

-- MAPEAMENTO CORRIGIDO:
-- Quarto '201' (Reserva Fernanda: 22/09 a 26/09) -> QUARTO_ID = 3
-- Quarto '202' (Reserva Pedro: 25/09 a 28/09)   -> QUARTO_ID = 4

-- EXEMPLO 1: Teste de Conflito Interno (Resultado Esperado: 0)
-- Busca (23/09 a 24/09), dentro da reserva do Quarto '201' (ID 3).
SELECT 
    HTL_SF_VERIFICAR_QUARTO_DISPONIVEL(
        p_quarto_id   => 3, -- ID CORRETO para Quarto '201'
        p_data_inicio => DATE '2025-09-23', 
        p_data_fim    => DATE '2025-09-24'
    ) AS DISPONIBILIDADE_CONFLITO
FROM DUAL;
-- Resultado esperado: 0

-- EXEMPLO 2: Teste de Período Livre (Resultado Esperado: 1)
-- Busca (27/09 a 30/09), após a reserva do Quarto '201' (ID 3).
SELECT 
    HTL_SF_VERIFICAR_QUARTO_DISPONIVEL(
        p_quarto_id   => 3, -- ID CORRETO para Quarto '201'
        p_data_inicio => DATE '2025-09-27',
        p_data_fim    => DATE '2025-09-30'
    ) AS DISPONIBILIDADE_LIVRE
FROM DUAL;
-- Resultado esperado: 1

-- EXEMPLO 3: Teste de Conflito no Limite (Resultado Esperado: 0)
-- Busca (28/09 a 30/09), tocando o check-out do Quarto '202' (ID 4, reserva até 28/09).
SELECT 
    HTL_SF_VERIFICAR_QUARTO_DISPONIVEL(
        p_quarto_id   => 4, -- ID CORRETO para Quarto '202'
        p_data_inicio => DATE '2025-09-28',
        p_data_fim    => DATE '2025-09-30'
    ) AS DISPONIBILIDADE_LIMITE
FROM DUAL;
-- Resultado esperado: 0
*/

END HTL_SF_VERIFICAR_QUARTO_DISPONIVEL;






-- ==========================================
-- 13 - MÉDIA DE PREÇO POR TIPO (HTL_SF_MEDIA_PRECO_TIPO)
-- Objetivo: Calcula métricas (média, mínimo, máximo, contagem) do VALOR_DIARIA 
-- para quartos ATIVOS de um tipo, com opção de filtrar por disponibilidade em um período.
-- Retorna um record com: media_diaria, qtd_quartos, min_diaria, max_diaria.
-- ==========================================
CREATE OR REPLACE FUNCTION HTL_SF_MEDIA_PRECO_TIPO (
    p_tipo_quarto IN HTL_QUARTO.TIPO%TYPE,
    p_data_inicio IN DATE DEFAULT NULL,
    p_data_fim IN DATE DEFAULT NULL
)
RETURN HTL_TIPO_QUARTO_METRICAS
IS
    v_metricas HTL_TIPO_QUARTO_METRICAS := HTL_TIPO_QUARTO_METRICAS(0, 0, 0, 0);
    v_tipo_existe INTEGER;
BEGIN
    -- 1. Verifica se o tipo de quarto existe
    SELECT COUNT(1) INTO v_tipo_existe
    FROM HTL_QUARTO
    WHERE TIPO = p_tipo_quarto;

    IF v_tipo_existe = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Tipo de quarto "' || p_tipo_quarto || '" não existe.');
    END IF;

    -- 2. Calcula métricas para quartos ATIVOS (INATIVO = 0)
    -- Se p_data_inicio e p_data_fim forem fornecidos, considera apenas quartos disponíveis
    IF p_data_inicio IS NULL OR p_data_fim IS NULL THEN
        -- Sem filtro de data: todos os quartos ativos do tipo
        SELECT 
            NVL(AVG(q.VALOR_DIARIA), 0),
            COUNT(1),
            NVL(MIN(q.VALOR_DIARIA), 0),
            NVL(MAX(q.VALOR_DIARIA), 0)
        INTO 
            v_metricas.media_diaria,
            v_metricas.qtd_quartos,
            v_metricas.min_diaria,
            v_metricas.max_diaria
        FROM 
            HTL_QUARTO q
        WHERE 
            q.TIPO = p_tipo_quarto
            AND q.INATIVO = 0;
    ELSE
        -- Com filtro de data: apenas quartos sem reservas ativas no período
        SELECT 
            NVL(AVG(q.VALOR_DIARIA), 0),
            COUNT(1),
            NVL(MIN(q.VALOR_DIARIA), 0),
            NVL(MAX(q.VALOR_DIARIA), 0)
        INTO 
            v_metricas.media_diaria,
            v_metricas.qtd_quartos,
            v_metricas.min_diaria,
            v_metricas.max_diaria
        FROM 
            HTL_QUARTO q
        WHERE 
            q.TIPO = p_tipo_quarto
            AND q.INATIVO = 0
            AND NOT EXISTS (
                SELECT 1
                FROM HTL_RESERVA r
                WHERE r.QUARTO_ID = q.QUARTO_ID
                AND r.RESERVA_STATUS_ID IN (
                    SELECT RESERVA_STATUS_ID 
                    FROM HTL_RESERVA_STATUS 
                    WHERE STATUS IN ('AGUARDANDO CHECK-IN', 'OCUPADO')
                )
                AND TRUNC(r.DATA_INICIO) <= TRUNC(p_data_fim)
                AND TRUNC(r.DATA_FIM) >= TRUNC(p_data_inicio)
            );
    END IF;

    -- 3. Retorna o record com as métricas
    RETURN v_metricas;

/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SF_MEDIA_PRECO_TIPO
-- Objetivo: Demonstra usos práticos para relatórios e tomada de decisão.
-- Execute após criar o tipo HTL_TIPO_QUARTO_METRICAS e a função HTL_SF_MEDIA_PRECO_TIPO.
-- ==========================================
SET SERVEROUTPUT ON;

-- ==========================================
-- VISUALIZAÇÃO SIMPLES: RELATÓRIO DE PREÇOS MÉDIOS POR TIPO DE QUARTO
-- Objetivo: Exibe um relatório com média, quantidade, mínimo e máximo de diárias
-- para todos os tipos de quarto, usando DBMS_OUTPUT para fácil leitura.
-- ==========================================
SET SERVEROUTPUT ON;

-- exemplo de relatório completo

DECLARE
    CURSOR c_tipos IS
        SELECT DISTINCT TIPO
        FROM HTL_QUARTO
        ORDER BY TIPO;
    v_metricas HTL_TIPO_QUARTO_METRICAS;
BEGIN
    -- Cabeçalho do relatório
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO DE PREÇOS POR TIPO DE QUARTO');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('TIPO', 15) || RPAD('MÉDIA DIÁRIA', 15) || 
                         RPAD('QTD QUARTOS', 15) || RPAD('MÍNIMO', 10) || 'MÁXIMO');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');

    -- Loop pelos tipos de quarto
    FOR r_tipo IN c_tipos LOOP
        BEGIN
            v_metricas := HTL_SF_MEDIA_PRECO_TIPO(p_tipo_quarto => r_tipo.TIPO);
            DBMS_OUTPUT.PUT_LINE(
                RPAD(r_tipo.TIPO, 15) || 
                RPAD(TO_CHAR(v_metricas.media_diaria, 'FM9999990.00'), 15) || 
                RPAD(v_metricas.qtd_quartos, 15) || 
                RPAD(TO_CHAR(v_metricas.min_diaria, 'FM9999990.00'), 10) || 
                TO_CHAR(v_metricas.max_diaria, 'FM9999990.00')
            );
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Erro ao processar tipo ' || r_tipo.TIPO || ': ' || SQLERRM);
        END;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('-------------------------------------');
END;
/

-- EXEMPLO 0: Verificar erro para tipo inexistente
-- Demonstra tratamento de erro para um tipo de quarto que não existe no DML
DECLARE
    v_metricas HTL_TIPO_QUARTO_METRICAS;
BEGIN
    v_metricas := HTL_SF_MEDIA_PRECO_TIPO(p_tipo_quarto => 'EXECUTIVO');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
-- vai retornar que EXECUTE não existe

-- ==========================================   

-- EXEMPLO 1: Média de preço para quartos STANDARD (sem filtro de data)
-- Útil para relatórios gerais de preços por tipo
DECLARE
    v_metricas HTL_TIPO_QUARTO_METRICAS;
BEGIN
    v_metricas := HTL_SF_MEDIA_PRECO_TIPO(p_tipo_quarto => 'STANDARD');
    DBMS_OUTPUT.PUT_LINE('Tipo: STANDARD');
    DBMS_OUTPUT.PUT_LINE('Média Diária: ' || v_metricas.media_diaria);
    DBMS_OUTPUT.PUT_LINE('Quantidade de Quartos: ' || v_metricas.qtd_quartos);
    DBMS_OUTPUT.PUT_LINE('Mínima Diária: ' || v_metricas.min_diaria);
    DBMS_OUTPUT.PUT_LINE('Máxima Diária: ' || v_metricas.max_diaria);
END;
/

-- EXEMPLO 2: Média de preço para SUITE MASTER, considerando apenas quartos disponíveis em um período
-- Útil para verificar preços de quartos disponíveis para reservas futuras
DECLARE
    v_metricas HTL_TIPO_QUARTO_METRICAS;
BEGIN
    v_metricas := HTL_SF_MEDIA_PRECO_TIPO(
        p_tipo_quarto => 'SUITE MASTER',
        p_data_inicio => DATE '2025-09-27',
        p_data_fim => DATE '2025-09-30'
    );
    DBMS_OUTPUT.PUT_LINE('Tipo: SUITE MASTER (27/09 a 30/09)');
    DBMS_OUTPUT.PUT_LINE('Média Diária: ' || v_metricas.media_diaria);
    DBMS_OUTPUT.PUT_LINE('Quantidade de Quartos Disponíveis: ' || v_metricas.qtd_quartos);
    DBMS_OUTPUT.PUT_LINE('Mínima Diária: ' || v_metricas.min_diaria);
    DBMS_OUTPUT.PUT_LINE('Máxima Diária: ' || v_metricas.max_diaria);
END;
/

-- EXEMPLO 3: Relatório comparativo de todos os tipos de quarto
-- Útil para gerentes analisarem preços médios e disponibilidade
SELECT 
    q.TIPO,
    HTL_SF_MEDIA_PRECO_TIPO(q.TIPO).media_diaria AS MEDIA_DIARIA,
    HTL_SF_MEDIA_PRECO_TIPO(q.TIPO).qtd_quartos AS QTD_QUARTOS,
    HTL_SF_MEDIA_PRECO_TIPO(q.TIPO).min_diaria AS MIN_DIARIA,
    HTL_SF_MEDIA_PRECO_TIPO(q.TIPO).max_diaria AS MAX_DIARIA
FROM 
    (SELECT DISTINCT TIPO FROM HTL_QUARTO) q
ORDER BY MEDIA_DIARIA DESC;

-- EXEMPLO 4: Verificar erro para tipo inexistente
-- Demonstra tratamento de erro
DECLARE
    v_metricas HTL_TIPO_QUARTO_METRICAS;
BEGIN
    v_metricas := HTL_SF_MEDIA_PRECO_TIPO(p_tipo_quarto => 'PRESIDENCIAL');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Erro: ' || SQLERRM);
END;
*/

END HTL_SF_MEDIA_PRECO_TIPO;



-- ==========================================
-- TOTAL_SERVICOS_RESERVA (HTL_SF_TOTAL_SERVICOS_RESERVA)
-- Objetivo: Calcula o valor total dos serviços associados a uma reserva específica.
-- Retorna: NUMBER(10,2) com a soma dos VALOR em HTL_RESERVA_SERVICO para o RESERVA_ID.
-- Se a reserva não existir ou não tiver serviços, retorna 0.
-- ==========================================
CREATE OR REPLACE FUNCTION HTL_SF_TOTAL_SERVICOS_RESERVA (
    p_reserva_id IN HTL_RESERVA.RESERVA_ID%TYPE
)
RETURN NUMBER
IS
    v_total NUMBER(10,2);
    v_reserva_existe INTEGER;
BEGIN
    -- 1. Verifica se a reserva existe
    SELECT COUNT(1) INTO v_reserva_existe
    FROM HTL_RESERVA
    WHERE RESERVA_ID = p_reserva_id;

    IF v_reserva_existe = 0 THEN
        RETURN 0; -- Reserva não existe
    END IF;

    -- 2. Calcula o total dos serviços associados à reserva
    SELECT NVL(SUM(VALOR), 0) INTO v_total
    FROM HTL_RESERVA_SERVICO
    WHERE RESERVA_ID = p_reserva_id;

    RETURN v_total;
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SF_TOTAL_SERVICOS_RESERVA
-- Objetivo: Demonstra como calcular o total de serviços para reservas específicas.
-- Baseado no DML fornecido: reservas de Bruno (ID=1), Fernanda (ID=2), etc.
-- ==========================================
SET SERVEROUTPUT ON;

-- EXEMPLO 1: Total de serviços para a reserva de Bruno (quarto '101', ID=1)
DECLARE
    v_total NUMBER(10,2);
BEGIN
    v_total := HTL_SF_TOTAL_SERVICOS_RESERVA(p_reserva_id => 1);
    DBMS_OUTPUT.PUT_LINE('Total de serviços para Reserva ID=1 (Bruno, quarto 101): ' || v_total);
END;

-- Resultado esperado: 100.00 (Café da manhã: 35.00, Lavanderia: 25.00, Serviço de Quarto: 40.00)

-- EXEMPLO 2: Total de serviços para a reserva de Fernanda (quarto '201', ID=2)
DECLARE
    v_total NUMBER(10,2);
BEGIN
    v_total := HTL_SF_TOTAL_SERVICOS_RESERVA(p_reserva_id => 2);
    DBMS_OUTPUT.PUT_LINE('Total de serviços para Reserva ID=2 (Fernanda, quarto 201): ' || v_total);
END;

-- Resultado esperado: 250.00 (Spa: 180.00, Jantar: 70.00)

-- EXEMPLO 3: Total de serviços para uma reserva sem serviços (Pedro, quarto '202', ID=3)
DECLARE
    v_total NUMBER(10,2);
BEGIN
    v_total := HTL_SF_TOTAL_SERVICOS_RESERVA(p_reserva_id => 3);
    DBMS_OUTPUT.PUT_LINE('Total de serviços para Reserva ID=3 (Pedro, quarto 202): ' || v_total);
END;

-- Resultado esperado: 0.00 (sem serviços associados)

-- EXEMPLO 4: Total de serviços para uma reserva inexistente
DECLARE
    v_total NUMBER(10,2);
BEGIN
    v_total := HTL_SF_TOTAL_SERVICOS_RESERVA(p_reserva_id => 999);
    DBMS_OUTPUT.PUT_LINE('Total de serviços para Reserva ID=999 (inexistente): ' || v_total);
END;

-- Resultado esperado: 0.00 (reserva não existe)

-- EXEMPLO 5: Relatório de serviços por reserva (todas as reservas)
DECLARE
    CURSOR c_reservas IS
        SELECT r.RESERVA_ID, h.NOME, q.IDENTIFICADOR
        FROM HTL_RESERVA r
        JOIN HTL_HOSPEDE h ON h.HOSPEDE_ID = r.HOSPEDE_ID
        JOIN HTL_QUARTO q ON q.QUARTO_ID = r.QUARTO_ID
        ORDER BY r.RESERVA_ID;
    v_total NUMBER(10,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE('RELATÓRIO DE SERVIÇOS POR RESERVA');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    DBMS_OUTPUT.PUT_LINE(RPAD('RESERVA_ID', 12) || RPAD('HÓSPEDE', 20) || 
                         RPAD('QUARTO', 10) || 'TOTAL SERVIÇOS');
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
    FOR r_reserva IN c_reservas LOOP
        v_total := HTL_SF_TOTAL_SERVICOS_RESERVA(r_reserva.RESERVA_ID);
        DBMS_OUTPUT.PUT_LINE(
            RPAD(r_reserva.RESERVA_ID, 12) ||
            RPAD(r_reserva.NOME, 20) ||
            RPAD(r_reserva.IDENTIFICADOR, 10) ||
            TO_CHAR(v_total, 'FM9999990.00')
        );
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('---------------------------------');
END;
*/
END HTL_SF_TOTAL_SERVICOS_RESERVA;

-- ==========================================
-- FIM DO SCRIPT DE PROCEDURES E FUNCTIONS
-- ==========================================



    /* um teste, não precisa compilar este de baixo
-- ==========================================
-- ==========================================
-- 15 - CRIAR RESERVA COM VALIDAÇÃO DE CONFLITOS
-- ==========================================
CREATE OR REPLACE PROCEDURE HTL_SP_CRIAR_RESERVA_VALIDADA (
    p_quarto_id          IN INTEGER,
    p_hospede_id         IN INTEGER,
    p_criado_por_func_id IN INTEGER,
    p_data_inicio        IN DATE,
    p_data_fim           IN DATE,
    p_reserva_id_out     OUT INTEGER
)
AS
    v_valor_diaria      NUMBER(10,2);
    v_valor_total       NUMBER(10,2);
    v_dias_reserva      INTEGER;
    v_status_conf_id    INTEGER; -- ID para o status 'AGUARDANDO CHECK-IN'
    v_quarto_disponivel INTEGER;
    v_quarto_identificador HTL_QUARTO.IDENTIFICADOR%TYPE;
BEGIN
    -- 1. VALIDAÇÃO: Data Fim deve ser maior que Data Início
    IF p_data_fim <= p_data_inicio THEN
        RAISE_APPLICATION_ERROR(-20200, 'Data Fim (' || TO_CHAR(p_data_fim, 'DD/MM/YYYY') || 
                                ') deve ser posterior à Data Início (' || TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || ').');
    END IF;
    
    -- 2. VALIDAÇÃO: Não permite reservas no passado
    IF TRUNC(p_data_inicio) < TRUNC(SYSDATE) THEN
        RAISE_APPLICATION_ERROR(-20201, 'Data Início (' || TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || 
                                ') não pode ser anterior à data atual (' || TO_CHAR(SYSDATE, 'DD/MM/YYYY') || ').');
    END IF;
    
    -- 3. VALIDAÇÃO: Verificar se o quarto existe e está ativo
    BEGIN
        SELECT VALOR_DIARIA, IDENTIFICADOR 
        INTO v_valor_diaria, v_quarto_identificador
        FROM HTL_QUARTO
        WHERE QUARTO_ID = p_quarto_id AND INATIVO = 0;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20202, 'Quarto ID ' || p_quarto_id || ' não encontrado ou está inativo.');
    END;
    
    -- 4. VALIDAÇÃO: Verificar se o hóspede existe
    BEGIN
        SELECT 1 INTO v_status_conf_id -- Reutiliza variável temporariamente
        FROM HTL_HOSPEDE
        WHERE HOSPEDE_ID = p_hospede_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20203, 'Hóspede ID ' || p_hospede_id || ' não encontrado.');
    END;
    
    -- 5. VALIDAÇÃO: Verificar se o funcionário existe
    BEGIN
        SELECT 1 INTO v_status_conf_id -- Reutiliza variável temporariamente
        FROM HTL_FUNCIONARIO
        WHERE FUNCIONARIO_ID = p_criado_por_func_id;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20204, 'Funcionário ID ' || p_criado_por_func_id || ' não encontrado.');
    END;
    
    -- 6. VALIDAÇÃO CRÍTICA: Verificar disponibilidade do quarto (usa a SF existente)
    v_quarto_disponivel := HTL_SF_VERIFICAR_QUARTO_DISPONIVEL(
        p_quarto_id   => p_quarto_id,
        p_data_inicio => p_data_inicio,
        p_data_fim    => p_data_fim
    );
    
    IF v_quarto_disponivel = 0 THEN
        RAISE_APPLICATION_ERROR(-20205, 'Quarto ' || v_quarto_identificador || 
                                ' (ID: ' || p_quarto_id || ') não está disponível no período de ' || 
                                TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || ' a ' || 
                                TO_CHAR(p_data_fim, 'DD/MM/YYYY') || '. Há conflito com outra reserva ativa.');
    END IF;
    
    -- 7. Buscar ID do status 'AGUARDANDO CHECK-IN'
    SELECT RESERVA_STATUS_ID INTO v_status_conf_id
    FROM HTL_RESERVA_STATUS
    WHERE STATUS = 'AGUARDANDO CHECK-IN';
    
    -- 8. Cálculos: Diárias e Valor Total
    v_dias_reserva := TRUNC(p_data_fim) - TRUNC(p_data_inicio);
    
    -- Se a data de fim for igual à de início, conta como 1 diária.
    IF v_dias_reserva = 0 THEN
        v_dias_reserva := 1;
    END IF;
    
    v_valor_total := v_valor_diaria * v_dias_reserva;
    
    -- 9. Inserir a Reserva
    INSERT INTO HTL_RESERVA (
        QUARTO_ID, HOSPEDE_ID, CRIADO_POR, RESERVA_STATUS_ID,
        VALOR_CONTRATADO, DATA_INICIO, DATA_FIM
    )
    VALUES (
        p_quarto_id, p_hospede_id, p_criado_por_func_id, v_status_conf_id,
        v_valor_total, p_data_inicio, p_data_fim
    )
    RETURNING RESERVA_ID INTO p_reserva_id_out;
    
    -- 10. Inserir no Histórico de Status (rastreabilidade)
    INSERT INTO HTL_RESERVA_STATUS_HIST (
        RESERVA_STATUS_ID, RESERVA_ID, STATUS_EM
    )
    VALUES (
        v_status_conf_id, p_reserva_id_out, SYSTIMESTAMP
    );
    
    -- 11. Feedback
    DBMS_OUTPUT.PUT_LINE('========================================');
    DBMS_OUTPUT.PUT_LINE('RESERVA CRIADA COM SUCESSO!');
    DBMS_OUTPUT.PUT_LINE('ID da Reserva: ' || p_reserva_id_out);
    DBMS_OUTPUT.PUT_LINE('Quarto: ' || v_quarto_identificador || ' (ID: ' || p_quarto_id || ')');
    DBMS_OUTPUT.PUT_LINE('Período: ' || TO_CHAR(p_data_inicio, 'DD/MM/YYYY') || ' a ' || TO_CHAR(p_data_fim, 'DD/MM/YYYY'));
    DBMS_OUTPUT.PUT_LINE('Diárias: ' || v_dias_reserva);
    DBMS_OUTPUT.PUT_LINE('Valor Total: R$ ' || TO_CHAR(v_valor_total, 'FM9999990.00'));
    DBMS_OUTPUT.PUT_LINE('========================================');

    COMMIT;
    */
/*
-- ==========================================
-- TUTORIAL DE USO: HTL_SP_CRIAR_RESERVA_VALIDADA
-- ==========================================

-- CENÁRIO DE TESTE: Baseado no DML, sabemos que:
-- Quarto '201' (ID=3) tem reserva de Fernanda: 22/09 a 26/09, Status OCUPADO
-- Quarto '202' (ID=4) tem reserva de Pedro: 25/09 a 28/09, Status AGUARDANDO CHECK-IN

-- ==========================================
-- TESTE 1: SUCESSO - Reserva em período livre
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 1, -- Quarto '101' livre
        p_hospede_id         => 1, -- Bruno Almeida
        p_criado_por_func_id => 1, -- Maria Souza
        p_data_inicio        => DATE '2025-10-10',
        p_data_fim           => DATE '2025-10-12',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 2: FALHA - Conflito de Data (Sobreposição)
-- Tenta reservar o Quarto '201' em período que conflita com reserva de Fernanda
-- Erro esperado: ORA-20205
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 3, -- Quarto '201' (ocupado 22/09 a 26/09)
        p_hospede_id         => 3, -- Pedro Rocha
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-09-24', -- Conflita com Fernanda
        p_data_fim           => DATE '2025-09-27',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 3: FALHA - Data Fim antes da Data Início
-- Erro esperado: ORA-20200
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 1,
        p_hospede_id         => 1,
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-10-15',
        p_data_fim           => DATE '2025-10-10', -- Antes do início!
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 4: FALHA - Reserva no Passado
-- Erro esperado: ORA-20201
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 1,
        p_hospede_id         => 1,
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-09-01', -- Passado
        p_data_fim           => DATE '2025-09-03',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 5: FALHA - Quarto Inativo
-- Primeiro, inative um quarto:
-- UPDATE HTL_QUARTO SET INATIVO = 1 WHERE QUARTO_ID = 9; -- Suite Master 502
-- Erro esperado: ORA-20202
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 9, -- Quarto inativo
        p_hospede_id         => 1,
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-10-20',
        p_data_fim           => DATE '2025-10-22',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 6: FALHA - Hóspede Inexistente
-- Erro esperado: ORA-20203
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 1,
        p_hospede_id         => 999, -- ID inexistente
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-10-20',
        p_data_fim           => DATE '2025-10-22',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- TESTE 7: SUCESSO - Reserva Exatamente Após Outra Terminar
-- Quarto '201' tem reserva até 26/09. Nova reserva começa em 27/09.
-- Este teste valida que a lógica de sobreposição está correta.
-- ==========================================
SET SERVEROUTPUT ON;
--
DECLARE
    v_nova_reserva_id INTEGER;
BEGIN
    HTL_SP_CRIAR_RESERVA_VALIDADA(
        p_quarto_id          => 3, -- Quarto '201'
        p_hospede_id         => 3, -- Pedro Rocha
        p_criado_por_func_id => 1,
        p_data_inicio        => DATE '2025-09-27', -- Dia seguinte ao check-out
        p_data_fim           => DATE '2025-09-30',
        p_reserva_id_out     => v_nova_reserva_id
    );
END;

-- ==========================================
-- QUERY DE VERIFICAÇÃO: Ver Conflitos
-- Use esta query para entender por que uma reserva foi bloqueada
-- ==========================================
SELECT 
    r.RESERVA_ID,
    q.IDENTIFICADOR AS QUARTO,
    h.NOME AS HOSPEDE,
    rs.STATUS,
    TO_CHAR(r.DATA_INICIO, 'DD/MM/YYYY') AS INICIO,
    TO_CHAR(r.DATA_FIM, 'DD/MM/YYYY') AS FIM
FROM HTL_RESERVA r
JOIN HTL_QUARTO q ON q.QUARTO_ID = r.QUARTO_ID
JOIN HTL_HOSPEDE h ON h.HOSPEDE_ID = r.HOSPEDE_ID
JOIN HTL_RESERVA_STATUS rs ON rs.RESERVA_STATUS_ID = r.RESERVA_STATUS_ID
WHERE 
    q.QUARTO_ID = 3 -- Substitua pelo ID do quarto que quer verificar
    AND rs.STATUS IN ('AGUARDANDO CHECK-IN', 'OCUPADO')
ORDER BY r.DATA_INICIO;
*/

-- ==========================================
-- EXCEPTIONS
-- ==========================================
/*
EXCEPTION
    -- Tratamento Geral - Os erros específicos já são lançados no corpo
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERRO GERAL: ' || SQLERRM);
        RAISE; -- Re-lança o erro original para não mascarar o código de erro


END HTL_SP_CRIAR_RESERVA_VALIDADA;
-- ==========================================
*/