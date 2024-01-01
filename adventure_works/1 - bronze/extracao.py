import pymssql
import loguru
import pandas as pd
import os
from dotenv import load_dotenv
import awswrangler as wr


def sql_connection():
    """Cria a conexão com o banco Microsoft SQL Server

    Returns:
        - string de conexão
    """
    return pymssql.connect(
        server=os.getenv('server'),
        user=os.getenv('USER'),
        password=os.getenv('PASSWORD'),
        database=os.getenv('DATABASE'),
        as_dict=True
    )


def read_query(path):
    """Lê os arquivos .SQL

    Args:
        - caminho da pasta sql

    Returns:
        - query sql
    """
    with open(path) as f:
        return f.read()


def list_files(path):
    """Lista os arquivos de um diretório

    Args:
        - caminho para listar os arquivos

    Returns:
        - lista de arquivos
    """
    return os.listdir(path=path)


def create_dataframe(res):
    """Cria um dataframe

    Args:
        - dicionário com o resultado da query

    Returns:
        - dataframe pandas
    """
    return pd.DataFrame(res)


def execute_query(conn, query):
    """Executa a query no banco MSSQL

    Args:
        - conexão com o banco
        - query sql

    Returns:
        - resultado da query
    """
    with conn.cursor() as cursor:
        cursor.execute(query)
        return cursor.fetchall()


def create_partition_cols(df):
    """Cria as colunas de partição com base na data de ingestão.

    Args:
        - dataframe

    Returns:
        - dataframe com as colunas de partição
    """
    df['ano'] = df['dh_ingestao_bronze'].dt.strftime('%Y')
    df['mes'] = df['dh_ingestao_bronze'].dt.strftime('%Y%m')
    df['dia'] = df['dh_ingestao_bronze'].dt.strftime('%Y%m%d')

    return df


def write_s3(path):
    """Salva o dataframe como parquet no s3

    Args:
        - caminho do s3
    """
    wr.s3.to_parquet(
        path=path,
        dataset=True,
        mode='append',
        partition_cols=['ano', 'mes', 'dia']
    )


def main():
    logger = loguru.logger
    load_dotenv()

    try:
        logger.info('Estabelecendo conexão com o MSSQL')
        conn = sql_connection()

        logger.info('Listando as queries a serem executadas')
        sql_path = 'adventure_works/1 - bronze/sql/'
        entity_list = list_files(sql_path)

        for entity in entity_list:
            logger.info(f'Executando extração de {entity}')
            query = read_query(f'{sql_path}/{entity}')
            res = execute_query(conn, query)
            df = create_dataframe(res)

            entity_name = entity.replace('.sql', '')
            if not df.empty:
                df = create_partition_cols(df)

                logger.info(
                    f"Gravando dataframe {entity_name}:\n{df.head(1)} no s3")
                write_s3(df)

            else:
                logger.warning(f"Dataframe {entity_name} vazio")

    except Exception as e:
        logger.error(f'Erro durante o processo de extração do MSSQL {e}')


if __name__ == '__main__':
    main()
