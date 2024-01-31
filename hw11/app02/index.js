const express = require('express');
const app = express();
const port = 8084;

app.get('/', (req, res) => {
  res.send('This is app#2');
});

app.get('/health', (req, res) => {
  res.send('HealthCheck path of app#2');
});

app.listen(port, () => {
  console.log(`Server listens to port ${port}`);
});
