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
