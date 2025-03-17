-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         11.4.2-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             12.6.0.6765
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para db_utp_parking
CREATE DATABASE IF NOT EXISTS `db_utp_parking` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;
USE `db_utp_parking`;

-- Volcando estructura para tabla db_utp_parking.campus
CREATE TABLE IF NOT EXISTS `campus` (
  `id_campus` int(11) NOT NULL,
  `name_campus` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_campus`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.locations
CREATE TABLE IF NOT EXISTS `locations` (
  `id_location` int(11) NOT NULL AUTO_INCREMENT,
  `id_campus` int(11) DEFAULT NULL,
  `name_location` varchar(50) DEFAULT NULL,
  `adress` varchar(60) DEFAULT NULL,
  `available_parking_spaces` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_location`) USING BTREE,
  KEY `fk_campus_location` (`id_campus`),
  CONSTRAINT `fk_campus_location` FOREIGN KEY (`id_campus`) REFERENCES `campus` (`id_campus`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.records
CREATE TABLE IF NOT EXISTS `records` (
  `id_record` int(11) NOT NULL,
  `id_vehicle` int(11) DEFAULT NULL,
  `id_location` int(11) DEFAULT NULL,
  `id_security` int(11) DEFAULT NULL,
  `entry_date` datetime DEFAULT NULL,
  `departure_date` datetime DEFAULT NULL,
  `observation` text DEFAULT NULL,
  PRIMARY KEY (`id_record`),
  KEY `fk_record_vehicle` (`id_vehicle`),
  KEY `fk_record_security` (`id_security`),
  KEY `fk_record_location` (`id_location`),
  CONSTRAINT `fk_record_location` FOREIGN KEY (`id_location`) REFERENCES `locations` (`id_location`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_security` FOREIGN KEY (`id_security`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_record_vehicle` FOREIGN KEY (`id_vehicle`) REFERENCES `vehicles` (`id_vehicle`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.requests
CREATE TABLE IF NOT EXISTS `requests` (
  `id_request` int(11) NOT NULL AUTO_INCREMENT,
  `id_applicant` int(11) DEFAULT NULL,
  `id_acceptor` int(11) DEFAULT NULL,
  `id_vehicle_type` int(11) DEFAULT NULL,
  `id_vehicle` int(11) DEFAULT NULL,
  `id_status` int(11) DEFAULT NULL,
  `number_plate` varchar(8) NOT NULL DEFAULT 'no-placa',
  `date_request` datetime DEFAULT NULL,
  `date_response` datetime DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `is_new` bit(1) DEFAULT NULL,
  `approved` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id_request`),
  KEY `fk_request_applicant` (`id_applicant`),
  KEY `fk_request_acceptor` (`id_acceptor`),
  KEY `fk_request_vehicle_type` (`id_vehicle_type`),
  KEY `fk_request_vehicle` (`id_vehicle`),
  KEY `fk_request_status` (`id_status`),
  CONSTRAINT `fk_request_acceptor` FOREIGN KEY (`id_acceptor`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_applicant` FOREIGN KEY (`id_applicant`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_vehicle` FOREIGN KEY (`id_vehicle`) REFERENCES `vehicles` (`id_vehicle`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_request_vehicle_type` FOREIGN KEY (`id_vehicle_type`) REFERENCES `vehicle_type` (`id_vehicle_type`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.role
CREATE TABLE IF NOT EXISTS `role` (
  `id_role` int(11) NOT NULL AUTO_INCREMENT,
  `name_role` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.status
CREATE TABLE IF NOT EXISTS `status` (
  `id_status` int(11) NOT NULL AUTO_INCREMENT,
  `name_status` varchar(50) NOT NULL DEFAULT 'no-ingresado',
  PRIMARY KEY (`id_status`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.users
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `id_campus` int(11) NOT NULL DEFAULT 0,
  `username` varchar(9) NOT NULL DEFAULT 'no-user',
  `password` varchar(255) NOT NULL DEFAULT 'no-registrado',
  `name` varchar(50) NOT NULL DEFAULT 'no-registrado',
  `last_name` varchar(50) NOT NULL DEFAULT 'no-registrado',
  `dni` varchar(8) NOT NULL DEFAULT 'no-dni',
  `institutional_email` varchar(21) NOT NULL DEFAULT 'no-registrado',
  `career` varchar(50) DEFAULT NULL,
  `actual_registered` bit(1) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `institutional_adress` (`institutional_email`) USING BTREE,
  KEY `fk_user_campus` (`id_campus`),
  CONSTRAINT `fk_user_campus` FOREIGN KEY (`id_campus`) REFERENCES `campus` (`id_campus`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.user_roles
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_role` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_role_user` (`id_role`),
  KEY `fk_user_role` (`id_user`),
  CONSTRAINT `fk_role_user` FOREIGN KEY (`id_role`) REFERENCES `role` (`id_role`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_role` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.vehicles
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id_vehicle` int(11) NOT NULL AUTO_INCREMENT,
  `id_vehicle_type` int(11) NOT NULL DEFAULT 0,
  `id_user` int(11) NOT NULL DEFAULT 0,
  `number_plate` varchar(8) NOT NULL DEFAULT 'no-placa',
  `active` bit(1) NOT NULL,
  PRIMARY KEY (`id_vehicle`),
  UNIQUE KEY `number_plate` (`number_plate`),
  KEY `fk_vehicle_type` (`id_vehicle_type`),
  KEY `fk_vehicle_user` (`id_user`),
  CONSTRAINT `fk_vehicle_type` FOREIGN KEY (`id_vehicle_type`) REFERENCES `vehicle_type` (`id_vehicle_type`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_vehicle_user` FOREIGN KEY (`id_user`) REFERENCES `users` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.vehicle_type
CREATE TABLE IF NOT EXISTS `vehicle_type` (
  `id_vehicle_type` int(11) NOT NULL AUTO_INCREMENT,
  `name_vehicle_type` varchar(50) NOT NULL DEFAULT 'no-ingresado',
  PRIMARY KEY (`id_vehicle_type`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

-- Volcando estructura para tabla db_utp_parking.workflow
CREATE TABLE IF NOT EXISTS `workflow` (
  `id_workflow` int(11) NOT NULL AUTO_INCREMENT,
  `id_request` int(11) DEFAULT NULL,
  `id_status` int(11) DEFAULT NULL,
  `date_create` datetime DEFAULT NULL,
  `date_update` datetime DEFAULT NULL,
  PRIMARY KEY (`id_workflow`),
  KEY `fk_workflow_request` (`id_request`),
  KEY `fk_workflow_status` (`id_status`),
  CONSTRAINT `fk_workflow_request` FOREIGN KEY (`id_request`) REFERENCES `requests` (`id_request`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_workflow_status` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- La exportación de datos fue deseleccionada.

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
