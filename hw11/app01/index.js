const express = require('express');
const app = express();
const port = 8083;

app.get('/', (req, res) => {
  res.send('This is app#1');
});

app.get('/health', (req, res) => {
  res.send('HealthCheck path of app#1');
});

app.listen(port, () => {
  console.log(`Server listens to port ${port}`);
});
