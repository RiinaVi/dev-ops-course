import { DynamoDBDocumentClient, DeleteCommand} from '@aws-sdk/lib-dynamodb' ;
import { DynamoDBClient } from '@aws-sdk/client-dynamodb' ;

const client = new DynamoDBClient({ region: 'us-east-1' });
const dynamoDB = DynamoDBDocumentClient.from(client);

export async function handler (event) {
  let response = { statusCode: 200, body: 'Data deleted' };
  try {
    const body = JSON.parse(event.body);
    const params = {
      TableName: 'UserData',
      Key: {
        userId: body.userId,
        username: body.Username,
      }
    };
    
    await dynamoDB.send(new DeleteCommand(params) );
    response.body = 'Data successfully deleted';
    
  } catch (error) {
    console.error( "Error deleting data", error)
    response = { statusCode: 500, body: 'An error occurred' };
  }
  
  return response;
}