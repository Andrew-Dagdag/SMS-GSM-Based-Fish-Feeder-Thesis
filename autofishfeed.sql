-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 24, 2019 at 07:59 AM
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
  `timestamp` bigint(15) NOT NULL,
  `type` varchar(10) NOT NULL,
  `index` int(11) NOT NULL,
  `feedId` int(5) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedhistory`
--

INSERT INTO `feedhistory` (`fid`, `feedamt`, `timestamp`, `type`, `index`, `feedId`) VALUES
(3, 500, 20190228124126, 'Manual', 1, 1),
(3, 500, 20190228124205, 'Manual', 2, 1),
(3, 500, 20190228124407, 'Manual', 3, 1),
(4, 100, 20190228063048, 'Manual', 8, 1),
(4, 100, 20190228074848, 'Manual', 9, 1),
(4, 300, 20190307034858, 'Scheduled', 10, 1),
(2, 700, 20190307044058, 'Scheduled', 11, 2),
(4, 300, 20190307044858, 'Scheduled', 12, 1),
(1, 400, 20190307045058, 'Scheduled', 13, 1),
(2, 700, 20190307064036, 'Scheduled', 14, 2),
(4, 300, 20190307064835, 'Scheduled', 15, 1),
(5, 800, 20190307072021, 'Scheduled', 16, 2),
(3, 1000, 20190307083016, 'Scheduled', 18, 1),
(2, 700, 20190307084016, 'Scheduled', 19, 2),
(4, 300, 20190307084816, 'Scheduled', 20, 1),
(1, 400, 20190307085016, 'Scheduled', 21, 1),
(4, 300, 20190307094816, 'Scheduled', 22, 1),
(2, 700, 20190307104016, 'Scheduled', 23, 2),
(4, 300, 20190307104816, 'Scheduled', 24, 1),
(5, 800, 20190307112016, 'Scheduled', 25, 2),
(3, 1000, 20190307113016, 'Scheduled', 26, 1),
(3, 1000, 20190311023010, 'Scheduled', 27, 1),
(2, 700, 20190311044042, 'Scheduled', 28, 2),
(4, 300, 20190311044842, 'Scheduled', 29, 1),
(1, 400, 20190311045042, 'Scheduled', 30, 1),
(3, 300, 1553410561473, 'Manual', 41, 1),
(3, 300, 1553410681481, 'Manual', 42, 1);

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
(3, 450, 18, 0, 2147483647, 1),
(3, 500, 20, 0, 2147483647, 2),
(3, 520, 21, 0, 2147483647, 3),
(6, 15, 20, 0, 2147483647, 4),
(6, 16, 21, 0, 2147483647, 5),
(6, 16, 25, 0, 2147483647, 6),
(3, 5, 55, 0, 2147483647, 7),
(3, 5, 55, 0, 2147483647, 8),
(3, 3, 555, 0, 1553409897511, 9);

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
(2, 1, 'Dagdag, Unit 2', '+639486479304', 'Koi', 5100, 2000, 4000, 2),
(3, 2, 'Articuno', '+639486479304', 'Tilapia', 7200, 4000, 5000, 1),
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
-- AUTO_INCREMENT for table `feed`
--
ALTER TABLE `feed`
  MODIFY `feedId` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `feedhistory`
--
ALTER TABLE `feedhistory`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `sample`
--
ALTER TABLE `sample`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
