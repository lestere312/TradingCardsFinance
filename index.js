var express = require('express');
var exphbs = require('express-handlebars');

var app = express();
app.use(express.json())
app.use(express.urlencoded({extended: true}))
var port = process.env.PORT || 4746;

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

      query2 = `INSERT INTO Decks (userID, deckName) VALUES (${userName}, '${deckName}')`;
      db.pool.query(query2, function(error, rows, fields){
        if (error) {
          console.log(error);
        }else{
          res.redirect('/Deck');
        }

  })
});

app.post('/addCollection', function(req, res)
{
  console.log(req.body.user);
  console.log("req.body.newCollectionName");
  let collectionName = req.body.newCollectionName;
  let userName = req.body.user;
  query1 = `SELECT userID FROM Accounts WHERE userID = '${userName}'`;
    db.pool.query(query1, function(error, rows, fields){
    let names = rows;
    console.log(names);
    console.log("name");
    let user = names[0].userID
      query2 = `INSERT INTO Collections (userID, collectionName) VALUES (${user}, '${collectionName}')`;
      db.pool.query(query2, function(error, rows, fields){
        if (error) {
          console.log(error);
        }else{
          res.redirect('/Collection');
        }
      });
  });
});

app.post('/deleteAccount', function(req, res)
{
  let data = req.body;
  let userid = data.userid;
  console.log(data);
  console.log(userid);
  console.log("userid");
  //res.redirect('/Deck');
  query5 = `SELECT collectionID FROM Collections WHERE userID = ${userid}`;
  db.pool.query(query5, function(error, rows, fields){
    let collectionIDS = rows;
    query4 = `SELECT deckID FROM Decks WHERE userID = ${userid}`;
    db.pool.query(query4, function(error, rows, fields){
      let deckIDS = rows;
      if(deckIDS){
        console.log(deckIDS);
        console.log(deckIDS[0]);
        console.log("deckIDS");
        for(let i = 0; i < deckIDS.length; i++){
          let temp = deckIDS[i].deckID;
          console.log(temp);
          console.log("temp");
          query1 = `DELETE FROM DeckCards WHERE deckID = ${temp}`;
          db.pool.query(query1, function(error, rows, fields){

          })
        }
      }
      if(collectionIDS){
        for(let i = 0; i < collectionIDS.length; i++){
          let temp = collectionIDS[i].collectionID;
          console.log(temp);
          console.log("tempcollectionID");
          query1 = `DELETE FROM CollectionCards WHERE collectionID = ${temp}`;
          db.pool.query(query1, function(error, rows, fields){

          })
        }
      }
        query2 = `DELETE FROM Decks WHERE userID = ${userid}`;
        db.pool.query(query2, function(error, rows, fields){
          query6 = `DELETE FROM Collections WHERE userID = ${userid}`;
          db.pool.query(query6, function(error, rows, fields){
              query3 = `DELETE FROM Accounts WHERE userID = ${userid}`;
              db.pool.query(query3, function(error, rows, fields){


              })

          })
        })
    })
  })
   res.redirect('/Account');
});

app.post('/deleteDeck', function(req, res)
{
  let data = req.body;
  let deckName = data.deck_Name;
  console.log(data);
  console.log(deckName);
  console.log("deckName");
  //res.redirect('/Deck');
  query1 = `DELETE FROM DeckCards WHERE deckID = ${deckName}`;
  db.pool.query(query1, function(error, rows, fields){
    query2 = `DELETE FROM Decks WHERE deckID = ${deckName}`;
    db.pool.query(query2, function(error, rows, fields){

    })
  })
   res.redirect('/Deck');
});

app.post('/deleteCollection', function(req, res)
{
  let data = req.body;
  console.log(data);
  let collectionName = data.collectionName;
  console.log(collectionName);
  console.log("collectionName");
  query1 = `DELETE FROM CollectionCards WHERE collectionID = ${collectionName}`;
  db.pool.query(query1, function(error, rows, fields){
    query2 = `DELETE FROM Collections WHERE collectionID = ${collectionName}`;
    db.pool.query(query2, function(error, rows, fields){

    })
  })
   res.redirect('/Collection');
});



