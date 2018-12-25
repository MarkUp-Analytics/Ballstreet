const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const morgan = require('morgan');
const path = require('path');

const app = express();

app.use(morgan('combined'));
app.use(bodyParser.json());
app.use(cors());
// app.use(cors({origin: 'http://ballstreet-dev.s3-website-us-east-1.amazonaws.com'}));


const routes = require('./routes/');
routes(app);

//These 2 lines make sure that vue and express app are coming from the same server.
app.use('/static', express.static(path.join(__dirname, "../public/dist/static/")));

app.get('/', function(req,res) {
    res.sendFile('index.html', { root: path.join(__dirname, '../public/dist/') });
  });


module.exports = app
