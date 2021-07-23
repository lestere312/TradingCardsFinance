--****************
-- Accounts Page--
--

--Main table info

--****************
-- Decks Page--
--

--Name of each deck of user
SELECT deckName FROM `Decks`
WHERE userID = 1

--Main table info
SELECT * FROM `Cards`
JOIN DeckCards ON Cards.cardID = DeckCards.cardID
AND deckID = 1

--****************
-- Collections Page--
--

--Name of each collection of user
SELECT collectionName FROM `Collections`
WHERE userID = 1

--Main table info
SELECT * FROM `Cards`
JOIN CollectionCards ON Cards.cardID = CollectionCards.cardID
AND CollectionID = 1

--****************
-- Card Page--
--

--Main table info

--****************
-- Login Page--
--

--Main table info

--****************
-- Create Account Page--
--

--Main table info

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
