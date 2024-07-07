import boto3
import string
import random
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def generate_token(length=16):
    # Define the characters to exclude
    excluded_chars = ' "/@'
    
    # Create a list of allowable characters
    allowed_chars = [ch for ch in string.printable if ch not in excluded_chars and not ch.isspace()]
    
    # Ensure the length is within the specified range
    if length < 16 or length > 128:
        raise ValueError("Length must be between 16 and 128 characters.")
    
    # Generate the token
    token = ''.join(random.choice(allowed_chars) for _ in range(length))
    return token

def lambda_handler(event, context):
    secret_name = "my_secret"
    client = boto3.client('secretsmanager')
    
    # Generate random token
    token_length = 16  # You can set this to any value between 16 and 128
    new_token = generate_token(token_length)
    
    # Log the new token
    logger.info(f"Generated new token: {new_token}")
    
    # Update the secret
    client.put_secret_value(
        SecretId=secret_name,
        SecretString=new_token
    )
    
    return {
        'statusCode': 200,
        'body': 'Secret rotated successfully'
    }
