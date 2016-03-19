-- phpMyAdmin SQL Dump
-- version 4.5.4.1
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Mar 19, 2016 at 03:00 AM
-- Server version: 5.6.29
-- PHP Version: 5.5.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `richbastard`
--

-- --------------------------------------------------------

--
-- Table structure for table `blacklist`
--

CREATE TABLE `blacklist` (
  `blacklist_timestamp` bigint(20) NOT NULL,
  `blacklist_ip` varchar(15) NOT NULL,
  `blacklist_reason` varchar(64) NOT NULL,
  `blacklist_expire` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `card_type`
--

CREATE TABLE `card_type` (
  `card_type_id` int(11) NOT NULL,
  `card_type_desc` varchar(12) NOT NULL,
  `card_type_init_qty` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `card_type`
--

INSERT INTO `card_type` (`card_type_id`, `card_type_desc`, `card_type_init_qty`) VALUES
(0, 'Diamond', 9),
(1, 'Gold', 9),
(2, 'Oil', 9),
(3, 'Property', 9),
(4, 'Mining', 9),
(5, 'Shipping', 9),
(6, 'Banking', 9),
(7, 'Sport', 9),
(8, 'Rich Bastard', 1),
(9, 'Tax Man', 1);

-- --------------------------------------------------------

--
-- Table structure for table `game`
--

CREATE TABLE `game` (
  `game_id` int(11) NOT NULL,
  `game_desc` varchar(128) NOT NULL,
  `game_password` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `game_card`
--

CREATE TABLE `game_card` (
  `game_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `card_type` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `game_chat`
--

CREATE TABLE `game_chat` (
  `game_id` int(11) NOT NULL,
  `timestamp` bigint(20) NOT NULL,
  `player_id` int(11) NOT NULL,
  `message_type` enum('msg','me') NOT NULL,
  `message_recipient` int(11) NOT NULL,
  `message_content` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `game_player`
--

CREATE TABLE `game_player` (
  `game_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `game_player_card`
--

CREATE TABLE `game_player_card` (
  `game_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `game_trade`
--

CREATE TABLE `game_trade` (
  `game_id` int(11) NOT NULL,
  `trade_id` int(11) NOT NULL,
  `player_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `player`
--

CREATE TABLE `player` (
  `player_id` int(11) NOT NULL,
  `player_nickname` varchar(30) NOT NULL,
  `player_ip_addr` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `trade_card`
--

CREATE TABLE `trade_card` (
  `trade_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `blacklist`
--
ALTER TABLE `blacklist`
  ADD PRIMARY KEY (`blacklist_timestamp`);

--
-- Indexes for table `card_type`
--
ALTER TABLE `card_type`
  ADD PRIMARY KEY (`card_type_id`);

--
-- Indexes for table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`game_id`);

--
-- Indexes for table `game_card`
--
ALTER TABLE `game_card`
  ADD PRIMARY KEY (`game_id`,`card_id`);

--
-- Indexes for table `game_chat`
--
ALTER TABLE `game_chat`
  ADD PRIMARY KEY (`game_id`,`timestamp`);

--
-- Indexes for table `game_player`
--
ALTER TABLE `game_player`
  ADD PRIMARY KEY (`game_id`,`player_id`);

--
-- Indexes for table `game_player_card`
--
ALTER TABLE `game_player_card`
  ADD PRIMARY KEY (`game_id`,`player_id`,`card_id`);

--
-- Indexes for table `game_trade`
--
ALTER TABLE `game_trade`
  ADD PRIMARY KEY (`game_id`,`player_id`);

--
-- Indexes for table `player`
--
ALTER TABLE `player`
  ADD PRIMARY KEY (`player_id`);

--
-- Indexes for table `trade_card`
--
ALTER TABLE `trade_card`
  ADD PRIMARY KEY (`trade_id`,`card_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

