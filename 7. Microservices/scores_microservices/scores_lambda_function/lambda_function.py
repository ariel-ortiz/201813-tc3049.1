import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('scores')

def create_response(status_code, body):
    return {
        'statusCode': status_code,
        'body': json.dumps(body, indent=2),
        'headers': {
            'Content-Type': 'application/json; charset=UTF-8'
        }
    }

def get_scores():
    scan_result = table.scan()['Items']
    result = []
    for item in scan_result:
        result.append({
            'initials': item['initials'],
            'score': int(item['score']),
            'timestamp': item['timestamp']
        })
    return result

def lambda_handler(event, context):
    method = event.get('httpMethod', 'Nothing')
    if method == 'GET':
        return create_response(200, get_scores())
    else:
        return create_response(405, {'error': f'Method "{ method }" not allowed.'})
