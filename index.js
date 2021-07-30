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
      query1 = `SELECT * FROM Cards WHERE cardName LIKE "${req.query.search}%" AND cardForSale = 'yes'`
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

app.post('/updateCard', function(req, res)
{
  let data = req.body;
  console.log(data);
  console.log("data");
  let cardName = data.Card_Name;
  let description= data.Description;
  let price= data.Price;
  let forSale = data.ForSale;
  let forSaleAnswer = "";
  if(forSale){
    forSaleAnswer = "Yes";
  }else{
    forSaleAnswer = "No";
  }

  query1 = `SELECT cardID FROM Cards WHERE cardName =  '${cardName}'`;
  db.pool.query(query1, function(error, rows, fields){
    let temp = rows;
    let cardid = temp[0].cardID;
    query2 = `UPDATE Cards SET cardName='${cardName}',cardDescripstion='${description}',cardPrice='${price}',cardForSale='${forSaleAnswer}' WHERE cardID = ${cardid}`;
    db.pool.query(query2, function(error, rows, fields){

     })
   })
  res.redirect('/Cards');

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

app.post('/deleteDeck', function(req, res)
{
  let data = req.body;
  let deckName = data.deck_Name;
  console.log(data);
  console.log(deckName);
  console.log("deckName");
  //res.redirect('/Deck');
  query1 = `DELETE FROM Decks WHERE deckID = ${deckName}`;
  db.pool.query(query1, function(error, rows, fields){

   })
   res.redirect('/Deck');
});

app.post('/deleteCard', function(req, res)
{
  let data = req.body;
  let cardName = data.cardName;
  let deckName = data.deckName;
  console.log(data);
  console.log(deckName);
  console.log("deletetee");
  //res.redirect('/Deck');
  query1 = `DELETE FROM DeckCards WHERE deckID = ${deckName} AND cardID = ${cardName}`;
  db.pool.query(query1, function(error, rows, fields){

   })
   res.redirect('/Deck');
});

app.post('/addCard', function(req, res)
{
  let data = req.body;
  let cardName = data.Card_Name;
  let quantity = data.Quantity;
  let deck = data.Deck;
  console.log(cardName);
  console.log(quantity);
  console.log(deck);
  query1 = `SELECT cardID FROM Cards WHERE cardName =  '${cardName}'`;


  db.pool.query(query1, function(error, rows, fields){
    let temp = rows;
    let cardid = temp[0].cardID;
    console.log(cardid);
    console.log("cardid");
    query2 = `INSERT INTO DeckCards (deckID, cardID, quantity) VALUES(${deck},${cardid}, ${quantity})`;
      db.pool.query(query2, function(error, rows, fields){
        if (error) {
          console.log(error);
        }else{
          res.redirect('/Deck');
        }
      })
  })
});



app.get('/deck', function(req, res)
{
  if(Object.keys(req.query).length != 0){
    let query1;
    query1 = `SELECT * FROM Cards JOIN DeckCards ON Cards.cardID = DeckCards.cardID AND deckID = ${req.query.deckName}`;
    let query2;
    query2 = `SELECT deckName, deckID FROM Decks`;
    let query3;
    query3 = `SELECT deckName, deckID FROM Decks ORDER BY deckID`;
    let query4;
    query4 = `SELECT * FROM Cards`;

    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          db.pool.query(query4, function(error, rows, fields){
            let cards = rows;
            //console.log(req.query.deckName);
            //console.log("req.query.deckName");
            //console.log(deck.deckID);
            //console.log(deck);
            //console.log(deck.length);
            let answer;
            for(let i = 0; i < deck.length; i++){
              //console.log(deck[i]);
              //console.log(deck[i].deckID);
              //console.log(req.query.deckName);
              //console.log(deck[i].deckID == req.query.deckName);
              if(deck[i].deckID == req.query.deckName){
                answer = deck[i];
              }
            }
            //console.log("answer");
            console.log(cards);
            //let deckN = deck[0].deckName;
            return res.render('deck', {data: cardList, deckList: decks, deckName: answer, cards: cards});
          })
        })
      })
    })
  }else{
    let query1;
    query1 = "SELECT * FROM `Cards` JOIN DeckCards ON Cards.cardID = DeckCards.cardID AND deckID = 0";

    let query2;

    query2 = `SELECT deckName, deckID FROM Decks`;

    let query3;

    query3 = `SELECT deckName FROM Decks ORDER BY deckID`;

    let query4;

    query4 = `SELECT * FROM Cards`;

    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          db.pool.query(query4, function(error, rows, fields){
              let cards = rows;
              let deckN = "NONE";
              console.log(cards);
              return res.render('deck', {data: cardList, deckList: decks, deckName: deckN, cards: cards});
          })
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
  // let data = req.query;
  // console.log(data);
  // let deckName = data.Deck_Name;
  // let collectionName = data.Collection_Name;
  // if(deckName != undefined){
  //   console.log(deckName);
  // }
  //
  // if(collectionName != undefined){
  //   console.log(collectionName);
  // }

  query1 = `SELECT * FROM Accounts`;
  db.pool.query(query1, function(error, rows, fields){
    let accountList = rows;
    return res.render('account', {data: accountList});
  })

});

app.post('/addCardData', function(req, res)
{
  console.log(Object.keys(req.body).length);
  if(Object.keys(req.body).length > 2){
    let data = req.body;
    let cardName = data.Card_Name;
    let description = data.Description;
    let price = data.Price;
    let forSale = data.ForSale;
    let forSaleAnswer = "";
    if(forSale){
      forSaleAnswer = "yes";
    }else{
      forSaleAnswer = "no";
    }
    console.log(cardName);
    console.log(price);
    console.log(forSale);
    query1 = `INSERT INTO Cards(cardName, cardDescripstion, cardPrice, cardForSale) VALUES ('${cardName}','${description}',${price},'${forSaleAnswer}')`;
      db.pool.query(query1, function(error, rows, fields){
        if (error) {
          console.log(error);
        }else{
          res.redirect('/Cards');
        }
      })

  }else{
    console.log("Not enough info");
    res.redirect('/Cards');
  }

});

app.get('/accountCreation', function(req, res)
{
            return res.render('accountCreation');
});

app.listen(port, () => console.log('server started on port:' + port));
