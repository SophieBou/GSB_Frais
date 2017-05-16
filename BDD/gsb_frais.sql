-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 27 Février 2017 à 12:12
-- Version du serveur :  5.7.9
-- Version de PHP :  5.6.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données :  `gsb_frais`
--

DELIMITER $$
--
-- Procédures
--
DROP PROCEDURE IF EXISTS `Cloturer`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Cloturer` ()  BEGIN 
update ficheFrais set idEtat = 'CL', dateModif = NOW()
where  fichefrais.mois < CONCAT(YEAR(NOW()),MONTH(NOW())) and idEtat = 'CR';
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `comptable`
--

DROP TABLE IF EXISTS `comptable`;
CREATE TABLE IF NOT EXISTS `comptable` (
  `id` char(4) COLLATE utf8_bin NOT NULL,
  `nom` char(30) COLLATE utf8_bin NOT NULL,
  `prenom` char(20) COLLATE utf8_bin NOT NULL,
  `login` char(20) COLLATE utf8_bin NOT NULL,
  `mdp` char(60) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `comptable`
--

INSERT INTO `comptable` (`id`, `nom`, `prenom`, `login`, `mdp`) VALUES
('a1', 'moi', '', 'moi', '$2y$10$m29maDjx/ztmLrdMvdKx1.vu/I058UI3bn3U65eFu65jZN95vE4eu');

-- --------------------------------------------------------

--
-- Structure de la table `etat`
--

DROP TABLE IF EXISTS `etat`;
CREATE TABLE IF NOT EXISTS `etat` (
  `id` char(2) COLLATE utf8_bin NOT NULL,
  `libelle` varchar(30) COLLATE utf8_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `etat`
--

INSERT INTO `etat` (`id`, `libelle`) VALUES
('CL', 'Saisie clôturée'),
('CR', 'Fiche créée, saisie en cours'),
('MP', 'Mise en paiement'),
('RB', 'Remboursée'),
('VA', 'Validée');

-- --------------------------------------------------------

--
-- Structure de la table `fichefrais`
--

DROP TABLE IF EXISTS `fichefrais`;
CREATE TABLE IF NOT EXISTS `fichefrais` (
  `idVisiteur` char(4) COLLATE utf8_bin NOT NULL,
  `mois` char(6) COLLATE utf8_bin NOT NULL,
  `nbJustificatifs` int(11) DEFAULT NULL,
  `montantValide` decimal(10,2) DEFAULT NULL,
  `dateModif` date DEFAULT NULL,
  `idEtat` char(2) COLLATE utf8_bin DEFAULT 'CR',
  PRIMARY KEY (`idVisiteur`,`mois`),
  KEY `idEtat` (`idEtat`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `fichefrais`
--

INSERT INTO `fichefrais` (`idVisiteur`, `mois`, `nbJustificatifs`, `montantValide`, `dateModif`, `idEtat`) VALUES
('a131', '201611', 0, '234.96', '2016-12-01', 'CL'),
('a131', '201612', 0, '0.00', '2016-12-01', 'CR'),
('a17', '201611', 0, '710.00', '2016-12-01', 'CL'),
('a17', '201612', 0, '0.00', '2016-12-01', 'CR'),
('a55', '201612', 0, '0.00', '2016-12-01', 'CR');

-- --------------------------------------------------------

--
-- Structure de la table `fraisforfait`
--

DROP TABLE IF EXISTS `fraisforfait`;
CREATE TABLE IF NOT EXISTS `fraisforfait` (
  `id` char(3) COLLATE utf8_bin NOT NULL,
  `libelle` char(20) COLLATE utf8_bin DEFAULT NULL,
  `montant` decimal(5,2) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `fraisforfait`
--

INSERT INTO `fraisforfait` (`id`, `libelle`, `montant`) VALUES
('ETP', 'Forfait Etape', '110.00'),
('KM', 'Frais Kilométrique', '0.62'),
('NUI', 'Nuitée Hôtel', '80.00'),
('REP', 'Repas Restaurant', '25.00');

-- --------------------------------------------------------

--
-- Structure de la table `lignefraisforfait`
--

DROP TABLE IF EXISTS `lignefraisforfait`;
CREATE TABLE IF NOT EXISTS `lignefraisforfait` (
  `idVisiteur` char(4) COLLATE utf8_bin NOT NULL,
  `mois` char(6) COLLATE utf8_bin NOT NULL,
  `idFraisForfait` char(3) COLLATE utf8_bin NOT NULL,
  `quantite` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVisiteur`,`mois`,`idFraisForfait`),
  KEY `idFraisForfait` (`idFraisForfait`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `lignefraisforfait`
--

INSERT INTO `lignefraisforfait` (`idVisiteur`, `mois`, `idFraisForfait`, `quantite`) VALUES
('a131', '201611', 'ETP', 2),
('a131', '201611', 'KM', 8),
('a131', '201611', 'NUI', 0),
('a131', '201611', 'REP', 0),
('a131', '201612', 'ETP', 0),
('a131', '201612', 'KM', 0),
('a131', '201612', 'NUI', 0),
('a131', '201612', 'REP', 0),
('a17', '201611', 'ETP', 0),
('a17', '201611', 'KM', 0),
('a17', '201611', 'NUI', 7),
('a17', '201611', 'REP', 6),
('a17', '201612', 'ETP', 0),
('a17', '201612', 'KM', 0),
('a17', '201612', 'NUI', 0),
('a17', '201612', 'REP', 0),
('a55', '201612', 'ETP', 0),
('a55', '201612', 'KM', 0),
('a55', '201612', 'NUI', 0),
('a55', '201612', 'REP', 0);

-- --------------------------------------------------------

--
-- Structure de la table `lignefraishorsforfait`
--

DROP TABLE IF EXISTS `lignefraishorsforfait`;
CREATE TABLE IF NOT EXISTS `lignefraishorsforfait` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `idVisiteur` char(4) COLLATE utf8_bin NOT NULL,
  `mois` char(6) COLLATE utf8_bin NOT NULL,
  `libelle` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `date` date DEFAULT NULL,
  `montant` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idVisiteur` (`idVisiteur`,`mois`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `lignefraishorsforfait`
--

INSERT INTO `lignefraishorsforfait` (`id`, `idVisiteur`, `mois`, `libelle`, `date`, `montant`) VALUES
(1, 'a131', '201612', 'REFUSE gfffll', '2016-11-24', '45.00'),
(3, 'a131', '201611', 'S2', '2016-11-25', '5.00'),
(4, 'a131', '201611', 'EEE', '2016-11-25', '5.00'),
(5, 'a131', '201612', 'test', '2016-11-30', '45.00'),
(7, 'a17', '201612', 'hhh', '2016-11-01', '89.00'),
(8, 'a17', '201612', 'ff', '2015-12-01', '88.00');

-- --------------------------------------------------------

--
-- Structure de la table `visiteur`
--

DROP TABLE IF EXISTS `visiteur`;
CREATE TABLE IF NOT EXISTS `visiteur` (
  `id` char(4) COLLATE utf8_bin NOT NULL,
  `nom` char(30) COLLATE utf8_bin DEFAULT NULL,
  `prenom` char(30) COLLATE utf8_bin DEFAULT NULL,
  `login` char(20) COLLATE utf8_bin DEFAULT NULL,
  `mdp` varchar(255) COLLATE utf8_bin DEFAULT NULL,
  `adresse` char(30) COLLATE utf8_bin DEFAULT NULL,
  `cp` char(5) COLLATE utf8_bin DEFAULT NULL,
  `ville` char(30) COLLATE utf8_bin DEFAULT NULL,
  `dateEmbauche` date DEFAULT NULL,
  `IBAN` varchar(50) COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

--
-- Contenu de la table `visiteur`
--

INSERT INTO `visiteur` (`id`, `nom`, `prenom`, `login`, `mdp`, `adresse`, `cp`, `ville`, `dateEmbauche`, `IBAN`) VALUES
('a131', 'Villechalane', 'Louis', 'lvillachane', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '8 rue des Charmes', '46000', 'Cahors', '2005-12-21', 'FR1548545884556889'),
('a17', 'Andre', 'David', 'dandre', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '1 rue Petit', '46200', 'Lalbenque', '1998-11-23', 'FR154854588455688'),
('a55', 'Bedos', 'Christian', 'cbedos', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '1 rue Peranud', '46250', 'Montcuq', '1995-01-12', 'FR154854588455688'),
('a93', 'Tusseau', 'Louis', 'ltusseau', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '22 rue des Ternes', '46123', 'Gramat', '2000-05-01', 'FR154854588455688'),
('b13', 'Bentot', 'Pascal', 'pbentot', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '11 allée des Cerises', '46512', 'Bessines', '1992-07-09', 'FR45811515646546489'),
('b16', 'Bioret', 'Luc', 'lbioret', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '1 Avenue gambetta', '46000', 'Cahors', '1998-05-11', 'FR4578945615489789'),
('b19', 'Bunisset', 'Francis', 'fbunisset', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '10 rue des Perles', '93100', 'Montreuil', '1987-10-21', 'FR54894984561465456456'),
('b25', 'Bunisset', 'Denise', 'dbunisset', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '23 rue Manin', '75019', 'paris', '2010-12-05', 'FR56489713123156789'),
('b28', 'Cacheux', 'Bernard', 'bcacheux', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '114 rue Blanche', '75017', 'Paris', '2009-11-12', 'FR654787989412312347897'),
('b34', 'Cadic', 'Eric', 'ecadic', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '123 avenue de la République', '75011', 'Paris', '2008-09-23', 'FR1547787489465456456'),
('b4', 'Charoze', 'Catherine', 'ccharoze', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '100 rue Petit', '75019', 'Paris', '2005-11-12', 'FR78782656495948925265'),
('b50', 'Clepkens', 'Christophe', 'cclepkens', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '12 allée des Anges', '93230', 'Romainville', '2003-08-11', 'FR567897642514564564'),
('b59', 'Cottin', 'Vincenne', 'vcottin', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '36 rue Des Roches', '93100', 'Monteuil', '2001-11-18', 'FR8787889456142312132123156'),
('c14', 'Daburon', 'François', 'fdaburon', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '13 rue de Chanzy', '94000', 'Créteil', '2002-02-11', 'FR8798456465256215666'),
('c3', 'De', 'Philippe', 'pde', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '13 rue Barthes', '94000', 'Créteil', '2010-12-14', 'FR57876546545642132'),
('c54', 'Debelle', 'Michel', 'mdebelle', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '181 avenue Barbusse', '93210', 'Rosny', '2006-11-23', 'FR78787989829289839564156'),
('d13', 'Debelle', 'Jeanne', 'jdebelle', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '134 allée des Joncs', '44000', 'Nantes', '2000-05-11', 'FR7789665442258978'),
('d51', 'Debroise', 'Michel', 'mdebroise', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '2 Bld Jourdain', '44000', 'Nantes', '2001-04-17', 'FR788959564514515612152456'),
('e22', 'Desmarquest', 'Nathalie', 'ndesmarquest', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '14 Place d Arc', '45000', 'Orléans', '2005-11-12', 'FR5596655454211215454545878'),
('e24', 'Desnost', 'Pierre', 'pdesnost', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '16 avenue des Cèdres', '23200', 'Guéret', '2001-02-05', 'FR78798925156156165'),
('e39', 'Dudouit', 'Frédéric', 'fdudouit', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '18 rue de l église', '23120', 'GrandBourg', '2000-08-01', 'FR7889865652321549498498'),
('e49', 'Duncombe', 'Claude', 'cduncombe', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '19 rue de la tour', '23100', 'La souteraine', '1987-10-10', 'FR798958958415151'),
('e5', 'Enault-Pascreau', 'Céline', 'cenault', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '25 place de la gare', '23200', 'Gueret', '1995-09-01', 'FR878451211215654656'),
('e52', 'Eynde', 'Valérie', 'veynde', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '3 Grand Place', '13015', 'Marseille', '1999-11-01', 'FR458478562123231231246546'),
('f21', 'Finck', 'Jacques', 'jfinck', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '10 avenue du Prado', '13002', 'Marseille', '2001-11-10', 'FR78798989564231231964849'),
('f39', 'Frémont', 'Fernande', 'ffremont', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '4 route de la mer', '13012', 'Allauh', '1998-10-01', 'FR7878645461212'),
('f4', 'Gest', 'Alain', 'agest', '$2y$10$i8e8FLCWXVyePHmFaqPu/.vKd4nyO6sqyRWZFBZnjzmSEvoQRO4EO', '30 avenue de la mer', '13025', 'Berre', '1985-11-01', '');

--
-- Contraintes pour les tables exportées
--

--
-- Contraintes pour la table `fichefrais`
--
ALTER TABLE `fichefrais`
  ADD CONSTRAINT `fichefrais_ibfk_1` FOREIGN KEY (`idEtat`) REFERENCES `etat` (`id`),
  ADD CONSTRAINT `fichefrais_ibfk_2` FOREIGN KEY (`idVisiteur`) REFERENCES `visiteur` (`id`);

--
-- Contraintes pour la table `lignefraisforfait`
--
ALTER TABLE `lignefraisforfait`
  ADD CONSTRAINT `lignefraisforfait_ibfk_1` FOREIGN KEY (`idVisiteur`,`mois`) REFERENCES `fichefrais` (`idVisiteur`, `mois`),
  ADD CONSTRAINT `lignefraisforfait_ibfk_2` FOREIGN KEY (`idFraisForfait`) REFERENCES `fraisforfait` (`id`);

--
-- Contraintes pour la table `lignefraishorsforfait`
--
ALTER TABLE `lignefraishorsforfait`
  ADD CONSTRAINT `lignefraishorsforfait_ibfk_1` FOREIGN KEY (`idVisiteur`,`mois`) REFERENCES `fichefrais` (`idVisiteur`, `mois`);

DELIMITER $$
--
-- Événements
--
DROP EVENT `clotureFiche`$$
CREATE DEFINER=`root`@`localhost` EVENT `clotureFiche` ON SCHEDULE EVERY 1 MONTH STARTS '2016-12-10 00:00:00' ON COMPLETION NOT PRESERVE ENABLE DO CALL Cloture()$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
