--****************
-- Accounts Page--
--

-- Sum of unique cards
SELECT COUNT(quantity) FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
WHERE CollectionID IN(SELECT CollectionID  FROM `Collections`
WHERE userID = 1)

--Number of Decks
SELECT COUNT(deckID) FROM `Decks`
WHERE userID = 1

--Number of Collections
SELECT COUNT(collectionID) FROM `Collections`
WHERE userID = 1

--Total collection price
SELECT SUM(quantity*cardPrice) FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
WHERE collectionID IN(SELECT collectionID  FROM `Decks`
WHERE userID = 1)


--****************
-- Decks Page--
--

--Name of each deck
SELECT deckName FROM `Decks`
WHERE userID = 1

--Total Cards in a deck
SELECT SUM(quantity)
FROM `DeckCards`
WHERE deckID = 1

--Delete Deck
DELETE FROM 'DeckCards' WHERE deckID = 1;
DELETE FROM 'Decks' WHERE deckID = 1

--Create new Deck
INSERT INTO Decks(deckID, userID, deckName) VALUES ('[value-1]','[value-2]','[value-3]')

--Add Card
INSERT INTO Decks(deckID, userID, deckName) VALUES('[value-1]','[value-2]','[value-3]')


--Main table info
SELECT * FROM `Cards`
JOIN DeckCards ON Cards.cardID = DeckCards.cardID
AND deckID = 1

--****************
-- Collections Page--
--

--
INSERT INTO `CollectionCards` VALUES (:collecteionCardID,:collectionID,(SELECT cardID FROM `Cards` WHERE cardName =:nameInput),:quantityInput)

--Name of each collection of user
SELECT collectionName FROM `Collections`
WHERE userID = 1

--Total Cards in a collection
SELECT SUM(quantity)
FROM `CollectionCards`
WHERE collectionID = 1

--Total collection value
SELECT SUM(quantity*cardPrice) FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
WHERE collectionID IN(SELECT collectionID  FROM `Decks`
WHERE collectionID = 1)

--Main table info
SELECT * FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
AND CollectionID = 1

--****************
-- Card Page--
--

--Main table info
--Can delete last two lines if fresh page
SELECT *
FROM Cards
WHERE cardName = 'Black Lotus'
AND cardForSale = 1
--****************
-- Login Page--
--

--Selects user id of users that have username and password.
SELECT userID
FROM Accounts
WHERE userName = 'cake47'
AND userPassword = 'eggs#1'
--****************
-- Create Account Page--
--

--check if account already exists
SELECT userID
FROM Accounts
WHERE userName = 'cake47'

--Create New Account
INSERT INTO `Accounts` VALUES (:userID,:userName,:userPassword,:userEmail)


--****************
--Others

--
--This hopefully tells you every card in all of one accounts decks
--this should hopefully work for collections too.
--

SELECT * FROM `Cards`
WHERE cardID IN(SELECT cardID FROM `DeckCards`
WHERE deckID IN(SELECT deckID  FROM `Decks`
WHERE userID = 1))
--better version
SELECT * FROM `Cards`
JOIN DeckCards ON Cards.cardID = DeckCards.cardID
WHERE deckID IN(SELECT deckID  FROM `Decks`
WHERE userID = 1)

--Main table info
SELECT * FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
AND CollectionID = 1

--
--Gets cards from specific deck
--

SELECT * FROM `Cards`
WHERE cardID IN(SELECT cardID FROM `DeckCards`
WHERE deckID = 1)
--Better version
SELECT * FROM `Cards`
JOIN DeckCards ON Cards.cardID = DeckCards.cardID
AND deckID = 1

--
--List of deck names by a user
--

SELECT deckName FROM `Decks`
WHERE userID = 1