app.post('/deleteDeckcard', function(req, res)
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

app.post('/deleteCollectioncard', function(req, res)
{
  let data = req.body;
  let cardName = data.cardName;
  let collectionName = data.collectionName;
  console.log(data);
  console.log(collectionName);
  console.log("deletetee");
  query1 = `DELETE FROM CollectionCards WHERE collectionID = ${collectionName} AND cardID = ${cardName}`;
  db.pool.query(query1, function(error, rows, fields){

   })
   res.redirect('/Collection');
});


app.post('/addCollectionCard', function(req, res)
{
  let data = req.body;
  let cardName = data.Card_Name;
  let quantity = data.Quantity;
  let collectionName = data.newCollectionName;
  console.log(cardName);
  console.log(quantity);
  console.log(collectionName);
  // query1 = `SELECT cardID FROM Cards WHERE cardID =  '${cardName}'`;
  // db.pool.query(query1, function(error, rows, fields){
  //   let temp = rows;
  //   let cardid = temp[0].cardID;
  //   console.log(cardid);
  //   console.log("cardid");
    query2 = `INSERT INTO CollectionCards (collectionID, cardID, quantity) VALUES(${collectionName},${cardName}, ${quantity})`;
      db.pool.query(query2, function(error, rows, fields){
        if (error) {
          console.log(error);
        }else{
          res.redirect('/collection');
        }
      })
  // })
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
    query3 = `SELECT * FROM Decks JOIN Accounts ON Accounts.userID = Decks.userID `;
    let query4;
    query4 = `SELECT * FROM Cards`;
    let query5;
    query5 = `SELECT * FROM Accounts`;

    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      console.log(cardList);
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          db.pool.query(query4, function(error, rows, fields){
            let cards = rows;
            db.pool.query(query5, function(error, rows, fields){
                let accountsList = rows;
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
              return res.render('deck', {data: cardList, deckList: decks, deckName: answer, cards: cards, accountsList:accountsList});
              })
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

    let query5;
    query5 = `SELECT * FROM Accounts`;

    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      db.pool.query(query2, function(error, rows, fields){
        let decks = rows;
        db.pool.query(query3, function(error, rows, fields){
          let deck = rows;
          db.pool.query(query4, function(error, rows, fields){
            let cards = rows;
            db.pool.query(query5, function(error, rows, fields){
                let accountsList = rows;
                let deckN = "NONE";
                console.log(cards);
                return res.render('deck', {data: cardList, deckList: decks, deckName: deckN, cards: cards, accountsList:accountsList});
            })
          })
        })
      })
    })
  }
});

app.get('/collection', function(req, res)
{

    let query1;
    query1 = "SELECT * FROM Cards JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID JOIN Collections ON CollectionCards.collectionID = Collections.collectionID";

    let query2;
    query2 = "SELECT collectionName, collectionID FROM Collections";

    let query3;
    query3 = "SELECT userName, userID FROM Accounts";

    let query4;
    query4 = "SELECT collectionID, collectionName, userName FROM Collections JOIN Accounts ON Collections.userID = Accounts.userID";

    let query5;
    query5 = "SELECT cardID, cardName FROM Cards";


    db.pool.query(query1, function(error, rows, fields){
      let cardList = rows;
      db.pool.query(query2, function(error, rows, fields){
        let collectionList = rows;
        db.pool.query(query3, function(error, rows, fields){
          let accountsList = rows;
          db.pool.query(query4, function(error, rows, fields){
            let accountsElement = rows;
            db.pool.query(query5, function(error, rows, fields){
              let cardlist2 = rows;
              console.log(collectionList);
              console.log("collectionList");
              return res.render('collection', {data: cardList, collectionList: collectionList, accountsList: accountsList, accountsElement:accountsElement, cardlist2:cardlist2});
            })
          })
        })
      })
    })
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

app.post('/addAccount', function(req, res)
{
  let data = req.body;
  let account = data.Account_Name;
  let password = data.Password;
  let email = data.Email;

    query2 = `INSERT INTO Accounts (userName, userPassword, userEmail) VALUES ('${account}','${password}', '${email}')`;
    db.pool.query(query2, function(error, rows, fields){
      if (error) {
        console.log(error);
      }else{
        res.redirect('/Account');
      }
    });

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

app.listen(port, () => console.log('server started on port:' + port));
