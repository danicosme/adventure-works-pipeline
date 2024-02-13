# AdventureWorks Pipeline

Este repositório contém um pipeline simples para processar dados da base AdventureWorks da Microsoft, utilizando serviços AWS.

## Descrição

O objetivo deste projeto é criar um pipeline que extrai dados brutos do MSSQL Server da base AdventureWorks2022, realiza o processamento necessário para limpeza e transformação, e armazena os dados em uma camada silver no AWS S3, prontos para consumo.

## Arquitetura

O pipeline é composto por algumas etapas, utilizando os seguintes serviços AWS:
- Amazon S3: Armazenamento dos dados brutos e processados.
- AWS Lambda: Execução de funções Python para extração e limpeza dos dados.
- Amazon SNS (Simple Notification Service): Gatilho para notificação de novos arquivos no S3.
- Amazon SQS (Simple Queue Service): Fila de mensagens para disparar a execução dos códigos Python na Lambda.
- Amazon Athena: Consulta dos dados armazenados no S3.

## Estrutura do Projeto
    .
    ├── adventure_works
    │ ├── 1_bronze
    │ │ ├── sql                     # Queries SQL para extração de dados
    │ │ │ └── extracao.py           # Código Python para extração de dados
    │ └── 2_silver
    │ ├── schema                    # Json com o datatypes de cada coluna
    │ │ └── main.py                 # Código Python para limpeza e transformação de dados
    ├── poetry.lock                 # Bloqueio de versões gerado pelo Poetry
    ├── .pre-commit-config.yaml     # Configuração do pre-commit hooks
    ├── pyproject.toml              # Configuração de pacotes do projeto
    └── README.md                   # Este arquivo

## Configuração

1. **Instalação de Dependências**:
   ```bash
   poetry install

