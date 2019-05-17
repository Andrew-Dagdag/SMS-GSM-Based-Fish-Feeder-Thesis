-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 17, 2019 at 09:33 AM
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
-- Table structure for table `archives`
--

CREATE TABLE `archives` (
  `index` int(11) NOT NULL,
  `species` varchar(20) NOT NULL,
  `startingPop` int(5) NOT NULL,
  `endPop` int(5) NOT NULL,
  `survivalRate` float NOT NULL,
  `startDay` bigint(15) NOT NULL,
  `endDay` bigint(15) NOT NULL,
  `profit` float NOT NULL,
  `size` float NOT NULL,
  `weight` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `archives`
--

INSERT INTO `archives` (`index`, `species`, `startingPop`, `endPop`, `survivalRate`, `startDay`, `endDay`, `profit`, `size`, `weight`) VALUES
(12, 'Tilapia', 4000, 350, 11.43, 1557660617969, 1553410561473, 5235, 0, 0),
(13, 'Tilapia', 4000, 350, 11.43, 1557660617969, 1553410561473, 5235, 0, 0),
(14, 'Tilapia', 4000, 350, 11.43, 1557660617969, 1553410561473, 5235, 400, 550),
(15, 'Tilapia', 4000, 300, 13.33, 1557660617969, 1553410561473, 3750, 550, 900),
(16, 'koi', 500, 999, 0.5, 1557386456635, 1557129242054, -417.12, 123, 41);

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
(2, 'feedB', 300),
(3, 'corn', 40);

-- --------------------------------------------------------

--
-- Table structure for table `feedhistory`
--

CREATE TABLE `feedhistory` (
  `fid` int(5) NOT NULL,
  `feedamt` float NOT NULL,
  `timestamp` bigint(15) NOT NULL,
  `type` varchar(10) NOT NULL,
  `index` int(11) NOT NULL,
  `feedId` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedhistory`
--

INSERT INTO `feedhistory` (`fid`, `feedamt`, `timestamp`, `type`, `index`, `feedId`) VALUES
(3, 300, 1553410561473, 'Manual', 41, 1),
(3, 300, 1553410681481, 'Manual', 42, 1),
(4, 300, 1557128885266, 'Scheduled', 43, 1),
(13, 100, 1557129422056, 'Scheduled', 45, 1),
(14, 100, 1557129602058, 'Scheduled', 46, 3),
(15, 100, 1557130022061, 'Scheduled', 47, 1),
(4, 300, 1557384489123, 'Scheduled', 48, 1),
(5, 800, 1557386456632, 'Scheduled', 51, 2),
(4, 300, 1557654497945, 'Scheduled', 53, 1),
(2, 700, 1557657617960, 'Scheduled', 54, 2),
(4, 300, 1557658097960, 'Scheduled', 55, 1),
(5, 800, 1557660017971, 'Scheduled', 56, 2),
(3, 1000, 1557660617969, 'Scheduled', 57, 1),
(4, 300, 1557661697975, 'Scheduled', 58, 1),
(14, 100, 1557662417980, 'Scheduled', 59, 3),
(2, 700, 1557664817986, 'Scheduled', 60, 2),
(4, 300, 1557665297989, 'Scheduled', 61, 1),
(4, 300, 1557668897513, 'Scheduled', 62, 1),
(4, 300, 1558075687401, 'Scheduled', 63, 1),
(3, 1000, 1558075935136, 'Scheduled', 64, 1),
(3, 200, 1558076694008, 'Manual', 65, 1),
(3, 200, 1558076797179, 'Manual', 66, 1),
(3, 200, 1558076797181, 'Manual', 67, 1),
(3, 200, 1558076817172, 'Manual', 68, 1),
(3, 200, 1558076893537, 'Manual', 69, 1),
(3, 200, 1558076913538, 'Manual', 70, 1),
(3, 200, 1558076918538, 'Manual', 71, 1),
(3, 200, 1558077026281, 'Manual', 72, 1),
(3, 200, 1558077093182, 'Manual', 73, 1),
(3, 200, 1558077200784, 'Manual', 74, 1),
(3, 200, 1558077290714, 'Manual', 75, 1),
(3, 200, 1558077336099, 'Manual', 76, 1),
(3, 200, 1558077356070, 'Manual', 77, 1),
(3, 200, 1558077416449, 'Manual', 78, 1),
(3, 200, 1558077439928, 'Manual', 79, 1),
(3, 200, 1558077475091, 'Manual', 80, 1),
(3, 200, 1558077480088, 'Manual', 81, 1),
(3, 200, 1558077535097, 'Manual', 82, 1),
(3, 200, 1558077603158, 'Manual', 83, 1),
(5, 800, 1558077633143, 'Scheduled', 84, 2);

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `fid` int(5) NOT NULL,
  `size` float NOT NULL,
  `weight` float NOT NULL,
  `estpop` int(5) NOT NULL,
  `timestamp` bigint(15) NOT NULL,
  `index` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`fid`, `size`, `weight`, `estpop`, `timestamp`, `index`) VALUES
(3, 400, 550, 350, 1553409897511, 9),
(3, 550, 900, 300, 1557668845866, 10);

-- --------------------------------------------------------

--
-- Table structure for table `schedule`
--

CREATE TABLE `schedule` (
  `fid` int(5) NOT NULL,
  `sched` varchar(30) NOT NULL,
  `amount` int(9) NOT NULL,
  `type` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `schedule`
--

INSERT INTO `schedule` (`fid`, `sched`, `amount`, `type`) VALUES
(1, '00:50,4,20:00', 400, 'interval'),
(2, '08:40,2,23:00', 700, 'interval'),
(3, '14:52', 1000, 'schedule'),
(4, '07:48,1,23:00', 300, 'interval'),
(5, '07:20,4,23:00', 800, 'interval'),
(13, '15:57', 100, 'schedule'),
(14, '00:00,4,23:59', 100, 'interval'),
(15, '16:07', 100, 'schedule');

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
(1, 1, 'Dagdag, Unit 1', '+639486479300', 'Tilapia', 7800, 5000, 8000, 1),
(2, 1, 'Dagdag, Unit 2', '+639486479301', 'Koi', 3700, 2000, 4000, 2),
(3, 2, 'Articuno', '+639486479304', 'Tilapia', 6600, 4000, 5000, 1),
(4, 2, 'Zapdos', '+639486479303', 'Bangus', 9700, 3000, 6000, 1),
(5, 2, 'Moltres', '+639486479305', 'Lionfish', 15200, 800, 1100, 2),
(13, 4, 'koi', '+639123456777', 'koi', 400, 500, 500, 1),
(14, 4, 'bangus', '+639464073948', 'bangus', 400, 300, 400, 3),
(15, 5, 'fish1', '+639123456777', 'bangus', 400, 500, 500, 1);

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
(3, 'newname', '253c2e786c2414dcaec8dbf11df515b5075371454b93a5687d24d96ddbf3b939', '+639101010101'),
(4, 'newguy', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', '+639464073444'),
(5, 'new user', '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8', '+639123456778');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archives`
--
ALTER TABLE `archives`
  ADD PRIMARY KEY (`index`);

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
  ADD PRIMARY KEY (`index`),
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
-- AUTO_INCREMENT for table `archives`
--
ALTER TABLE `archives`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `feed`
--
ALTER TABLE `feed`
  MODIFY `feedId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `feedhistory`
--
ALTER TABLE `feedhistory`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=85;

--
-- AUTO_INCREMENT for table `sample`
--
ALTER TABLE `sample`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `fid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

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
