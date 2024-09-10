#!/bin/bash

pip install --target ./scripts/get_data_from_kinesis_and_put_to_opensearch/pkg -r ./scripts/requirements.txt
cp ./scripts/get_data_from_kinesis_and_put_to_opensearch/get_data_from_kinesis_and_put_to_opensearch.py ./scripts/get_data_from_kinesis_and_put_to_opensearch/pkg/get_data_from_kinesis_and_put_to_opensearch.py

pip install --target ./scripts/put_data_to_kinesis/pkg -r ./scripts/requirements.txt
cp ./scripts/put_data_to_kinesis/put_data_to_kinesis.py ./scripts/put_data_to_kinesis/pkg/put_data_to_kinesis.py
cp ./scripts/put_data_to_kinesis/device_data.py ./scripts/put_data_to_kinesis/pkg/device_data.py
cp ./scripts/put_data_to_kinesis/liveness_data.py ./scripts/put_data_to_kinesis/pkg/liveness_data.py

pip install --target ./scripts/get_data_from_opensearch/pkg -r ./scripts/requirements.txt
cp ./scripts/get_data_from_opensearch/get_data_from_opensearch.py ./scripts/get_data_from_opensearch/pkg/get_data_from_opensearch.py


cd terraform
terraform init
terraform plan
terraform apply -auto-approve