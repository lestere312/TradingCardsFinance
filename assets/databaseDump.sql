-- phpMyAdmin SQL Dump
-- version 5.1.1-1.el7.remi
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 26, 2021 at 03:41 PM
-- Server version: 10.4.20-MariaDB-log
-- PHP Version: 7.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs340_lestere`
--

-- --------------------------------------------------------

--
-- Table structure for table `Accounts`
--

CREATE TABLE `Accounts` (
  `userID` int(10) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `userPassword` varchar(20) NOT NULL,
  `userEmail` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Accounts`
--

INSERT INTO `Accounts` (`userID`, `userName`, `userPassword`, `userEmail`) VALUES
(1, 'Cake47', 'eggs#1', 'baking@yahoo.com'),
(2, 'GnarlBurst', 'comsicChicken4', 'federalgrim@hotmail.');

-- --------------------------------------------------------

--
-- Table structure for table `Cards`
--

CREATE TABLE `Cards` (
  `cardID` int(10) NOT NULL,
  `cardName` varchar(20) NOT NULL,
  `cardDescripstion` varchar(255) NOT NULL,
  `cardPrice` float DEFAULT NULL,
  `cardForSale` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Cards`
--

INSERT INTO `Cards` (`cardID`, `cardName`, `cardDescripstion`, `cardPrice`, `cardForSale`) VALUES
(1, 'Black Lotus', 'Edition: Alpha Type: Artifact 0, Artifact, Sacrifice Black Lotus: Add three mana of any one color.', 22750, b'1'),
(2, 'Bandlands', 'Edition: Alpha Type: Land - Swamp Mountain Cast: Rarity: R : Add  or  to your mana pool.', 7500, b'1'),
(3, 'Mox Emerald', 'Edition: Alpha Type: Artifact Cast: Rarity: R , Add  to your mana pool.', 33000, b'1'),
(4, 'Wheel of Fortune', 'Edition: Alpha Type: Sorcery Cast: Rarity: R Each player discards their hand, then draws seven cards.', 10000, b'0'),
(5, 'Birds of Paradise', 'Edition: Alpha Type: Creature Cast: Rarity: R Flying Tap: Aadd one mana of any color to your mana pool. Stats: 0/1', 7500, b'1'),
(6, 'Frozen Shade', 'Edition: Alpha Type: Creature Cast: Rarity: C Tap : Frozen Shade gets +1/+1 until end of turn. Stats: 0/1', 65, b'1'),
(7, 'Mountain', 'Edition: Alpha Type: Land Cast: Rarity: L', 75, b'1'),
(8, 'Swamp', 'Edition: Alpha Type: Land Cast: Rarity: L', 80, b'0'),
(9, 'Mind Twist', 'Edition: Alpha Type: Sorcery Cast: B X Rarity: R Target player discards X cards at random.', 4600, b'0');

-- --------------------------------------------------------

--
-- Table structure for table `CollectionCards`
--

CREATE TABLE `CollectionCards` (
  `collectionCardsID` int(10) NOT NULL,
  `collectionID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  `quantity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CollectionCards`
--

INSERT INTO `CollectionCards` (`collectionCardsID`, `collectionID`, `cardID`, `quantity`) VALUES
(1, 1, 1, 3),
(2, 3, 2, 1),
(3, 2, 4, 2),
(4, 1, 3, 4),
(5, 4, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `Collections`
--

CREATE TABLE `Collections` (
  `collectionID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `collectionName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Collections`
--

INSERT INTO `Collections` (`collectionID`, `userID`, `collectionName`) VALUES
(1, 1, 'main'),
(2, 1, 'main1'),
(3, 2, 'main2'),
(4, 2, 'main3'),
(5, 1, 'main4');

-- --------------------------------------------------------

--
-- Table structure for table `DeckCards`
--

CREATE TABLE `DeckCards` (
  `deckCardsID` int(10) NOT NULL,
  `deckID` int(10) NOT NULL,
  `cardID` int(10) NOT NULL,
  `quantity` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DeckCards`
--

INSERT INTO `DeckCards` (`deckCardsID`, `deckID`, `cardID`, `quantity`) VALUES
(1, 1, 1, 1),
(2, 1, 2, 3),
(3, 1, 7, 12),
(4, 1, 8, 10),
(5, 1, 9, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Decks`
--

CREATE TABLE `Decks` (
  `deckID` int(10) NOT NULL,
  `userID` int(10) NOT NULL,
  `deckName` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `Decks`
--

INSERT INTO `Decks` (`deckID`, `userID`, `deckName`) VALUES
(1, 2, 'Caravan'),
(2, 1, 'Mill'),
(3, 2, 'cake'),
(4, 1, 'cake2'),
(5, 1, 'cake3');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Accounts`
--
ALTER TABLE `Accounts`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `userName` (`userName`),
  ADD UNIQUE KEY `userEmail` (`userEmail`);

--
-- Indexes for table `Cards`
--
ALTER TABLE `Cards`
  ADD PRIMARY KEY (`cardID`),
  ADD UNIQUE KEY `cardName` (`cardName`);

--
-- Indexes for table `CollectionCards`
--
ALTER TABLE `CollectionCards`
  ADD KEY `collectionCardsID` (`collectionCardsID`),
  ADD KEY `collectionID` (`collectionID`),
  ADD KEY `cardID` (`cardID`);

--
-- Indexes for table `Collections`
--
ALTER TABLE `Collections`
  ADD PRIMARY KEY (`collectionID`),
  ADD UNIQUE KEY `collectionName` (`collectionName`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `DeckCards`
--
ALTER TABLE `DeckCards`
  ADD KEY `deckCardsID` (`deckCardsID`),
  ADD KEY `deckID` (`deckID`),
  ADD KEY `cardID` (`cardID`);

--
-- Indexes for table `Decks`
--
ALTER TABLE `Decks`
  ADD PRIMARY KEY (`deckID`),
  ADD UNIQUE KEY `deckName` (`deckName`),
  ADD KEY `userID` (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Accounts`
--
ALTER TABLE `Accounts`
  MODIFY `userID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Cards`
--
ALTER TABLE `Cards`
  MODIFY `cardID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `CollectionCards`
--
ALTER TABLE `CollectionCards`
  MODIFY `collectionCardsID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Collections`
--
ALTER TABLE `Collections`
  MODIFY `collectionID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `DeckCards`
--
ALTER TABLE `DeckCards`
  MODIFY `deckCardsID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `Decks`
--
ALTER TABLE `Decks`
  MODIFY `deckID` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `CollectionCards`
--
ALTER TABLE `CollectionCards`
  ADD CONSTRAINT `CollectionCards_ibfk_1` FOREIGN KEY (`collectionID`) REFERENCES `Collections` (`collectionID`),
  ADD CONSTRAINT `CollectionCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`);

--
-- Constraints for table `Collections`
--
ALTER TABLE `Collections`
  ADD CONSTRAINT `Collections_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`);

--
-- Constraints for table `DeckCards`
--
ALTER TABLE `DeckCards`
  ADD CONSTRAINT `DeckCards_ibfk_1` FOREIGN KEY (`deckID`) REFERENCES `Decks` (`deckID`),
  ADD CONSTRAINT `DeckCards_ibfk_2` FOREIGN KEY (`cardID`) REFERENCES `Cards` (`cardID`);

--
-- Constraints for table `Decks`
--
ALTER TABLE `Decks`
  ADD CONSTRAINT `Decks_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Accounts` (`userID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
