# hotel-bndd2
Banco de dados 2 - Professor Valtemir.

REPOSITÓRIO dos arquivos .sql

Integrantes do grupo:

Matrícula,  Usuário Oracle,  Nome

BI303268X,  C##BRIBND2_LUCAS_NOVAIS,  Lucas Novais de Oliveira

BI3032833,  C##BRIBND2_BTELINI,  Bruno Telini Rocha

BI3033058,  C##BRIBND2_GUI_MULATO,  Guilherme Mulato Peres Silva

BI3026191,  C##BRIBND2_BHIDEKI,  Bruno Hideki Uemura

LINK da pasta compartilhada: https://drive.google.com/drive/folders/1rr4roRz8dbXAYwnszctFQKz8Dzw6tWfg?usp=sharing

Observação do DDL (21-09-2025):
1. Não criar ainda coisas avançadas como: INDEX, LOGGING, LOOKUP TABLE e TRIGGERS, até nós entendermos melhor estas merda
2. No Oracle SQL Developer, para funcionar, fiz estas mudança
a. bigint → NUMBER
b. string → VARCHAR2
c. text → VARCHAR2(255) (para senha e descricao)
d. enum → VARCHAR2 ou CHAR(1) (para sexo e tipo)
e. date → DATE

timestamptz → DATE (você simplificou, o que é válido para um DDL básico)
numeric → NUMBER(10,2) (adequado para valores monetários)
bool → NUMBER(1) (com DEFAULT 0 ou 1, representando true/false)
