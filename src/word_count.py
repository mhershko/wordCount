import os
from collections import Counter

import boto3
import logging

from flask import current_app

from s3_handler import S3Handler

logger = logging.getLogger(__name__)

INPUT_FILES_DIR_PATH = "./input_files"


class WordCount:

    def __init__(self):
        aws_access_key = current_app.config["AWS_ACCESS_KEY"]
        aws_secret_key = current_app.config["AWS_SECRET_KEY"]
        self.s3_handler = S3Handler(aws_access_key, aws_secret_key)

        self.s3_bucket_input_files = current_app.config["S3_BUCKET_INPUT_FILES"]
        self.s3_bucket_output_files = current_app.config["S3_BUCKET_OUTPUT_FILES"]

        if not os.path.exists(INPUT_FILES_DIR_PATH):
            os.mkdir(INPUT_FILES_DIR_PATH)

    def count_words_in_file(self, file_name: str):
        try:
            file_target_path = f'{INPUT_FILES_DIR_PATH}/{file_name}'
            self.s3_handler.download_file_from_s3(file_name, file_target_path, self.s3_bucket_input_files)

            with open(file_target_path) as f:
                words = f.read().split()
                num_of_words = len(words)
                word_count_dict = dict(Counter(words))
            self.handle_output_file(num_of_words, word_count_dict, file_name)
            return {
                    "message": f"please find your output file in {self.s3_bucket_output_files} bucket",
                   }, 200
        except Exception as e:
            return {
                "error": f"Failed count words for {file_name}",
                "message": str(e)
            }, 500

    def handle_output_file(self, num_of_words: str, word_count_dict: dict, file_name: str):
        output_file_name = f"word_count_{file_name}"
        with open(output_file_name, "w") as output_file:
            output_file.write(f"Number of words in {file_name}: {num_of_words}\n")
            output_file.write("*****\n")
            output_file.write(str(word_count_dict))
        output_file_s3_path = self.s3_handler.upload_file_to_s3(output_file_name, self.s3_bucket_output_files)
        return output_file_s3_path
