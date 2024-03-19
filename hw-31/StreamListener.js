import { SESClient, SendTemplatedEmailCommand } from '@aws-sdk/client-ses';

export const handler = async (event) => {
  const client = new SESClient();
  
  for(const record of event.Records) {
    const dbName = record.eventSourceARN.split('/')[1];
    const templateData = {
      DB: dbName,
      EVENT_TYPE: record.eventName,
      NEW_IMAGE: JSON.stringify(record.dynamodb.NewImage ?? {}),
      OLD_IMAGE: JSON.stringify(record.dynamodb.OldImage ?? {}),
    };
    console.log({templateData});
    const input = {
      Source: "riinavi86@gmail.com",
      Destination: {
        ToAddresses: [
          "riinavi86@gmail.com",
        ],
      },
      Template: "HW31EmailTemplate",
      TemplateData: JSON.stringify(templateData),
    };
    
    const command = new SendTemplatedEmailCommand(input);
    await client.send(command);
  }
};
