DROP TABLE IF EXISTS `Accounts`;

CREATE TABLE `Accounts` (
  `userID` int(10) NOT NULL AUTO_INCREMENT,
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
  `collectionID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `collectionName` varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (`collectionID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Collections_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Collections` VALUES (1,1,'main'),(2,1,'main1'),(3,2,'main2'),(4,2,'main3'), (5,1,'main4');


DROP TABLE IF EXISTS `Decks`;

CREATE TABLE `Decks` (
  `deckID` int(10) NOT NULL AUTO_INCREMENT,
  `userID` int(10) NOT NULL,
  `deckName` varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (`deckID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Decks_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Decks` VALUES (1,2,'Caravan'),(2,1,'Mill'),(3,2,'cake'),(4,1,'cake2'), (5,1,'cake3');

DROP TABLE IF EXISTS `Cards`;

CREATE TABLE `Cards` (
  `cardID` int(10) NOT NULL AUTO_INCREMENT,
  `cardName` varchar(20) NOT NULL UNIQUE,
  `cardDescripstion` varchar(255) NOT NULL,
  `cardPrice` float,
  `cardForSale` bit,
  PRIMARY KEY (`cardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Cards` VALUES (1,'Black Lotus','Edition: Alpha Type: Artifact 0, Artifact, Sacrifice Black Lotus: Add three mana of any one color.', 22750, 1),
(2,'Bandlands','Edition: Alpha Type: Land - Swamp Mountain Cast: Rarity: R : Add  or  to your mana pool.',7500,1),
(3,'Mox Emerald','Edition: Alpha Type: Artifact Cast: Rarity: R , Add  to your mana pool.',33000,1),
(4,'Wheel of Fortune','Edition: Alpha Type: Sorcery Cast: Rarity: R Each player discards their hand, then draws seven cards.',10000,0),
(5,'Birds of Paradise','Edition: Alpha Type: Creature Cast: Rarity: R Flying Tap: Aadd one mana of any color to your mana pool. Stats: 0/1',7500,1),
(6,'Frozen Shade','Edition: Alpha Type: Creature Cast: Rarity: C Tap : Frozen Shade gets +1/+1 until end of turn. Stats: 0/1',65,1),
(7,'Mountain','Edition: Alpha Type: Land Cast: Rarity: L',75,1),
(8,'Swamp','Edition: Alpha Type: Land Cast: Rarity: L',80,0),
(9,'Mind Twist','Edition: Alpha Type: Sorcery Cast: B X Rarity: R Target player discards X cards at random.',4600,0);

DROP TABLE IF EXISTS `DeckCards`;

CREATE TABLE `DeckCards` (
  `deckCardsID` int(10) NOT NULL AUTO_INCREMENT,
  `deckID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  `quantity` int(4) NOT NULL,
  KEY `deckCardsID` (`deckCardsID`),
  KEY `deckID` (`deckID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `DeckCards` VALUES (1,1,1,1),(2,1,2,3),(3,1,7,12),(4,1,8,10),(5,1,9,4);

DROP TABLE IF EXISTS `CollectionCards`;

CREATE TABLE `CollectionCards` (
  `collectionCardsID` int(10) NOT NULL AUTO_INCREMENT,
  `collectionID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  `quantity` int(4) NOT NULL,
  KEY `collectionCardsID` (`collectionCardsID`),
  KEY `collectionID` (`collectionID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_1` FOREIGN KEY (`collectionID`) REFERENCES `Collections` (`collectionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `CollectionCards` VALUES (1,1,1,3),(2,3,2,1),(3,2,4,2),(4,1,3,4), (5,4,2,1);
