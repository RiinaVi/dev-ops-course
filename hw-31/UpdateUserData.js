import { DynamoDBDocumentClient, UpdateCommand} from '@aws-sdk/lib-dynamodb';
import { DynamoDBClient } from '@aws-sdk/client-dynamodb';

const client = new DynamoDBClient({ region: 'us-east-1' });
const dynamoDB = DynamoDBDocumentClient.from(client);

export async function handler (event) {
  let response = { statusCode: 200, body: 'Data updated' };
  try {
    const body = JSON.parse(event.body);
    const updateParams = {
      TableName: 'UserData',
      Key: {
        userId: body.userId,
        username: body.Username,
      },
      UpdateExpression: 'set #data = :data, #role = :role',
      ExpressionAttributeNames: {
        '#data': 'data',
        '#role': 'role',
      },
      ExpressionAttributeValues: {
        ':data': body.data,
        ':role': body.Role
      },
      ReturnValues: "UPDATED_NEW"
    };
    
    const result = await dynamoDB.send(new UpdateCommand(updateParams));
    response.body = JSON.stringify({ message: 'Data successfully updated', updatedAttributes: result.Attributes });
    
    
  } catch (error) {
    console.error( "Error updating data", error)
    response = { statusCode: 500, body: 'An error occurred' };
  }
  
  
  return response;
  
}