import json
import awswrangler as wr
import loguru

logger = loguru.logger


def read_file(path):
    """Lê o arquivo do s3

    Args:
        - path s3

    Returns:
        - dataframe em formato pandas
    """
    return wr.s3.read_parquet(path=path)


def read_json(path):
    """Lê os arquivos json por entidade

    Args:
        - path json

    Returns:
        - dicionário com data types e colunas
    """
    with open(path) as f:
        return json.loads(f.read())


def rename_columns(df, old, new):
    """Renomeia as colunas do dataframe

    Args:
        - dataframe
        - old column
        - new column

    Returns:
        - dataframe renomeado
    """
    return df.rename(columns={old: new})


def apply_data_type(df, column, data_type):
    """Transforma o tipo de dado das colunas

    Args:
        - dataframe
        - column
        - data_type

    Returns:
        - dataframe tratado
    """
    # Preenchendo nulos
    if data_type in ('int', 'double'):
        df[[column]] = df[[column]].fillna(value=0)

    # Tipando colunas
    if data_type == 'str':
        df[column] = df[column].apply(str)
    else:
        df[column] = df[column].astype(data_type)
    return df


def create_partition_cols(df):
    """Cria as colunas de partição com base na data de modificação.

    Args:
        - dataframe

    Returns:
        - dataframe com as colunas de partição
    """
    df['year'] = df['creation_date'].dt.strftime('%Y').astype('int')
    df['month'] = df['creation_date'].dt.strftime('%Y%m').astype('int')
    df['day'] = df['creation_date'].dt.strftime('%Y%m%d').astype('int')

    return df


def write_s3(df, entity):
    """Salva o dataframe como parquet no s3

    Args:
        - caminho do s3
    """
    wr.s3.to_parquet(
        path=f's3://adventure-works-silver/{entity}',
        df=df,
        dataset=True,
        mode='overwrite_partitions',
        partition_cols=['year', 'month', 'day']
    )


def lambda_handler(event, context):
    try:
        logger.info('Iniciando o tratamento de mensagens')
        records = event['Records']

        for record in records:
            bucket = record['s3']['bucket']['name']
            object_key = record['s3']['object']['key']
            path = f's3://{bucket}/{object_key}'

            entity = object_key.split('/')[0]

            logger.info(f'Lendo entidade {entity} do S3 {path}')
            df = read_file(path)

            logger.info('Tratando tipos de dados')
            data_types = read_json(
                f'adventure_works/2 - silver/schema/{entity}.json')

            pk_list = []
            for table in data_types[entity]:
                for column, properties in table.items():
                    print(column)
                    df = apply_data_type(df, column, properties['type'])
                    df = rename_columns(df, column, properties['rename'])
                    if properties['key'] is True:
                        pk_list.append(properties['rename'])

            logger.info('Removendo duplicidades')
            df.sort_values(by=['modified_date'], ascending=True).drop_duplicates(
                subset=pk_list, keep='last')

            if not df.empty:
                logger.info('Criando colunas de partição')
                df = create_partition_cols(df)

                logger.info(
                    f"Gravando dataframe {entity} no s3:\n{df.head(1)}")
                write_s3(df, entity)

            else:
                logger.warning(f"Dataframe {entity} vazio")

    except Exception as e:
        logger.error(f'Erro durante extração e carga na camada silver: {e}')


def main():
    event = {
        "Records": [
            {
                "eventVersion": "2.0",
                "eventSource": "aws:s3",
                "awsRegion": "us-east-1",
                "eventTime": "1970-01-01T00:00:00.000Z",
                "eventName": "ObjectCreated:Put",
                "userIdentity": {
                    "principalId": "EXAMPLE"
                },
                "requestParameters": {
                    "sourceIPAddress": "127.0.0.1"
                },
                "responseElements": {
                    "x-amz-request-id": "EXAMPLE123456789",
                    "x-amz-id-2": "EXAMPLE123/5678abcdefghijklambdaisawesome/mnopqrstuvwxyzABCDEFGH"
                },
                "s3": {
                    "s3SchemaVersion": "1.0",
                    "configurationId": "testConfigRule",
                    "bucket": {
                        "name": "adventure-works-bronze",
                        "ownerIdentity": {
                            "principalId": "EXAMPLE"
                        },
                        "arn": "arn:aws:s3:::adventure-works-bronze"
                    },
                    "object": {
                        "key": "address/year=2024/month=202402/day=20240213/30038125c3974147b075d2929eaa8568.snappy.parquet",
                        "size": 1024,
                        "eTag": "0123456789abcdef0123456789abcdef",
                        "sequencer": "0A1B2C3D4E5F678901"
                    }
                }
            }
        ]
    }
    lambda_handler(event, None)


if __name__ == '__main__':
    main()
