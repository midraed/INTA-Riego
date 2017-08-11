-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 11, 2017 at 06:47 AM
-- Server version: 10.1.21-MariaDB
-- PHP Version: 7.1.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `RIEGO`
--

-- --------------------------------------------------------

--
-- Table structure for table `GOTEO`
--

CREATE TABLE `GOTEO` (
  `N_PARCELA` int(11) NOT NULL,
  `PARCELA` text NOT NULL,
  `SUPERFICIE` decimal(5,2) NOT NULL COMMENT 'en Hectáreas',
  `CAUDAL_GOT` decimal(4,2) NOT NULL,
  `DIST_GOT` decimal(3,2) NOT NULL,
  `DIST_HILERAS` decimal(4,2) NOT NULL,
  `KC_default` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `KC`
--

CREATE TABLE `KC` (
  `ID` int(11) NOT NULL,
  `Nombre` text NOT NULL,
  `Enero` decimal(3,2) NOT NULL,
  `Febrero` decimal(3,2) NOT NULL,
  `Marzo` decimal(3,2) NOT NULL,
  `Abril` decimal(3,2) NOT NULL,
  `Mayo` decimal(3,2) NOT NULL,
  `Junio` decimal(3,2) NOT NULL,
  `Julio` decimal(3,2) NOT NULL,
  `Agosto` decimal(3,2) NOT NULL,
  `Setiembre` decimal(3,2) NOT NULL,
  `Octubre` decimal(3,2) NOT NULL,
  `Noviembre` decimal(3,2) NOT NULL,
  `Diciembre` decimal(3,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `RIEGOS`
--

CREATE TABLE `RIEGOS` (
  `ID` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `N_PARCELA` int(11) NOT NULL,
  `Horas de Riego` decimal(4,2) NOT NULL,
  `Caudal de Entrada` decimal(5,2) NOT NULL COMMENT 'l/s'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `SUPERFICIAL`
--

CREATE TABLE `SUPERFICIAL` (
  `N_PARCELA` int(11) NOT NULL,
  `PARCELA` text NOT NULL,
  `SUPERFICIE` decimal(5,2) NOT NULL COMMENT 'en Hectareas',
  `Tipo` text NOT NULL,
  `KC_default` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `GOTEO`
--
ALTER TABLE `GOTEO`
  ADD UNIQUE KEY `N_PARCELA` (`N_PARCELA`);

--
-- Indexes for table `KC`
--
ALTER TABLE `KC`
  ADD UNIQUE KEY `ID` (`ID`);

--
-- Indexes for table `RIEGOS`
--
ALTER TABLE `RIEGOS`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `SUPERFICIAL`
--
ALTER TABLE `SUPERFICIAL`
  ADD UNIQUE KEY `N_PARCELA` (`N_PARCELA`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
