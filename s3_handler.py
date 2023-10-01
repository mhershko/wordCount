import boto3
from botocore.client import Config


class S3Handler:

    def __init__(self, aws_access_key: str, aws_secret_key: str):
        self.s3_client = boto3.client('s3', region_name='eu-central-1',
                                      config=Config(signature_version='s3v4'),
                                      aws_access_key_id=aws_access_key,
                                      aws_secret_access_key=aws_secret_key)

    def download_file_from_s3(self, file_name: str, file_target_path: str, s3_bucket_input_files: str):
        try:
            self.s3_client.download_file(s3_bucket_input_files, file_name, file_target_path)
            return file_target_path
        except Exception as e:
            message = f"Failed downloading {file_name} with error: {e}"
            raise Exception(message)

    def upload_file_to_s3(self, output_file_name: str, s3_bucket_output_files: str):
        try:
            self.s3_client.upload_file(
                output_file_name,
                s3_bucket_output_files,
                output_file_name
            )
        except Exception as e:
            message = f"Failed uploading {output_file_name} with error: {e}"
            raise Exception(message)
