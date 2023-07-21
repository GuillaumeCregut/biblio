-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : Dim 12 sep. 2021 à 10:38
-- Version du serveur :  8.0.21
-- Version de PHP : 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `biblio`
--

-- --------------------------------------------------------

--
-- Structure de la table `t_livre`
--

DROP TABLE IF EXISTS `t_livre`;
CREATE TABLE IF NOT EXISTS `t_livre` (
  `pk_livre` int NOT NULL AUTO_INCREMENT,
  `fk_auteur` int NOT NULL,
  `fk_etagere` int NOT NULL,
  `fk_editeur` int NOT NULL,
  `titre_livre` varchar(300) NOT NULL,
  `ref_livre` varchar(50) NOT NULL,
  PRIMARY KEY (`pk_livre`),
  KEY `c_livre_auteur` (`fk_auteur`),
  KEY `c_livre_etagere` (`fk_editeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_livre`
--
ALTER TABLE `t_livre`
  ADD CONSTRAINT `c_livre_auteur` FOREIGN KEY (`fk_auteur`) REFERENCES `t_auteur` (`pk_auteur`),
  ADD CONSTRAINT `c_livre_editeur` FOREIGN KEY (`fk_editeur`) REFERENCES `t_editeur` (`pk_editeur`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
