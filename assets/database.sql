DROP TABLE IF EXISTS `Accounts`;

CREATE TABLE `Accounts` (
  `userID` int(10) NOT NULL,
  `userName` varchar(20) NOT NULL UNIQUE,
	`userPassword` varchar(20) NOT NULL,
	`userEmail` varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Accounts` WRITE;
INSERT INTO `Accounts` VALUES (1, 'Cake47', 'eggs#1', 'baking@yahoo.com'),(2, 'GnarlBurst', 'comsicChicken4', 'federalgrim@hotmail.com');
UNLOCK TABLES;
DROP TABLE IF EXISTS `Collections`;

CREATE TABLE `Collections` (
  `collectionID` int(10) NOT NULL UNIQUE,
  `userID` int(10) NOT NULL,
  PRIMARY KEY (`collectionID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Collections_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Collections` VALUES (1,1),(2,1),(3,2),(4,2), (5,1);


DROP TABLE IF EXISTS `Decks`;

CREATE TABLE `Decks` (
  `deckID` int(10) NOT NULL UNIQUE,
  `userID` int(10) NOT NULL,
  PRIMARY KEY (`deckID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Decks_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Decks`(`deckID`,`userID`) VALUES (1,2),(2,1),(3,2),(4,1), (5,1);

DROP TABLE IF EXISTS `Cards`;

CREATE TABLE `Cards` (
  `cardID` int(10) NOT NULL UNIQUE,
  `cardName` varchar(20) NOT NULL UNIQUE,
  `cardDescripstion` varchar(255) NOT NULL,
  `cardPrice` float,
  `cardForSale` bit,
  PRIMARY KEY (`cardID`),
  CONSTRAINT `Cards_ibfk_1` FOREIGN KEY (`cardID`) REFERENCES `CardDetails` (`cardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Cards` VALUES (1,'Black Lotus','0, Artifact, Sacrifice Black Lotus: Add three mana of any one color.', 22750.00, 1),(2,'inprogress','sad',NULL,0),(3,'inprogress2','sad',NULL,0),(4,'inprogress3','sad',NULL,1), (5,'inprogress4','sad',NULL,NULL);

DROP TABLE IF EXISTS `DeckCards`;

CREATE TABLE `DeckCards` (
  `deckCardsID` int(10) NOT NULL UNIQUE,
  `deckID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  `quantity` int(4) NOT NULL,
  KEY `deckID` (`deckID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `DeckCards` VALUES (1,1,1,3),(2,3,2,1),(3,2,4,2),(4,1,3,4), (5,4,2,1);

DROP TABLE IF EXISTS `CollectionCards`;

CREATE TABLE `CollectionCards` (
  `collectionCardsID` int(10) NOT NULL UNIQUE,
  `deckID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  KEY `deckID` (`deckID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
