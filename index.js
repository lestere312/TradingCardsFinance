var express = require('express');
var app = express();
app.use(express.json())
app.use(express.urlencoded({extended: true}))



var exphbs = require('express-handlebars');
const { query } = require('express');
app.engine('.hbs', exphbs({
    extname: ".hbs"
}));
app.set('view engine', '.hbs');

app.use(express.static('public'));

const PORT = process.env.PORT || 3007;

app.get('/', function(req, res)
{
            return res.render('index');
});

app.get('/cards', function(req, res)
{
            return res.render('cards');
});

app.get('/deck', function(req, res)
{
            return res.render('deck');
});

app.get('/collection', function(req, res)
{
            return res.render('collection');
});

app.get('/login', function(req, res)
{
            return res.render('login');
});

app.get('/account', function(req, res)
{
            return res.render('account');
});

app.get('/accountCreation', function(req, res)
{
            return res.render('accountCreation');
});

app.listen(PORT, () => console.log('server started on port:' + PORT));
