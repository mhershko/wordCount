# Home assignment - CheckPoint - WordCount

## Description
WordCount app exposes API that receive for input a file name that located in s3 bucket, and 
perform count of the words in the
file and how many times each word appeared. 

The app stores the results in another S3 bucket.

```commandline
POST /word-count
payload: {fileName: <FILE-NAME>}
headers: {
            Content-Type: application/json;charset=UTF-8,
            Authorization: <ACCESS-TOKEN>
          }
```

## Assumptions
- The provided file name must exist in the `cp-input-files` bucket
- The file must be valid and contain text

## Pre-requisite
- Make sure you have installed Python3, Terraform, AWS CLI, and configured a `default` AWS CLI profile

```bash
terraform -help # prints Terraform options
which aws # prints /usr/local/bin/aws
aws --version # prints aws-cli/2.0.36 Python/3.7.4 Darwin/18.7.0 botocore/2.0.0
aws configure # configure your AWS CLI profile
python3 --version # prints Python 3 version
```

- locate `.env` file in your root directory

```bash
AWS_ACCESS_KEY = ********
AWS_SECRET_KEY = ********
S3_BUCKET_INPUT_FILES = 'cp-input-files'
S3_BUCKET_OUTPUT_FILES = 'cp-output-files'
ACCESS_TOKEN= *******
APP_PORT=5000
ENV=DEV
```

## Automation script
- located in `scripts` directory
- contains deployment into aws, API call to the deployed app and validation of the response
- insert `GITHUB_TOKEN` in line 5
- insert `ACCESS_TOKEN` in line 6
- call using `sh scripts/deploy.sh`

### NOTE
I'm no longer afraid of Terraform, so thanks for that :)
