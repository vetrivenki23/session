import boto3
import secrets
import json
import time
import logging
import os
# Global variables.
logger = logging. getLogger ()
logger.setLevel (logging.INFO)
def get_secret (secret_name):
    client = boto3.client ('secretsmanagen')
    response = client.get_secret_valve(SecretId=secret_name)
    return json. loads(response[ 'SecretString'])
def put_secret(secret_name, secret_value):
    client = boto3. client ('secretsmanager')
    client.put_secret_value(SecretId=secret_name, Secretstring=json.dum)
def modify_replication_group(client, cluster_id, new_token, strategy):
    return client.modify_replication_group(
        ReplicationGroupId=cluster_id, AuthToken=new_token,
        AuthTokenUpdateStrategy=strategy,
        ApplyImmediately=True
    )   
def wait_for_update(client, cluster_id):
    while True:
        response = client.describe_replication_groups(ReplicationGroupId=cluster_id)
        status = response['ReplicationGroups'][0]['Status']
        if status == 'available':
            print("Update complete.")
            break
        else:
            print(f"Current status: (status). Waiting for update to complete...")
            time.sleep(30)
def Lambda_handler(event, context):
    #secret_name = '/application/elasticache-token-app-ec-atlasone-gbl-pave'
    secret_name = os. getenv ('SECRET_NAME')
    # Step 1: Get the current secret
    current_secret = get_secret (secret_name)
    current_token = current_secret[ 'authToken']
    cluster_id = current_secret[ 'replicationGroupId']
    # Step 2: Generate a new token
    new_token = secrets. token_urlsafe(32)
    # Step 3: Update the cluster with the new token
    client = boto3.client('elasticache')
    modify_replication_group(client, cluster_id, new_token, strategy: 'ROTATE')
    # Step 4: Wait for the update to complete
    wait_for_update(client, cluster_id)
    # Step 5: Update the secret with the new token
    #new_secret = {'authToken": new_token}
    new_secret = {
        "authToken": new_token,
        "replicationGroupId": cluster_id
    }
    put_secret(secret_name, new_secret)
    # Step 6: Remove the old token
    modify_replication_group(client, cluster_id, new_token, strategy: 'SET')
    # Step 7: Wait for the final update to complete
    wait_for_update(client, cluster_id)
    return {
        "statusCode": 200,
        "body": json.dumps("Token rotation successful!")
    }