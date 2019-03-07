-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 07, 2019 at 05:12 AM
-- Server version: 10.1.30-MariaDB
-- PHP Version: 7.1.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smsserver`
--

-- --------------------------------------------------------

--
-- Table structure for table `messagelog`
--

CREATE TABLE `messagelog` (
  `Id` int(11) NOT NULL,
  `SendTime` datetime DEFAULT NULL,
  `StatusCode` int(11) DEFAULT NULL,
  `MessageTo` varchar(80) DEFAULT NULL,
  `MessageText` text,
  `MessageId` varchar(80) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `messagereceive`
--

CREATE TABLE `messagereceive` (
  `Id` int(11) NOT NULL,
  `SendTime` datetime DEFAULT NULL,
  `MessageTo` varchar(80) DEFAULT NULL,
  `MessageFrom` varchar(80) DEFAULT NULL,
  `MessageText` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `messagesend`
--

CREATE TABLE `messagesend` (
  `Id` int(11) NOT NULL,
  `MessageFrom` varchar(80) DEFAULT NULL,
  `MessageTo` varchar(80) DEFAULT NULL,
  `MessageText` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messagelog`
--
ALTER TABLE `messagelog`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IDX_MessageId` (`MessageId`,`SendTime`);

--
-- Indexes for table `messagereceive`
--
ALTER TABLE `messagereceive`
  ADD PRIMARY KEY (`Id`),
  ADD KEY `IDX_MessageId` (`SendTime`);

--
-- Indexes for table `messagesend`
--
ALTER TABLE `messagesend`
  ADD PRIMARY KEY (`Id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messagelog`
--
ALTER TABLE `messagelog`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messagereceive`
--
ALTER TABLE `messagereceive`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messagesend`
--
ALTER TABLE `messagesend`
  MODIFY `Id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
