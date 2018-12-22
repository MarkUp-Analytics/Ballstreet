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


module.exports = app
