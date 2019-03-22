-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 22, 2019 at 10:23 PM
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
-- Database: `autofishfeed`
--

-- --------------------------------------------------------

--
-- Table structure for table `feed`
--

CREATE TABLE `feed` (
  `feedId` int(5) NOT NULL,
  `feedname` varchar(30) NOT NULL,
  `cost` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feed`
--

INSERT INTO `feed` (`feedId`, `feedname`, `cost`) VALUES
(1, 'feedA', 100),
(2, 'feedB', 300);

-- --------------------------------------------------------

--
-- Table structure for table `feedhistory`
--

CREATE TABLE `feedhistory` (
  `fid` int(5) NOT NULL,
  `feedamt` float NOT NULL,
  `timestamp` datetime NOT NULL,
  `type` varchar(10) NOT NULL,
  `index` int(11) NOT NULL,
  `feedId` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedhistory`
--

INSERT INTO `feedhistory` (`fid`, `feedamt`, `timestamp`, `type`, `index`, `feedId`) VALUES
(3, 500, '2019-02-28 12:41:26', 'Manual', 1, 1),
(3, 500, '2019-02-28 12:42:05', 'Manual', 2, 1),
(3, 500, '2019-02-28 12:44:07', 'Manual', 3, 1),
(4, 100, '2019-02-28 06:30:48', 'Manual', 8, 1),
(4, 100, '2019-02-28 07:48:48', 'Manual', 9, 1),
(4, 300, '2019-03-07 03:48:58', 'Scheduled', 10, 1),
(2, 700, '2019-03-07 04:40:58', 'Scheduled', 11, 2),
(4, 300, '2019-03-07 04:48:58', 'Scheduled', 12, 1),
(1, 400, '2019-03-07 04:50:58', 'Scheduled', 13, 1),
(2, 700, '2019-03-07 06:40:36', 'Scheduled', 14, 2),
(4, 300, '2019-03-07 06:48:35', 'Scheduled', 15, 1),
(5, 800, '2019-03-07 07:20:21', 'Scheduled', 16, 2),
(3, 1000, '2019-03-07 08:30:16', 'Scheduled', 18, 1),
(2, 700, '2019-03-07 08:40:16', 'Scheduled', 19, 2),
(4, 300, '2019-03-07 08:48:16', 'Scheduled', 20, 1),
(1, 400, '2019-03-07 08:50:16', 'Scheduled', 21, 1),
(4, 300, '2019-03-07 09:48:16', 'Scheduled', 22, 1),
(2, 700, '2019-03-07 10:40:16', 'Scheduled', 23, 2),
(4, 300, '2019-03-07 10:48:16', 'Scheduled', 24, 1),
(5, 800, '2019-03-07 11:20:16', 'Scheduled', 25, 2),
(3, 1000, '2019-03-07 11:30:16', 'Scheduled', 26, 1),
(3, 1000, '2019-03-11 02:30:10', 'Scheduled', 27, 1),
(2, 700, '2019-03-11 04:40:42', 'Scheduled', 28, 2),
(4, 300, '2019-03-11 04:48:42', 'Scheduled', 29, 1),
(1, 400, '2019-03-11 04:50:42', 'Scheduled', 30, 1),
(3, 1000, '2019-03-11 05:30:42', 'Scheduled', 31, 0),
(4, 300, '2019-03-11 05:48:30', 'Scheduled', 32, 0),
(3, 1000, '2019-03-21 05:30:13', 'Scheduled', 33, 0),
(2, 700, '2019-03-21 06:40:44', 'Scheduled', 34, 0),
(4, 300, '2019-03-21 06:48:44', 'Scheduled', 35, 0),
(5, 800, '2019-03-21 07:20:44', 'Scheduled', 36, 0),
(11, 100, '2019-03-21 08:00:21', 'Scheduled', 37, 0);

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `fid` int(5) NOT NULL,
  `size` float NOT NULL,
  `weight` float NOT NULL,
  `estpop` int(5) NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`fid`, `size`, `weight`, `estpop`, `timestamp`) VALUES
