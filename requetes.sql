
CREATE DATABASE IF NOT EXISTS ossl_learning
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE ossl_learning;


DROP TABLE IF EXISTS `inscriptions`;
DROP TABLE IF EXISTS `cours`;
DROP TABLE IF EXISTS `utilisateurs`;


CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `type` enum('professeur','etudiant') NOT NULL,
  `identifiant` varchar(50) NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `mot_de_passe` varchar(255) NOT NULL,
  `departement_filiere` varchar(100) DEFAULT NULL,
  `date_inscription` datetime DEFAULT CURRENT_TIMESTAMP,
  `statut` enum('actif','inactif') DEFAULT 'actif',
  PRIMARY KEY (`id`),
  UNIQUE KEY `identifiant` (`identifiant`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `utilisateurs` (`id`, `type`, `identifiant`, `nom`, `prenom`, `email`, `mot_de_passe`, `departement_filiere`, `date_inscription`, `statut`) VALUES
(1, 'professeur', '2', 'berrada', 'kawtar', 'kaoutarber2015@gmail.com', '$2y$10$/D3LhI17DUVyJdwXutS6WOoBSwkA6OgEtXmMJajx2SjWCHa63TYw2', 'ddd', '2025-06-14 16:02:03', 'actif'),
(2, 'professeur', '3', 'lamauye', 'berrada', 'kaoutarber@gmail.com', '$2y$10$lwanB/JPvu4o2HlbZAruxeC8TBVzZ4BLJNnU8O.r0/3Se1N2DEDdO', 'lllll', '2025-06-14 16:08:37', 'actif'),
(3, 'etudiant', '5', 'lamauye', 'berrada', 'LAMAYE@gmail.com', '$2y$10$hhg1DbVmxOMjm5SE1pGGHOS1Hpmy7x2NEOelAnnmFTf8YvDEJ6Bx6', 'MATH', '2025-06-14 16:58:47', 'actif'),
(4, 'etudiant', '7', 'berrada', 'kawtar', 'lamyae@gmail.com', '$2y$10$iZwi2z9oRIA.YyRGKFwFBe7nthv8nyT1/zU2K0WCeYgoBJQF1mDXO', 'MATH', '2025-06-14 21:35:02', 'actif');


CREATE TABLE IF NOT EXISTS `cours` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(100) NOT NULL,
  `description` text,
  `id_professeur` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_professeur` (`id_professeur`),
  CONSTRAINT `fk_cours_professeur` FOREIGN KEY (`id_professeur`) REFERENCES `utilisateurs` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `cours` (`id`, `nom`, `description`, `id_professeur`) VALUES
(1, 'html', 'java lanageg', NULL),
(2, 'java', 'java lanageg', 1),
(3, 'html', 'html2', 1),
(4, 'matth', 'mathhh1', 1);


CREATE TABLE IF NOT EXISTS `inscriptions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_etudiant` int NOT NULL,
  `id_cours` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_inscriptions_etudiant` (`id_etudiant`),
  KEY `fk_inscriptions_cours` (`id_cours`),
  CONSTRAINT `fk_inscriptions_etudiant` FOREIGN KEY (`id_etudiant`) REFERENCES `utilisateurs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fk_inscriptions_cours` FOREIGN KEY (`id_cours`) REFERENCES `cours` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


INSERT INTO `inscriptions` (`id`, `id_etudiant`, `id_cours`) VALUES
(2, 3, 3),
(4, 3, 2),
(5, 4, 4);

COMMIT;





