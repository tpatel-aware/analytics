import json
import boto3
import uuid

import os 

KINESIS_NAME=os.getenv("KINESIS_NAME") #get kinesis env variable 

def lambda_handler(event, context):
    client = boto3.client('kinesis') #login to kinesis using boto3 client 
    s3_bucket_name = event["Records"][0]["s3"]["bucket"]["name"] #get the bucket name from event triggered
    s3_file_key = event["Records"][0]["s3"]["object"]["key"] # get the s3 file key from event
    s3_client=boto3.client("s3") #login to s3 using boto3 client 
    obj = s3_client.get_object(Bucket=s3_bucket_name,Key=s3_file_key) #get object from bucket

    data = obj["Body"].read() #direct reading the object
    response = client.put_record(
        StreamName=KINESIS_NAME,
        Data=data,
        PartitionKey=json.loads(data)["transactionID"]
    ) #storing the record to kinesis
    print(response)
    # TODO implement
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
