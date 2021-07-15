const express = require('express');
const path = require('path');
const fs = require('fs')

const http = require('http');

const app = express();

app.use(express.static('public'));

const PORT = process.env.PORT || 3007;

app.listen(PORT, () => console.log('server started on port:' + PORT));
