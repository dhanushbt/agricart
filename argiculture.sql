-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 13, 2021 at 10:19 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `agriculture`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `getItem` (IN `item_id` INT)  NO SQL
select c.id,c.name as c_name,c.ctype,ct.price,w.location,w.name as w_name,c.quantity from crop as c,crop_type as ct,warehouse as w where c.id=item_id and c.ctype=ct.name and c.warehouse_id = w.id$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `crop`
--

CREATE TABLE `crop` (
  `id` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `user_id` varchar(20) NOT NULL,
  `ctype` varchar(30) NOT NULL,
  `warehouse_id` int(11) NOT NULL,
  `quantity` decimal(10,0) NOT NULL,
  `sell_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crop`
--

INSERT INTO `crop` (`id`, `name`, `user_id`, `ctype`, `warehouse_id`, `quantity`, `sell_date`) VALUES
(12, 'Ashirvad', 'harsha', 'wheat', 2, '9', '2021-01-02 19:28:17'),
(13, 'Chikmangluru', 'harsha', 'rice', 1, '72', '2021-01-02 20:35:15'),
(14, 'Ashirvad', 'harsha', 'rice', 3, '10', '2021-01-03 14:56:13'),
(15, 'Ashirvad', 'harsha', 'ragi', 2, '32', '2021-01-03 18:04:58'),
(16, 'Ashirvad', 'harsha', 'rice', 2, '2', '2021-01-11 06:38:15');

-- --------------------------------------------------------

--
-- Table structure for table `crop_type`
--

CREATE TABLE `crop_type` (
  `name` varchar(30) NOT NULL,
  `price` decimal(10,0) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `crop_type`
--

INSERT INTO `crop_type` (`name`, `price`) VALUES
('ragi', '30'),
('rice', '48'),
('wheat', '100');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `seller_crop_id` int(11) NOT NULL,
  `buy_quantity` decimal(10,0) NOT NULL,
  `buy_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `seller_crop_id`, `buy_quantity`, `buy_date`) VALUES
(1, 'harsha', 12, '23', '2021-01-02 20:04:47'),
(2, 'harsha', 12, '14', '2021-01-02 20:33:14'),
(3, 'harsha', 13, '24', '2021-01-02 20:35:46'),
(4, 'harsha_c', 13, '50', '2021-01-02 20:38:47'),
(5, 'harsha_c', 13, '30', '2021-01-02 20:39:49'),
(6, 'harsha', 13, '1', '2021-01-03 09:57:34'),
(7, 'harsha', 13, '1', '2021-01-03 09:57:49'),
(8, 'harsha', 13, '2', '2021-01-03 09:57:59'),
(9, 'harsha', 13, '0', '2021-01-03 14:55:58'),
(2323, 'harsha', 13, '20', '2021-01-03 16:34:37'),
(2324, 'harsha', 12, '20', '2021-01-03 17:19:18'),
(2325, 'harsha', 12, '1', '2021-01-03 18:47:16'),
(2326, 'harsha', 12, '1', '2021-01-03 18:47:37'),
(2327, 'harsha', 12, '1', '2021-01-03 18:50:38'),
(2328, 'harsha', 12, '9', '2021-01-10 13:33:15'),
(2329, 'harsha', 12, '2', '2021-01-10 13:34:43');

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `decrease_quantity` BEFORE INSERT ON `orders` FOR EACH ROW update crop as c set c.quantity=c.quantity-NEW.buy_quantity where c.id = NEW.seller_crop_id
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` varchar(20) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `type` varchar(1) NOT NULL,
  `location` varchar(60) NOT NULL,
  `password` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `type`, `location`, `password`) VALUES
('aljd', 'd', 'd', 'n', 'd', 'sfa'),
('dg', 'fhg', 'bgc', 'n', 'bx', '2200'),
('harsha', 'd', 'd', 'n', 'd', '21'),
('harsha_c', 'harsha', 'chandrashekar', 'n', 'bangalore', 'root'),
('saa', 'd', 'd', 'n', '12', 'axcds'),
('test', 'd', 'd', 'n', '12', '54654');

-- --------------------------------------------------------

--
-- Table structure for table `warehouse`
--

CREATE TABLE `warehouse` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `location` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warehouse`
--

INSERT INTO `warehouse` (`id`, `name`, `location`) VALUES
(1, 'Central Warehousing Corporation\r\nMannagudda', 'manglore'),
(2, 'Central Warehousing Corporation Bangalore ', 'banglore'),
(3, 'Central Warehousing Corporation\r\nShikaripur', 'shimoga');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `crop`
--
ALTER TABLE `crop`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk1` (`user_id`),
  ADD KEY `fk2` (`ctype`),
  ADD KEY `fk3` (`warehouse_id`);

--
-- Indexes for table `crop_type`
--
ALTER TABLE `crop_type`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk4` (`user_id`),
  ADD KEY `fk5` (`seller_crop_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `warehouse`
--
ALTER TABLE `warehouse`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `crop`
--
ALTER TABLE `crop`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2330;

--
-- AUTO_INCREMENT for table `warehouse`
--
ALTER TABLE `warehouse`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `crop`
--
ALTER TABLE `crop`
  ADD CONSTRAINT `fk1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk2` FOREIGN KEY (`ctype`) REFERENCES `crop_type` (`name`),
  ADD CONSTRAINT `fk3` FOREIGN KEY (`warehouse_id`) REFERENCES `warehouse` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk4` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk5` FOREIGN KEY (`seller_crop_id`) REFERENCES `crop` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
