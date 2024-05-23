import datetime
import boto3
from airflow import models
from airflow.operators import bash_operator
from airflow.operators import python_operator

default_args = {
    # Текущая дата и время в качестве значения по умолчанию
    'start_date': datetime.datetime(2023, 6, 23),
}

with models.DAG(
    'sprint6_3',
    schedule_interval=datetime.timedelta(days=1),
    default_args=default_args) as dag:

    def download_data(**kwargs):
        AWS_ACCESS_KEY_ID = "YCAJEWXOyY8Bmyk2eJL-hlt2K"
        AWS_SECRET_ACCESS_KEY = "YCPs52ajb2jNXxOUsL4-pFDL1HnV2BCPd928_ZoA"

        session = boto3.session.Session()
        s3_client = session.client(
            service_name='s3',
            endpoint_url='https://storage.yandexcloud.net',
            aws_access_key_id=AWS_ACCESS_KEY_ID,
            aws_secret_access_key=AWS_SECRET_ACCESS_KEY,
        )
        s3_client.download_file(
            Bucket='sprint6',
            Key='group_log.csv',
            Filename='/data/group_log.csv'
        )

    download_data_task = python_operator.PythonOperator(
        task_id='download_data',
        python_callable=download_data,
        dag=dag,
    )
