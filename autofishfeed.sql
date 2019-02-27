-- phpMyAdmin SQL Dump
-- version 4.7.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2019 at 08:22 PM
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
-- Table structure for table `feedhistory`
--

CREATE TABLE `feedhistory` (
  `fid` int(5) NOT NULL,
  `feedamt` float NOT NULL,
  `timestamp` time NOT NULL,
  `type` varchar(10) NOT NULL,
  `index` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedhistory`
--

INSERT INTO `feedhistory` (`fid`, `feedamt`, `timestamp`, `type`, `index`) VALUES
(3, 500, '12:41:26', 'Manual', 1),
(3, 500, '12:42:05', 'Manual', 2),
(3, 500, '12:44:07', 'Manual', 3),
(3, 500, '12:46:08', 'Manual', 4),
(3, 500, '12:53:19', 'Manual', 5);

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `fid` int(5) NOT NULL,
  `size` float NOT NULL,
  `weight` float NOT NULL,
  `timestamp` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`fid`, `size`, `weight`, `timestamp`) VALUES
(3, 450, 18, '2018-10-04 00:00:00'),
(3, 500, 20, '2018-10-11 00:00:00'),
(3, 520, 21, '2018-10-18 00:00:00');

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
(4, '04:10,4,23:00', 300),
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
  `feederload` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `units`
--

INSERT INTO `units` (`fid`, `uid`, `label`, `phoneno`, `species`, `feederload`) VALUES
(1, 1, 'Dagdag, Unit 1', '+639486479304', 'Tilapia', 9000),
(2, 1, 'Dagdag, Unit 2', '+639486479304', 'Koi', 10000),
(3, 2, 'Articuno', '+639486479304', 'Tilapia', 6500),
(4, 2, 'Zapdos', '+639486479304', 'Bangus', 15000),
(5, 2, 'Moltres', '+639486479304', 'Lionfish', 20000),
(6, 2, '4th legendary bird', '+639486479304', 'birdie', 9000);

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
(2, 'Donn Mathew Cruz', 'd74ff0ee8da3b9806b18c877dbf29bbde50b5bd8e4dad7a3a725000feb82e8f1', '+639301316858');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `feedhistory`
--
ALTER TABLE `feedhistory`
  ADD PRIMARY KEY (`index`),
  ADD KEY `fid` (`fid`);

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
  ADD KEY `uid` (`uid`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`uid`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `feedhistory`
--
ALTER TABLE `feedhistory`
  MODIFY `index` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `units`
--
ALTER TABLE `units`
  MODIFY `fid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `uid` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

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
  ADD CONSTRAINT `units_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `users` (`uid`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
