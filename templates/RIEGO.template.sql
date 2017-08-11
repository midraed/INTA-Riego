-- phpMyAdmin SQL Dump
-- version 4.6.5.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Aug 11, 2017 at 06:52 AM
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

--
-- Dumping data for table `KC`
--

INSERT INTO `KC` (`ID`, `Nombre`, `Enero`, `Febrero`, `Marzo`, `Abril`, `Mayo`, `Junio`, `Julio`, `Agosto`, `Setiembre`, `Octubre`, `Noviembre`, `Diciembre`) VALUES
(1, 'Vid Vallone', '1.00', '1.00', '0.66', '0.50', '0.50', '0.00', '0.00', '0.00', '0.44', '0.57', '0.87', '0.76'),
(2, 'Vid Oriolani', '0.70', '0.67', '0.60', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.54', '0.65', '0.70'),
(3, 'Vid Allen 1998', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00'),
(4, 'Zapallo INTA La Consulta', '0.74', '0.84', '0.77', '0.59', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.21', '0.42'),
(5, 'Zapallo FAO 56', '0.83', '1.00', '0.80', '0.80', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.50', '0.67'),
(6, 'Cebolla semilla FAO 56', '0.80', '0.70', '0.70', '0.76', '0.82', '0.88', '0.93', '0.99', '1.05', '1.05', '1.05', '0.80'),
(7, 'Cerezos FAO 56', '0.70', '0.70', '0.70', '0.00', '0.00', '0.00', '0.00', '0.45', '0.70', '0.95', '0.95', '0.70'),
(8, 'Zapallo Lipinski', '0.85', '0.99', '0.64', '0.44', '0.00', '0.00', '0.00', '0.00', '0.00', '0.00', '0.21', '0.35');

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
