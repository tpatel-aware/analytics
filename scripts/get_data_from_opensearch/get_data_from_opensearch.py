import json
import base64
import boto3
from opensearchpy import OpenSearch
import requests as re
import os

host=os.getenv("HOST") #get host from env 
port = 443
auth=('test','Test@123') #userid and password of opensearch
def lambda_handler(event, context):
    # TODO implement
    res= OpenSearch(
        hosts=[{'host':host,'port':port}],
        http_auth=auth,
        use_ssl=True,
        verify_certs=False,
    )#login to open search
    index_name='faceliveness' #index name
    query = event #query that send to function as event
    ## Here is where we add specific query to get parameters and metrics
    response = res.search(
        body = query,
        index = index_name
    )
    
    print(response)
    
    return {
        'statusCode': 200,
        'body': json.dumps(response)
    }

