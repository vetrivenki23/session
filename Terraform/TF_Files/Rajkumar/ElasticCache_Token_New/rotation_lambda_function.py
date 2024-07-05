import boto3
import string
import random

def generate_password(length=12):
    characters = string.ascii_letters + string.digits + string.punctuation
    password = ''.join(random.choice(characters) for i in range(length))
    return password

def lambda_handler(event, context):
    secret_name = "my_secret"
    client = boto3.client('secretsmanager')
    
    # Generate random password
    new_password = generate_password()
    
    # Update the secret
    client.put_secret_value(
        SecretId=secret_name,
        SecretString=new_password
    )
    
    return {
        'statusCode': 200,
        'body': 'Secret rotated successfully'
    }
