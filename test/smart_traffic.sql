-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 22, 2025 at 02:32 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `smart_traffic`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `topic` varchar(50) NOT NULL,
  `message` varchar(50) NOT NULL,
  `received_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sign_type`
--

CREATE TABLE `sign_type` (
  `id_sign_type` int(11) NOT NULL,
  `name_type` varchar(50) NOT NULL,
  `is_danger` tinyint(1) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sign_type`
--

INSERT INTO `sign_type` (`id_sign_type`, `name_type`, `is_danger`, `created_at`) VALUES
(1, 'Speed Limit 30', 1, '2024-01-22 01:00:00'),
(2, 'Speed Limit 50', 0, '2024-01-22 02:00:00'),
(3, 'Speed Limit 60', 0, '2024-01-22 03:00:00'),
(4, 'Speed Limit 70', 0, '2024-01-22 04:00:00'),
(5, 'Speed Limit 80', 1, '2024-01-22 05:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `traffic_signs`
--

CREATE TABLE `traffic_signs` (
  `id_traffic_signs` int(11) NOT NULL,
  `id_sign_type` int(11) NOT NULL,
  `image` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `path` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `is_verify` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `traffic_signs`
--

INSERT INTO `traffic_signs` (`id_traffic_signs`, `id_sign_type`, `image`, `name`, `path`, `description`, `is_verify`, `id_user`, `created_at`) VALUES
(1, 1, 'hinh1.jpg', 'Speed Limit 30', 'image/hinh1.png', 'Giới hạn tốc độ 30km/h', 1, 1, '2024-01-22 06:00:00'),
(2, 2, 'hinh2.jpg', 'Speed Limit 50', 'image/hinh2.png', 'Giới hạn tốc độ 50km/h', 1, 2, '2024-01-22 07:00:00'),
(3, 3, 'hinh3.jpg', 'Speed Limit 60', 'image/hinh3.png', 'Giới hạn tốc độ 60km/h', 1, 3, '2024-01-22 08:00:00'),
(4, 4, 'hinh4.jpg', 'Speed Limit 70', 'image/hinh4.png', 'Giới hạn tốc độ 70km/h', 0, 4, '2024-01-22 09:00:00'),
(5, 5, 'hinh5.jpg', 'Speed Limit 80', 'image/hinh5.png', 'Giới hạn tốc độ 80km/h', 0, 5, '2024-01-22 10:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id_user` int(11) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `full_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `permissions` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id_user`, `first_name`, `full_name`, `email`, `password`, `permissions`) VALUES
(1, 'Lê', 'Lê Thị Anh Thơ', 'tho@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 1),
(2, 'Trần', 'Trần Ngọc Linh', 'linh@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 0),
(3, 'Mai', 'Mai Thu Nam', 'nam@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 0),
(4, 'Nguyễn', 'Nguyễn Thanh An', 'an@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 1),
(5, 'Vũ', 'Vũ Mai Hoa', 'hoa@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sign_type`
--
ALTER TABLE `sign_type`
  ADD PRIMARY KEY (`id_sign_type`);

--
-- Indexes for table `traffic_signs`
--
ALTER TABLE `traffic_signs`
  ADD PRIMARY KEY (`id_traffic_signs`),
  ADD KEY `fk_traffic_user` (`id_user`),
  ADD KEY `id_traffic_sign` (`id_sign_type`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sign_type`
--
ALTER TABLE `sign_type`
  MODIFY `id_sign_type` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `traffic_signs`
--
ALTER TABLE `traffic_signs`
  MODIFY `id_traffic_signs` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `traffic_signs`
--
ALTER TABLE `traffic_signs`
  ADD CONSTRAINT `fk_traffic_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`),
  ADD CONSTRAINT `id_traffic_sign` FOREIGN KEY (`id_sign_type`) REFERENCES `sign_type` (`id_sign_type`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
