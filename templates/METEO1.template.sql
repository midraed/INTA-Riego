-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 11, 2017 at 06:49 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `METEO1`
--

-- --------------------------------------------------------

--
-- Table structure for table `Current`
--

CREATE TABLE `Current` (
  `FechaHora` datetime NOT NULL,
  `Temperatura` float NOT NULL,
  `hr` int(11) NOT NULL,
  `Humectacion` int(11) NOT NULL,
  `Lluvia` float NOT NULL,
  `Radiacion` int(11) NOT NULL,
  `Viento` float NOT NULL,
  `proc` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ROW_FORMAT=COMPACT;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Current`
--
ALTER TABLE `Current`
  ADD UNIQUE KEY `FechaHora` (`FechaHora`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
