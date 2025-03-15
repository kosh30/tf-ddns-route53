import logging
import base64
import os
import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)
logging.getLogger('boto3').setLevel(logging.INFO)
logging.getLogger('botocore').setLevel(logging.INFO)

zone_id = os.environ['HOSTED_ZONE_ID']
ssm_parameter_name = os.environ['SSM_PARAMETER_NAME']


def authenticated(event):
    if event.get('headers', {}).get('authorization') is None:
        return False
    credentials = boto3.client('ssm').get_parameter(
        Name=ssm_parameter_name, WithDecryption=True
    )['Parameter']['Value']
    auth = base64.b64decode(event['headers']['authorization'].split(' ')[-1]).decode('utf-8')
    if auth != credentials:
        logger.warning('authentication failed: %s', auth)
        return False
    return True


def handler(event, _):
    response = {
        'statusCode': 403,
        'headers': {'Content-Type': 'text/text'},
        'body': 'forbidden',
    }

    if not authenticated(event):
        return response

    if any(
        (
            (event.get('queryStringParameters', {}).get('hostname') is None),
            (event.get('queryStringParameters', {}).get('myip') is None),
        )
    ):
        return response

    try:
        boto3.client('route53', 'eu-central-1').change_resource_record_sets(
            HostedZoneId='/hostedzone/' + zone_id,
            ChangeBatch={
                'Comment': 'dynamic dns update',
                'Changes': [
                    {
                        'Action': 'UPSERT',
                        'ResourceRecordSet': {
                            'Name': event['queryStringParameters']['hostname'],
                            'Type': 'A',
                            'TTL': 60,
                            'ResourceRecords': [
                                {'Value': event['queryStringParameters']['myip']}
                            ],
                        },
                    }
                ],
            },
        )

        response = {
            'statusCode': 200,
            'headers': {'Content-Type': 'text/text'},
            'body': 'success',
        }

    except Exception as e:
        logger.exception(e)
        return response

    return response
