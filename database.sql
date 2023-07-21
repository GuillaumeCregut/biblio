DELIMITER $$
--
-- Procédures
--
CREATE PROCEDURE `p_add_auteur` (IN `nom` VARCHAR(100) CHARSET utf8, IN `prenom` VARCHAR(100) CHARSET utf8)  MODIFIES  DATA INSERT INTO t_auteur(nom_auteur,prenom_auteur)
VALUES(
    nom,
    prenom)$$

CREATE PROCEDURE `p_add_auteur_livre` (IN `livre` INT, IN `auteur` INT)  MODIFIES  DATA INSERT INTO t_auteur_livre(fk_livre,fk_auteur)
VALUES(livre,auteur)$$

CREATE PROCEDURE `p_add_book` (IN `editeur` INT, IN `etagere` INT, IN `titre` VARCHAR(300) CHARSET utf8, IN `ref` VARCHAR(50) CHARSET utf8, OUT `LID` INT)  MODIFIES  DATA BEGIN                                            
INSERT INTO t_livre(fk_editeur,fk_etagere,titre_livre,isbn_livre)
VALUES( editeur, etagere, titre, ref);
SET LID=LAST_INSERT_ID();
END$$

CREATE PROCEDURE `p_add_editeur` (IN `nom` VARCHAR(100))  MODIFIES  DATA INSERT INTO t_editeur(nom_editeur)
VALUES (nom)$$

CREATE PROCEDURE `p_add_etagere` (IN `etagere` VARCHAR(10) CHARSET utf8)  MODIFIES  DATA INSERT INTO t_etagere(nom_etagere)
VALUES(
    etagere)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_auteur`
--

CREATE TABLE IF NOT EXISTS `t_auteur` (
  `pk_auteur` int NOT NULL AUTO_INCREMENT,
  `nom_auteur` varchar(100) NOT NULL,
  `prenom_auteur` varchar(100) NOT NULL,
  PRIMARY KEY (`pk_auteur`),
  UNIQUE KEY `C_UniqueCouple` (`nom_auteur`,`prenom_auteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Structure de la table `t_auteur_livre`
--

CREATE TABLE IF NOT EXISTS `t_auteur_livre` (
  `pk_ligne` int NOT NULL AUTO_INCREMENT,
  `fk_auteur` int NOT NULL,
  `fk_livre` int NOT NULL,
  PRIMARY KEY (`pk_ligne`),
  KEY `c_table_livre` (`fk_livre`),
  KEY `c_table_auteur` (`fk_auteur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_editeur`
--

CREATE TABLE IF NOT EXISTS `t_editeur` (
  `pk_editeur` int NOT NULL AUTO_INCREMENT,
  `nom_editeur` varchar(100) NOT NULL,
  PRIMARY KEY (`pk_editeur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Structure de la table `t_etagere`
--

CREATE TABLE IF NOT EXISTS `t_etagere` (
  `pk_etagere` int NOT NULL AUTO_INCREMENT,
  `nom_etagere` varchar(10) NOT NULL,
  PRIMARY KEY (`pk_etagere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Structure de la table `t_livre`
--

CREATE TABLE IF NOT EXISTS `t_livre` (
  `pk_livre` int NOT NULL AUTO_INCREMENT,
  `fk_etagere` int NOT NULL,
  `fk_editeur` int NOT NULL,
  `titre_livre` varchar(300) NOT NULL,
  `isbn_livre` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`pk_livre`),
  KEY `c_livre_editeur` (`fk_editeur`),
  KEY `c_livre_etagere` (`fk_etagere`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_auteur_livre`
--
ALTER TABLE `t_auteur_livre`
  ADD CONSTRAINT `c_table_auteur` FOREIGN KEY (`fk_auteur`) REFERENCES `t_auteur` (`pk_auteur`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `c_table_livre` FOREIGN KEY (`fk_livre`) REFERENCES `t_livre` (`pk_livre`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Contraintes pour la table `t_livre`
--
ALTER TABLE `t_livre`
  ADD CONSTRAINT `c_livre_editeur` FOREIGN KEY (`fk_editeur`) REFERENCES `t_editeur` (`pk_editeur`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  ADD CONSTRAINT `c_livre_etagere` FOREIGN KEY (`fk_etagere`) REFERENCES `t_etagere` (`pk_etagere`) ON DELETE RESTRICT ON UPDATE RESTRICT;


