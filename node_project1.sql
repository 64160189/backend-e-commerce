-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 24, 2023 at 11:16 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.0.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `node_project1`
--

-- --------------------------------------------------------

--
-- Table structure for table `oders`
--

CREATE TABLE `oders` (
  `id` bigint(20) NOT NULL,
  `cost` decimal(8,2) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `address` text NOT NULL,
  `phone` varchar(255) NOT NULL,
  `date` datetime NOT NULL,
  `products_ids` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oder_items`
--

CREATE TABLE `oder_items` (
  `id` bigint(20) NOT NULL,
  `oder_id` bigint(20) NOT NULL,
  `product_id` bigint(20) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `product_price` decimal(8,2) NOT NULL,
  `product_image` varchar(255) NOT NULL,
  `product_quantity` int(11) NOT NULL,
  `oder_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` bigint(20) NOT NULL,
  `oder_id` int(11) NOT NULL,
  `transaction_id` text NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` float(8,2) NOT NULL,
  `sale_price` float(8,2) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `image` text NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `sale_price`, `quantity`, `image`, `category`, `type`) VALUES
(1, 'Clean shirt', 'white clean shirt', 199.00, 99.00, 5, '1.jpg', 'shirt', 'shirt'),
(2, 'White shorts', 'white shorts', 299.00, 199.00, 10, '2.jpg', 'shorts', 'pants'),
(3, 'Grey jacket', 'Big jacket with grey color.', 499.00, 399.00, 10, '3.jpg', 'jacket', 'jacket'),
(4, 'Fluffy jacket', 'Fluffy jacket', 499.00, NULL, 10, '4.jpg', 'jacket', 'jacket'),
(5, 'Dot... set (jacket + skirt)', 'Jacket with skirt that have so many white dots in black color.', 799.00, 699.00, 12, '5.jpg', 'set', 'set');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `oders`
--
ALTER TABLE `oders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oder_items`
--
ALTER TABLE `oder_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `oders`
--
ALTER TABLE `oders`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oder_items`
--
ALTER TABLE `oder_items`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
