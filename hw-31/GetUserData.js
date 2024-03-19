import { DynamoDBDocumentClient, ScanCommand} from '@aws-sdk/lib-dynamodb' ;
import { DynamoDBClient } from '@aws-sdk/client-dynamodb' ;

const client = new DynamoDBClient({ region: 'us-east-1' });
const dynamoDB = DynamoDBDocumentClient.from(client);

export async function handler (event) {
  let response = { statusCode: 200, body: 'Query completed' };
  try {
    
    const queryParams = event.queryStringParameters;
    let filterExpression = "";
    let expressionAttributeNames = {};
    let expressionAttributeValues = {};
    
    for (const [key, value] of Object.entries(queryParams)) {
      const attributeName = `#${key}`;
      const attributeValue = `:${key}`;
      
      filterExpression += `${filterExpression ? " and " : ""}${attributeName} = ${attributeValue}`;
      expressionAttributeNames[attributeName] = key;
      expressionAttributeValues[attributeValue] = value;
    }
    
    const params = {
      TableName: 'UserData',
      FilterExpression: filterExpression,
      ExpressionAttributeNames: expressionAttributeNames,
      ExpressionAttributeValues: expressionAttributeValues,
      
    };
    
    const result = await dynamoDB.send(new ScanCommand(params) );
    response.body = JSON.stringify(result.Items);
    
  } catch (error) {
    console.error( "Error querying data", error)
    response = { statusCode: 500, body: 'An error occurred' };
  }
  
  return response;
}