# hotel-bndd2
Banco de dados 2 - Professor Valtemir.

REPOSITÓRIO dos arquivos .sql

Integrantes do grupo:

Matrícula,  Usuário Oracle,  Nome

BI303268X,  C##BRIBND2_LUCAS_NOVAIS,  Lucas Novais de Oliveira

BI3032833,  C##BRIBND2_BTELINI,  Bruno Telini Rocha

BI3033058,  C##BRIBND2_GUI_MULATO,  Guilherme Mulato Peres Silva

BI3025446,  C##BRIBND2_RAFAEL,  Rafael Hideki Yajima

LINK da pasta compartilhada: https://drive.google.com/drive/folders/1rr4roRz8dbXAYwnszctFQKz8Dzw6tWfg?usp=sharing

Observação do DDL (21-09-2025):
1. resolvido
2. No Oracle SQL Developer, para funcionar:
3. bigint → NUMBER
4. string → VARCHAR2
5. text → VARCHAR2(255) (para senha e descricao)
6. enum → VARCHAR2 ou CHAR(1) (para sexo e tipo)
7. date → DATE
8. timestamptz → DATE (você simplificou, o que é válido para um DDL básico)
9. numeric → NUMBER(10,2) (adequado para valores monetários)
10. bool → NUMBER(1) (com DEFAULT 0 ou 1, representando true/false)


Para saber o próximo número de ID:

SELECT MAX(HOSPEDE_ID) + 1 AS PROXIMO_ID FROM HTL_HOSPEDE;


-- ==========================================
-- NOTAS IMPORTANTES SOBRE O FLUXO DE RESERVAS
-- ==========================================
/*
Fluxo correto dos status de RESERVA:
    1. AGUARDANDO CHECK-IN → Reserva criada, aguardando hóspede chegar
        ↓ (HTL_SP_FAZER_CHECKIN)
    2. OCUPADO → Hóspede fez check-in, está hospedado
        ↓ (HTL_SP_FAZER_CHECKOUT)
    3. FINALIZADO → Hóspede fez check-out, reserva encerrada
Ou:
    1. AGUARDANDO CHECK-IN
        ↓ (HTL_SP_CANCELAR_RESERVA)
    4. CANCELADO → Reserva cancelada antes do check-in

    O FINALIZADO já está sendo usado corretamente!


a SP HTL_SP_FAZER_CHECKOUT já muda para FINALIZADO:

    UPDATE HTL_RESERVA
    SET 
        CHECK_OUT = SYSTIMESTAMP,       -- Registra a hora exata do Check-out
        RESERVA_STATUS_ID = v_finalizado_id, -- Atualiza para FINALIZADO
        ATUALIZADO_EM = SYSTIMESTAMP
    WHERE 
        RESERVA_ID = p_reserva_id
        AND RESERVA_STATUS_ID = v_ocupado_id -- Condição crucial: deve estar OCUPADO

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