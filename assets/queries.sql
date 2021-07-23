--This hopefully tells you every card in all of one accounts decks
--this should hopefully work for collections too.

SELECT * FROM `Cards`
WHERE cardID IN(SELECT deckID FROM `DeckCards`
WHERE deckID IN(SELECT userID  FROM `Decks`
WHERE userID = 1))
