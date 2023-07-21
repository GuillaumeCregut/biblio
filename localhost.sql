-- phpMyAdmin SQL Dump
-- version 4.6.6deb5
-- https://www.phpmyadmin.net/
--
-- Client :  localhost:3306
-- Généré le :  Sam 11 Septembre 2021 à 12:22
-- Version du serveur :  10.3.29-MariaDB-0+deb10u1
-- Version de PHP :  7.1.20-1+b2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `biblio`
--
CREATE DATABASE IF NOT EXISTS `biblio` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `biblio`;

-- --------------------------------------------------------

--
-- Structure de la table `t_auteur`
--

CREATE TABLE `t_auteur` (
  `pk_auteur` int(11) NOT NULL,
  `nom_auteur` varchar(100) NOT NULL,
  `prenom_auteur` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Structure de la table `t_editeur`
--

CREATE TABLE `t_editeur` (
  `pk_editeur` int(11) NOT NULL,
  `nom_editeur` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Structure de la table `t_etagere`
--

CREATE TABLE `t_etagere` (
  `pk_etagere` int(11) NOT NULL,
  `nom_etagere` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 ROW_FORMAT=COMPACT;

--
-- Contenu de la table `t_etagere`
--

INSERT INTO `t_etagere` (`pk_etagere`, `nom_etagere`) VALUES
(1, 'defaut');

-- --------------------------------------------------------

--
-- Structure de la table `t_livre`
--

CREATE TABLE `t_livre` (
  `pk_livre` int(11) NOT NULL,
  `fk_auteur` int(11) NOT NULL,
  `fk_etagere` int(11) NOT NULL,
  `fk_editeur` int(11) NOT NULL,
  `titre_livre` varchar(300) NOT NULL,
  `ref_livre` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Index pour les tables exportées
--

--
-- Index pour la table `t_auteur`
--
ALTER TABLE `t_auteur`
  ADD PRIMARY KEY (`pk_auteur`);

--
-- Index pour la table `t_editeur`
--
ALTER TABLE `t_editeur`
  ADD PRIMARY KEY (`pk_editeur`);

--
-- Index pour la table `t_etagere`
--
ALTER TABLE `t_etagere`
  ADD PRIMARY KEY (`pk_etagere`);

--
-- Index pour la table `t_livre`
--
ALTER TABLE `t_livre`
  ADD PRIMARY KEY (`pk_livre`),
  ADD KEY `c_livre_auteur` (`fk_auteur`),
  ADD KEY `c_livre_etagere` (`fk_editeur`);

--
-- AUTO_INCREMENT pour les tables exportées
--

--
-- AUTO_INCREMENT pour la table `t_auteur`
--
ALTER TABLE `t_auteur`
  MODIFY `pk_auteur` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `t_editeur`
--
ALTER TABLE `t_editeur`
  MODIFY `pk_editeur` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT pour la table `t_etagere`
--
ALTER TABLE `t_etagere`
  MODIFY `pk_etagere` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT pour la table `t_livre`
--
ALTER TABLE `t_livre`
  MODIFY `pk_livre` int(11) NOT NULL AUTO_INCREMENT;
--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `t_livre`
--
ALTER TABLE `t_livre`
  ADD CONSTRAINT `c_livre_auteur` FOREIGN KEY (`fk_auteur`) REFERENCES `t_auteur` (`pk_auteur`),
  ADD CONSTRAINT `c_livre_editeur` FOREIGN KEY (`fk_editeur`) REFERENCES `t_editeur` (`pk_editeur`),
  ADD CONSTRAINT `c_livre_etagere` FOREIGN KEY (`fk_editeur`) REFERENCES `t_etagere` (`pk_etagere`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
