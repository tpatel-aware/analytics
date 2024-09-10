import json
import base64
from opensearchpy import OpenSearch
import requests as re
import random
import boto3
import os

host=os.getenv("HOST") #get the host name from env
port = 443
auth=('test','Test@123') #user id and password of opensearch
def lambda_handler(event, context):
    data = base64.b64decode(event['Records'][0]['kinesis']['data']).decode('utf-8') #get and decode data from kinesis event 
    data = json.loads(data) #jsonify the string
    final_data={
        "timestamp":str(data["timestamp"]),
        "username":str(data["context"]["username"]),
        "score":str(data["transactions"]["faceLiveness"]["result"]["liveness_result"]["score"])
    } # perparing the final data that get stored
    acquiredAttributes = data["transactions"]["deviceSecurity"]["acquiredAttributes"]
    bfs = next(item for item in acquiredAttributes if item["attributeType"]=="BiometricFraudScore") #get biometric fraud value from kinesis data 
    final_data["biometricFraudScore"]=str(bfs["values"]["biometricFraudScore"]) #putting to final data

    res= OpenSearch(
        hosts=[{'host':host,'port':port}],
        http_auth=auth,
        use_ssl=True,
        verify_certs=False,
    ) #login to opensearch
    index_name='faceliveness'
    try:
        index_body= {
            'settings': {
                'index': {
                'number_of_shards': 4
                }
            }
            }
        response = res.indices.create(index_name,body=index_body) #trying to create the index
    except Exception as e:
        print(e)
    document = final_data
    #index_object
    response = res.index(
        index = index_name,
        body = document,
        id = str(random.randint(0,5585)),
        refresh = True
        ) #indexing the final data to open search
    file_name = str(data["timestamp"]).replace(".","")
    import csv
    #creating  a csv file with final data and upload to s3 bucket
    with open(f'/tmp/{file_name}.csv', 'w', newline='') as csvfile:
        fieldnames = list(final_data.values())
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
    s3_client= boto3.client("s3")
    file_names = f"test/upload_{file_name}_now.csv"
    s3_client.upload_file(f'/tmp/{file_name}.csv',"kinesis-s3-athena-test",file_names)

    return {
        'body': response
    }
