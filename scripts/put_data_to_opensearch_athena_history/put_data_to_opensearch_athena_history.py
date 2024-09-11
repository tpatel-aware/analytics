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
    s3_bucket_name = event["Records"][0]["s3"]["bucket"]["name"] #get the bucket name from event triggered
    s3_file_key = event["Records"][0]["s3"]["object"]["key"] # get the s3 file key from event
    s3_client=boto3.client("s3") #login to s3 using boto3 client 
    obj = s3_client.get_object(Bucket=s3_bucket_name,Key=s3_file_key) #get object from bucket

    data = obj["Body"].read() #direct reading the object
    #add csv logic to read the line and create a key value pair
    final_data = [{"username":"blah","count":"1"}]
    res= OpenSearch(
        hosts=[{'host':host,'port':port}],
        http_auth=auth,
        use_ssl=True,
        verify_certs=False,
    ) #login to opensearch
    index_name='history'
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
    
    return {
        'body': response
    }
