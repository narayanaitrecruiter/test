import json

def lambda_handler(event, context):
    # Log the received event
    print("Received event: " + json.dumps(event, indent=2))

    # Extract parameters from the event (assuming an API Gateway event)
    if 'queryStringParameters' in event:
        params = event['queryStringParameters']
    else:
        params = {}

    # Prepare the response
    name = params.get('name', 'World')
    message = f"Hello, {name}!"
    
    # Log the response
    print("Response message: " + message)
    
    # Return a response object
    return {
        'statusCode': 200,
        'body': json.dumps({
            'message': message,
            'input': event
        })
    }
