DROP TABLE IF EXISTS `Accounts`;

CREATE TABLE `Accounts` (
  `userID` int(10) NOT NULL,
  `userName` varchar(20) NOT NULL UNIQUE,
	`userPassword` varchar(20) NOT NULL,
	`userEmail` varchar(20) NOT NULL UNIQUE,
  PRIMARY KEY (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

LOCK TABLES `Accounts` WRITE;
INSERT INTO `Accounts` VALUES (0000000001, 'Cake47', 'eggs#1', 'baking@yahoo.com'),(0000000002, 'GnarlBurst', 'comsicChicken4', 'federalgrim@hotmail.com');
UNLOCK TABLES;
DROP TABLE IF EXISTS `Collections`;

CREATE TABLE `Collections` (
  `collectionID` int(10) NOT NULL UNIQUE,
  `userID` int(10) NOT NULL,
  PRIMARY KEY (`collectionID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Collections_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Collections` VALUES (0000000001,0000000001),(0000000002,0000000001),(0000000003,0000000002),(0000000004,0000000002), (0000000005,0000000001);


DROP TABLE IF EXISTS `Decks`;

CREATE TABLE `Decks` (
  `deckID` int(10) NOT NULL UNIQUE,
  `userID` int(10) NOT NULL,
  PRIMARY KEY (`deckID`),
  KEY `userID` (`userID`),
  CONSTRAINT `Decks_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Decks`(`deckID`,`userID`) VALUES (0000000001,0000000002),(0000000002,0000000001),(0000000003,0000000002),(0000000004,0000000001), (0000000005,0000000001);

DROP TABLE IF EXISTS `Cards`;

CREATE TABLE `Cards` (
  `cardID` int(10) NOT NULL UNIQUE,
  `cardForSale` bit,
  PRIMARY KEY (`cardID`),
  CONSTRAINT `Cards_ibfk_1` FOREIGN KEY (`cardID`) REFERENCES `CardDetails` (`cardID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `Cards`(`cardID`,`cardForSale`) VALUES (0000000001,1),(0000000002,0),(0000000003,0),(0000000004,1), (0000000005,NULL);
