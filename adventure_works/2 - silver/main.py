import pandas as pd
import json
import awswrangler as wr
import loguru

logger = loguru.logger

def read_file(path):
    return wr.s3.read_parquet(path=path)

def read_json(path):
    with open(path) as f:
        return json.loads(f.read())

def lambda_handler(event, context):
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
        data_types = read_json(f'adventure_works/2 - silver/schema/{entity}.json')

        for column in data_types[entity]:
            for k, v in column.items():
                df.rename(columns={k:v})
            
        print('ok')
        


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
                "key": "address/year=2024/month=202401/day=20240101/550a9e0128744761818ba1ee800c0313.snappy.parquet",
                "size": 1024,
                "eTag": "0123456789abcdef0123456789abcdef",
                "sequencer": "0A1B2C3D4E5F678901"
                }
            }
            }
        ]
    }
    lambda_handler(event,None)

if __name__ == '__main__':
    main()