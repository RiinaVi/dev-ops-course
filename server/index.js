const express = require('express');
const cors = require('cors');
const app = express();
const port = 8082;

app.use(cors());

app.get('/', (req, res) => {
  res.send('Success!');
});

app.listen(port, () => {
  console.log(`Server runs on ${port} port`);
});
