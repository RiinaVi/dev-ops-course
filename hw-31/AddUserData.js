import { DynamoDBDocumentClient, PutCommand} from '@aws-sdk/lib-dynamodb' ;
import { DynamoDBClient } from '@aws-sdk/client-dynamodb' ;

const client = new DynamoDBClient({ region: 'us-east-1' });
const dynamoDB = DynamoDBDocumentClient.from(client);

export async function handler (event) {
  let response = { statusCode: 200, body: 'Data updated' };
  try {
    const body = JSON.parse(event.body);
    const params = {
      TableName: 'UserData',
      Item: {
        userId: body.userId,
        data: body.data,
        username: body.Username,
        role: body.Role
      }
    };
    
    await dynamoDB.send(new PutCommand(params) );
    response.body = 'Data successfully updated';
    
  } catch (error) {
    console.error( "Error updating data", error)
    response = { statusCode: 500, body: 'An error occurred' };
  }
  
  return response;
}