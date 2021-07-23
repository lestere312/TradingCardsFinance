DROP TABLE IF EXISTS `Accounts`;

CREATE TABLE `Accounts` (
  "userID" int(10) NOT NULL,
  "userName" varchar(20) NOT NULL UNIQUE,
	"userPassword" varchar(20) NOT NULL,
	"userEmail" varchar(20) NOT NULL UNIQUE
  PRIMARY KEY (`userID`)
  /*KEY `productLine` (`productLine`),
  CONSTRAINT `Accounts_ibfk_1` FOREIGN KEY (`productLine`) REFERENCES `productlines` (`productLine`)
  AUTO_INCREMENT*/
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Accounts`(`userID`,`userName`,`userPassword`,`userEmail`) values (00000000001, "Cake47", "eggs#1", "baking@yahoo.com"),(00000000002, "GnarlBurst", "comsicChicken4", "federalgrim@hotmail.com");


DROP TABLE IF EXISTS `Collections`;

CREATE TABLE `Collections` (
  "collectionID" int(10) NOT NULL UNIQUE,
  "userID" int(10) NOT NULL,
  PRIMARY KEY (`collectionID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Collections_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Collections`(`collectionID`,`userID`) values (00000000001,00000000001),(00000000002,00000000001),(00000000003,00000000002),(00000000004,00000000002), (00000000005,00000000001);


DROP TABLE IF EXISTS `Decks`;

CREATE TABLE `Decks` (
  "deckID" int(10) NOT NULL UNIQUE,
  "userID" int(10) NOT NULL,
  PRIMARY KEY (`deckID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Decks_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Decks`(`deckID`,`userID`) values (00000000001,00000000002),(00000000002,00000000001),(00000000003,00000000002),(00000000004,00000000001), (00000000005,00000000001);

DROP TABLE IF EXISTS `Decks`;

CREATE TABLE `Cards` (
  "cardID" int(10) NOT NULL UNIQUE,
  "cardForSale" bit,
  PRIMARY KEY (`collectionID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `Cards_ibfk_1` FOREIGN KEY (`cardID`) REFERENCES `CardDetails` (`cardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Cards`(`cardID`,`cardForSale`) values (00000000001,1),(00000000002,0),(00000000003,0),(00000000004,1), (00000000005,NULL);


DROP TABLE IF EXISTS `DeckCards`;

CREATE TABLE `DeckCards` (
  "deckCardsID" int(10) NOT NULL UNIQUE,
  "deckID" int(10) NOT NULL,
  "cardID" int(10) NOT NULL,
  PRIMARY KEY (`collectionID`),
  KEY `deckID` (`deckID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `DeckCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


DROP TABLE IF EXISTS `CollectionCards`;

CREATE TABLE `CollectionCards` (
  "collectionCardsID" int(10) NOT NULL UNIQUE,
  "deckID" int(10) NOT NULL,
  "cardID" int(10) NOT NULL,
  PRIMARY KEY (`collectionID`),
  KEY `deckID` (`deckID`),
  KEY `cardID` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`),
  CONSTRAINT `CollectionCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

DROP TABLE IF EXISTS `CardDetails`;

CREATE TABLE `CardDetails` (
  "cardID" int(10) NOT NULL,
  "cardName" varchar(20) NOT NULL UNIQUE,
	"cardDescripstion" varchar(255) NOT NULL,
  "cardPrice" float,
  KEY `cardID` (`cardID`),
  CONSTRAINT `CardDetails_ibfk_1` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Cards`(`cardID`,`cardName`,`cardDescripstion`) values (00000000001,"Black Lotus","0, Artifact, Sacrifice Black Lotus: Add three mana of any one color.", 22750.00),(00000000002,"0","sad",NULL),(00000000003,"0","sad",NULL),(00000000004,"0","sad",NULL), (00000000005,"0","sad",NULL);