(3, 450, 18, 0, '2018-10-04 00:00:00'),
(3, 500, 20, 0, '2018-10-11 00:00:00'),
(3, 520, 21, 0, '2018-10-18 00:00:00'),
(6, 15, 20, 0, '2019-03-21 05:38:04'),
(6, 16, 21, 0, '2019-03-21 05:43:39'),
(6, 16, 25, 0, '2019-03-21 06:38:04');

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `fid` int(5) NOT NULL,
  `sched` varchar(30) NOT NULL,
  `amount` int(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`fid`, `sched`, `amount`) VALUES
(1, '00:50,4,20:00', 400),
(2, '08:40,2,23:00', 700),
(3, '10:30,3,23:00', 1000),
(4, '07:48,1,23:00', 300),
(5, '07:20,4,23:00', 800);

-- --------------------------------------------------------

--
-- Table structure for table `units`
--

CREATE TABLE `units` (
  `fid` int(5) NOT NULL,
  `uid` int(5) NOT NULL,
  `label` varchar(30) NOT NULL,
  `phoneno` varchar(13) NOT NULL,
  `species` varchar(20) NOT NULL,
  `feederload` float NOT NULL,
  `startingPop` int(5) NOT NULL,
  `capital` int(5) NOT NULL,
  `feedId` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`fid`, `uid`, `label`, `phoneno`, `species`, `feederload`, `startingPop`, `capital`, `feedId`) VALUES
(1, 1, 'Dagdag, Unit 1', '+639486479304', 'Tilapia', 7800, 5000, 8000, 1),
(2, 1, 'Dagdag, Unit 2', '+639486479304', 'Koi', 5800, 2000, 4000, 2),
(3, 2, 'Articuno', '+639486479304', 'Tilapia', 8800, 4000, 5000, 1),
(4, 2, 'Zapdos', '+639486479304', 'Bangus', 12100, 3000, 6000, 1),
(5, 2, 'Moltres', '+639486479304', 'Lionfish', 17600, 800, 1100, 2),
(6, 2, 'Borb', '+639486479304', 'Rock', 9000, 200, 600, 2),
(11, 3, 'label1', '+639464073444', 'memelord', 300, 1000, 1500, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `uid` int(5) NOT NULL,
  `name` varchar(30) NOT NULL,
  `password` varchar(64) NOT NULL,
  `phoneno` varchar(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`uid`, `name`, `password`, `phoneno`) VALUES
(1, 'Andrew Dagdag', '07123e1f482356c415f684407a3b8723e10b2cbbc0b8fcd6282c49d37c9c1abc', '+639773518918'),
(2, 'Donn Mathew Cruz', 'd74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1', '+639467605054'),
(3, 'newname', '253c2e786c2414dcaec8dbf11df515b5075371454b93a5687d24d96ddbf3b939', '+639101010101');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feed`
--
ALTER TABLE `feed`
  ADD PRIMARY KEY (`feedId`);

--
-- Indexes for table `feedhistory`
--
ALTER TABLE `feedhistory`
  ADD PRIMARY KEY (`index`),
  ADD KEY `fid` (`fid`),
  ADD KEY `feedId` (`feedId`);

--
-- Indexes for table `sample`
--
ALTER TABLE `sample`
  ADD KEY `fid` (`fid`);

--
-- Indexes for table `schedule`
--
ALTER TABLE `schedule`
  ADD UNIQUE KEY `fid_2` (`fid`),
  ADD KEY `fid` (`fid`);

--
-- Indexes for table `units`
--
ALTER TABLE `units`
  ADD PRIMARY KEY (`fid`),
  ADD KEY `uid` (`uid`),
  ADD KEY `feedId` (`feedId`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feed`
--
ALTER TABLE `feed`
  MODIFY `feedId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `feedhistory`
--
ALTER TABLE `feedhistory`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `fid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `feedhistory`
--
ALTER TABLE `feedhistory`
  ADD CONSTRAINT `feedhistory_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `units` (`fid`);

--
-- Constraints for table `sample`
--
ALTER TABLE `sample`
  ADD CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `units` (`fid`);

--
-- Constraints for table `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`fid`) REFERENCES `units` (`fid`);

--
-- Constraints for table `units`
--
ALTER TABLE `units`
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`),
  ADD CONSTRAINT `units_ibfk_2` FOREIGN KEY (`feedId`) REFERENCES `feed` (`feedId`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
