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
