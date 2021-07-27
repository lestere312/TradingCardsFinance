var express = require('express');
var exphbs = require('express-handlebars');

var app = express();
app.use(express.json())
app.use(express.urlencoded({extended: true}))
var port = process.env.PORT || 3009;

app.engine('handlebars', exphbs({defaultLayout: 'main'}));
app.set('view engine', 'handlebars');


app.use(express.static('public'));

var db = require('./database/db-connector');


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
    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      return res.render('cards', {data: cardList});
    })
  }
  else{
    let query1;
    query1 = "SELECT * FROM Cards;";
    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      return res.render('cards', {data: cardList});
    })
  }
});

app.post('/addDeck', function(req, res)
{
  let data = req.body;
  let deckName = data.deck_name;
  let userName = data.user;

  query1 = `INSERT INTO Decks (userID, deckName) VALUES (${userName}, '${deckName}')`;
  db.pool.query(query1, function(error, rows, fields){
    if (error) {
      console.log(error);
    }else{
      res.redirect('/Deck');
    }
  });

});

app.get('/deck', function(req, res)
{
  if(Object.keys(req.query).length != 0){
    let query1;
    query1 = `SELECT * FROM Cards JOIN DeckCards ON Cards.cardID = DeckCards.cardID AND deckID = ${req.query.deckName}`;
    let query2;
    query2 = `SELECT deckName, deckID FROM Decks`;
    let query3;
    query3 = `SELECT deckName FROM Decks ORDER BY deckID`;


    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          console.log(req.query.deckName);
          let deckN = deck[req.query.deckName-1].deckName;
            return res.render('deck', {data: cardList, deckList: decks, deckName: deckN});
        })
      })
    })
  }else{
    let query1;
    query1 = "SELECT * FROM `Cards` JOIN DeckCards ON Cards.cardID = DeckCards.cardID AND deckID = 1";

    let query2;

    query2 = `SELECT deckName, deckID FROM Decks`;

    let query3;

    query3 = `SELECT deckName FROM Decks ORDER BY deckID`;

    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          let deckN = "NONE";
            return res.render('deck', {data: cardList, deckList: decks, deckName: deckN});
        })
      })
    })
  }
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

app.listen(port, () => console.log('server started on port:' + port));
