--créate databases: 
-- C:\wamp64\bin\mysql\mysql5.7.31\bin\mysql -h localhost -u root
CREATE database sqliX;
USE sqliX;

-- Créate tables: 
-- au cas ou une table existe et pour etre sur d'eviter les doublons prendre l'habitude de drop;

DROP TABLE IF EXISTS province;
DROP TABLE IF EXISTS village; 
DROP TABLE IF EXISTS resserre;
DROP TABLE IF EXISTS categorie; 
DROP TABLE IF EXISTS trophee; 
DROP TABLE IF EXISTS habitant;
DROP TABLE IF EXISTS qualite;
DROP TABLE IF EXISTS absorber;
DROP TABLE IF EXISTS fabriquer;
DROP TABLE IF EXISTS potion;

CREATE TABLE province  (
  num_province INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nom_province VARCHAR(30) NOT NULL DEFAULT '',
  nom_gouverneur VARCHAR(30) NOT NULL DEFAULT ''
) ENGINE=InnoDB;

CREATE TABLE categorie  (
  code_cat CHAR (3) PRIMARY KEY NOT NULL,
  nom_categ VARCHAR(50),
  nb_points INT
) ENGINE=InnoDB ;

CREATE TABLE qualite  (
  num_qualite INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  lib_qualite VARCHAR(30)
) ENGINE=InnoDB;

CREATE TABLE village  (
  num_village INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nom_village VARCHAR(30) NOT NULL DEFAULT '',
  nb_huttes INT NOT NULL DEFAULT 0,
  num_province INT NOT NULL,
  CONSTRAINT FOREIGN KEY (num_province) REFERENCES province (num_province)
) ENGINE=InnoDB;


CREATE TABLE resserre (
  num_resserre INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  nom_resserre VARCHAR(30) NOT NULL DEFAULT '',
  superficie INT NOT NULL DEFAULT 0,
  num_village INT NOT NULL,
  CONSTRAINT FOREIGN KEY (num_village) REFERENCES village (num_village)
) ENGINE=InnoDB;

CREATE TABLE habitant (
  num_hab INT PRIMARY KEY  NOT NULL AUTO_INCREMENT,
  nom VARCHAR(30),
  age INT,
  num_qualite INT,
  num_village INT,
  CONSTRAINT FOREIGN KEY (num_qualite) REFERENCES qualite (num_qualite),
  CONSTRAINT FOREIGN KEY (num_village) REFERENCES village (num_village)
) ENGINE=InnoDB;

CREATE TABLE trophee  (
  num_trophee INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  date_prise DATETIME NOT NULL,
  code_cat CHAR(3),
  num_preneur INT,
  num_resserre INT,
  CONSTRAINT FOREIGN KEY (num_preneur) REFERENCES habitant (num_hab),
  CONSTRAINT FOREIGN KEY (num_resserre) REFERENCES resserre(num_resserre),
  CONSTRAINT FOREIGN KEY (code_cat) REFERENCES categorie (code_cat)
) ENGINE=InnoDB ;

CREATE TABLE potion (
  num_potion INT PRIMARY KEY AUTO_INCREMENT,
  lib_potion VARCHAR(40),
  formule VARCHAR(30),
  constituant_principal VARCHAR(30)
) ENGINE=InnoDB ;

CREATE TABLE absorber  (
  num_potion INT NOT NULL,
  date_a DATETIME,
  num_hab INT,
  quantite INT,
  PRIMARY KEY (date_a, num_potion, num_hab),
  CONSTRAINT FOREIGN KEY (num_potion) REFERENCES potion (num_potion),
  CONSTRAINT FOREIGN KEY (num_hab) REFERENCES habitant (num_hab)
) ENGINE=InnoDB;


CREATE TABLE fabriquer (
    num_potion INT NOT NULL ,
    num_hab INT NOT NULL,  
    PRIMARY KEY (num_potion , num_hab),
    CONSTRAINT FOREIGN KEY (num_hab) REFERENCES habitant(num_hab),
    CONSTRAINT FOREIGN KEY (num_potion) REFERENCES potion(num_potion)
)ENGINE=INNODB; 

ALTER TABLE fabriquer ADD INDEX (num_potion);

