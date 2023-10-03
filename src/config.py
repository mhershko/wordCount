import os
from dotenv import load_dotenv

load_dotenv()

basedir = os.path.abspath(os.path.dirname(__file__))


def get_env_var(name):
    try:
        return os.environ[name]
    except KeyError:
        message = f"Expected environment variable '{name}' not set"
        raise Exception(message)


class Config(object):
    APP_PORT = get_env_var('APP_PORT')
    ACCESS_TOKEN = get_env_var('ACCESS_TOKEN')
    AWS_ACCESS_KEY = get_env_var('AWS_ACCESS_KEY')
    AWS_SECRET_KEY = get_env_var('AWS_SECRET_KEY')
    S3_BUCKET_INPUT_FILES = get_env_var('S3_BUCKET_INPUT_FILES')
    S3_BUCKET_OUTPUT_FILES = get_env_var('S3_BUCKET_OUTPUT_FILES')