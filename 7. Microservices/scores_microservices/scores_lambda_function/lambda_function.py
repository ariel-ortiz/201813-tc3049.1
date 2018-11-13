import json
import boto3
from datetime import datetime

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
    scan_result.sort(key=lambda item: item['timestamp'])
    scan_result.sort(key=lambda item: item['score'], reverse=True)
    result = []
    for item in scan_result:
        result.append({
            'initials': item['initials'],
            'score': int(item['score']),
            'timestamp': item['timestamp']
        })
    return result

def parse_body(str):
    try:
        data = json.loads(str)
        if 'initials' in data and 'score' in data:
            return data
        else:
            return None
    except json.decoder.JSONDecodeError:
        return None

def create_new_score(event):
    data = parse_body(event.get('body', ''))
    if data:
        data['timestamp'] = datetime.now().strftime('%Y-%m-%d %H:%M:%S.%f')
        table.put_item(Item=data)
        return True
    else:
        return False

def lambda_handler(event, context):
    method = event.get('httpMethod', 'Nothing')
    if method == 'GET':
        return create_response(200, get_scores())
    elif method == 'POST':
        if create_new_score(event):
            return create_response(201, {'message': 'Resource created successfully'})
        else:
            return create_response(400, {'error': 'Bad request (invalid input)'})
    else:
        return create_response(405, {'error': f'Method "{ method }" not allowed.'})
