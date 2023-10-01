#!/usr/bin/env bash

set -e

# ls /app/

echo "Run WordCount app!!"

gunicorn --bind 0.0.0.0:5000 main:app