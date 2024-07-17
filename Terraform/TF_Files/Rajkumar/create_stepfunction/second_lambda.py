import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    logger.info(f"Received event: {event}")
    
    auth_token = event.get('authToken', 'No authToken received')
    replication_group_id = event.get('replicationGroupId', 'No replicationGroupId received')
    
    logger.info(f"authToken: {auth_token}")
    logger.info(f"replicationGroupId: {replication_group_id}")
    
    return {
        'statusCode': 200,
        'body': f"Received authToken: {auth_token}, replicationGroupId: {replication_group_id}"
    }
