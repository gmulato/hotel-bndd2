---
config:
  layout: dagre
---
erDiagram
    direction LR
    HOSPEDE {
        bigInt hospede_id PK "Identificador único"  
        bigInt criado_por FK "referencia FUNCIONARIO"  
        string nome  "Nome completo"  
        string cpf  UK "CPF"  
        string rg  UK "RG"  
        enum sexo  "'MASCULINO' | 'FEMININO'"  
        date nascimento  "Data de nascimento"  
        string email  "E-mail"  
        string telefone  "Telefone"  
        timestamp criado_em  ""  
        timestamp atualizado_em  ""  
    }
    SERVICO {
        bigInt servico_id PK "Identificador único"  
        string nome  "Nome do serviço"  
        string descricao  "Descrição detalhada"  
        numeric valor  "Valor do serviço"  
        timestamp criado_em  ""  
        timestamp atualizado_em  ""  
    }
    FUNCIONARIO_FUNCAO {
        bigInt funcionario_id FK,PK "referencia FUNCIONARIO"  
        bigInt funcao_id FK,PK "referencia FUNCAO"  
    }
    FUNCAO {
        bigInt funcao_id PK ""  
        string name UK ""  
    }
    FUNCIONARIO {
        bigInt funcionario_id PK "Identificador único"  
        string nome  "Nome do usuário"  
        string email UK "E-mail"  
        text senha  "Senha criptografada"  
        bool ativo  "Se está ativo"  
    }
    QUARTO {
        bigInt quarto_id PK "Identificador único"  
        string identificador UK "Número ou código do quarto"  
        enum tipo  "Tipo do quarto"  
        numeric valor_diaria  "Valor da diária"  
        bool inativo  "Disponível  à reservas"  
    }
    RESERVA {
        bigInt reserva_id PK "Identificador único"  
        bigInt quarto_id FK "referencia QUARTO"  
        bigInt hospede_id FK "referencia HOSPEDE"  
        bigInt criado_por FK "referencia FUNCIONARIO"  
        bigInt reserva_status_id FK ""  
        numeric valor_contratado  "Fechamento do valor de diária"  
        timestamp data_inicio  "Inicio da reserva (agendado)"  
        timestamp data_fim  "Limite da reserva (agendado)"  
        timestamp check_in  "Data/hora de entrada"  
        timestamp check_out  "Data/hora de saída"  
        timestamp criado_em  ""  
        timestamp atualizado_em  ""  
    }
    RESERVA_STATUS {
        bigInt reserva_status_id PK ""  
        string status UK "'AGUARDANDO CHECK-IN' | 'OCUPADO' | 'CANCELADO' | 'FINALIZADO'"  
    }
    RESERVA_STATUS_HIST {
        bigInt status_historico_id PK "identificado histórico de status"  
        bigInt reserva_status_id FK ""  
        bigInt reserva_id FK ""  
        timestamp status_em  ""  
    }
    RESERVA_SERVICO {
        bigInt servico_id FK,PK "referencia SERVICO"  
        bigInt reserva_id FK,PK "referencia RESERVA"  
        date concluido_em  ""  
        numeric valor  "Valor da contratação"  
    }


    FUNCIONARIO||--o{HOSPEDE:"cria"
    RESERVA||--o{RESERVA_SERVICO:"utiliza"
    SERVICO||--o{RESERVA_SERVICO:"é oferecido"
    RESERVA}o--||HOSPEDE:"pertence a"
    QUARTO||--o{RESERVA:"é reservado em"
    FUNCIONARIO||--o{RESERVA:"registra a reserva (pedido)"
    FUNCIONARIO||--o{FUNCIONARIO_FUNCAO:"tem função no sistema"
    FUNCIONARIO_FUNCAO}o--||FUNCAO:"permissão / políticas"
    RESERVA||--|{RESERVA_STATUS_HIST:"guarda a mudança do status atual"
    RESERVA}o--|{RESERVA_STATUS:"tem um status atual"
    RESERVA_STATUS_HIST}o--||RESERVA_STATUS:"status selecionado em"



