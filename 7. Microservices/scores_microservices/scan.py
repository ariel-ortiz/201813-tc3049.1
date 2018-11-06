import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('scores')

items = table.scan()['Items']
for item in items:
    print(f'Initials: { item["initials"] }, Score: { item["score"]  }')
