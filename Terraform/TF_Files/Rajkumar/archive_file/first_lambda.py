import boto3
import string
import random
import logging
import json

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def generate_token(length=16):
    excluded_chars = ' "/@'
    allowed_chars = [ch for ch in string.printable if ch not in excluded_chars and not ch.isspace()]
    if length < 16 or length > 128:
        raise ValueError("Length must be between 16 and 128 characters.")
    token = ''.join(random.choice(allowed_chars) for _ in range(length))
    return token

def lambda_handler(event, context):
    secret_name = "elastic_new_auth_key"
    client = boto3.client('secretsmanager')
    
    token_length = 16
    auth_token = generate_token(token_length)
    replication_group_id = generate_token(token_length)
    
    logger.info(f"Generated authToken: {auth_token}")
    logger.info(f"Generated replicationGroupId: {replication_group_id}")
    
    updated_secret_string = {
        "authToken": auth_token,
        "replicationGroupId": replication_group_id
    }
    
    client.put_secret_value(
        SecretId=secret_name,
        SecretString=json.dumps(updated_secret_string)
    )
    
    updated_secret = client.get_secret_value(SecretId=secret_name)
    logger.info(f"Updated secret value: {updated_secret['SecretString']}")
    
    return updated_secret_string
