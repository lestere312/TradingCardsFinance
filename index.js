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

// Get an instance of mysql we can use in the app
var mysql = require('mysql')

// Create a 'connection pool' using the provided credentials
var pool = mysql.createPool({
    connectionLimit : 10,
    host            : 'classmysql.engr.oregonstate.edu',
    user            : 'cs340_lestere',
    password        : 'tradingcards#21',
    database        : 'cs340_lestere'
})

const PORT = process.env.PORT || 3007;

app.get('/', function(req, res)
{
  return res.render('home');
});

app.get('/home', function(req, res)
{
            return res.render('home');
});

app.get('/cards', function(req, res)
{
  console.log(Object.keys(req.query).length != 0);
  if(Object.keys(req.query).length != 0){
    let query1;
    console.log(req.query.sale);
    if(req.query.sale == 'on'){
      query1 = `SELECT * FROM Cards WHERE cardName LIKE "${req.query.search}%" AND cardForSale = 1`
    }else{
      query1 = `SELECT * FROM Cards WHERE cardName LIKE "${req.query.search}%"`
    }
    pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      return res.render('cards', {data: cardList});
    })
  }
  else{
    let query1;
    query1 = "SELECT * FROM Cards;";
    pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      return res.render('cards', {data: cardList});
    })
  }
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
  let data = req.query;
  console.log(data);
  let deckName = data.Deck_Name;
  let collectionName = data.Collection_Name;
  if(deckName != undefined){
    console.log(deckName);
  }

  if(collectionName != undefined){
    console.log(collectionName);
  }


            return res.render('account');
});

app.get('/accountCreation', function(req, res)
{
            return res.render('accountCreation');
});

app.listen(PORT, () => console.log('server started on port:' + PORT));
