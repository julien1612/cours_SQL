
------------------------------------------
--Création de base de données :

CREATE DATABASE `db_cours_ipme_2025`
DEFAULT CHARACTER SET 'utf8';

------------------------------------------
--Création de table :

CREATE TABLE `student`(
    id INT(9) NOT NULL,
    firstname VARCHAR(24) NOT NULL,
    lastname VARCHAR(64) NOT NULL,
    email VARCHAR(100) NOT NULL,
    birth_at DATE DEFAULT NULL
) 
ENGINE= 'InnoDB'
DEFAULT CHARACTER SET = 'utf8';

------------------------------------------
--Ajout d'une colonne d'une table :

ALTER TABLE student
ADD COLUMN height INT(3) DEFAULT NULL AFTER email;
 
 ------------------------------------------
--Modification d'une colonne d'une table :

ALTER TABLE student
MODIFY COLUMN birth_at DATE NOT NULL;
          
------------------------------------------		  
--Modification de la table pour ajouter une clé primaire :

ALTER TABLE student MODIFY COLUMN id INT(9) AUTO_INCREMENT NOT NULL PRIMARY KEY;

------------------------------------------
--Ajout d'une ligne dans la table :

INSERT INTO student (firstname, lastname, email, birth_at, gender) VALUES ('Toto', 'TOTO', 'toto.toto@toto.fr', NOW(), 'M');

INSERT INTO student VALUES (NULL, 'Toto', 'TOTO', 'toto.toto@toto.fr', 172, '2000-06-11', 'M');              

------------------------------------------
--Exemple d'update :

UPDATE student
SET birth_at = '1998-06-11',
    email = 'toto.toto@toto.toto'
WHERE id = 1;

------------------------------------------
--Suppression d'une ligne :

DELETE FROM student
WHERE id = 1;

------------------------------------------
--Exemple truncate :

TRUNCATE s
------------------------------------------
--Affichage de TOUTES les colonnes de la table "pokemon" ( *  => toutes les colonnes) :

SELECT * FROM `pokemon`;

------------------------------------------
--Renommer les entêtes des colonnes (le "AS" est facultatif, les simples quotes aussi, TANT QUE la chaine de caractères n'a pas de caractères spéciaux);

SELECT     id AS '#',
        name AS 'Nom Pokémon'

FROM `pokemon`;

------------------------------------------
--Utilisation de fonctions :

	SELECT COUNT(*) FROM pokemon;
	
------------------------------------------
--Utilisation du IF :

SELECT     name,
        IF(spe <= 20, 'TRES LENT', IF(spe <= 45, 'LENT', '')) AS 'Info. Vitesse'

FROM `pokemon`;

------------------------------------------
--WHERE :

SELECT     name,
        IF(spe <= 20, 'TRES LENT', IF(spe <= 45, 'LENT', '')) AS 'Info. Vitesse'

FROM `pokemon`

WHERE spe <= 45
AND (
    spe > 20
    OR
    spe <= 20
);

------------------------------------------
--WHERE avec LIKE :

SELECT     name

FROM `pokemon`

WHERE name LIKE 'arr%';

------------------------------------------
--Le poids maximum :

SELECT name, weight
FROM pokemon
ORDER BY weight DESC
LIMIT 1;

------------------------------------------
--Creation d'une nouvelle table :

CREATE TABLE school_class (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(10)
) ENGINE=INNODB, DEFAULT CHARACTER SET = 'utf8';

------------------------------------------
--Ajout de la foreign key DANS UNE TABLE EXISTANTE :

ALTER TABLE students
MODIFY COLUMN school_class_id INT DEFAULT NULL AFTER id;

ALTER TABLE students
ADD CONSTRAINT FOREIGN KEY(school_class_id) REFERENCES school_class(id);
		
------------------------------------------
--Exemple de JOIN :

SELECT     last_name,
        first_name,
        height,
        sex,
        name,
        year,
        school_class.refering_teacher,
        school_class.establishment

FROM students

SELECT     last_name,
        first_name,
        height,
        sex,
        name,
        year,
        school_class.refering_teacher,
        school_class.establishment

FROM students

JOIN school_class ON school_class.id = students.school_class_id;

-----------------------------------------
------------------------------------------
--correction TP Pokémon

------------------------------------------
--Afficher le nom des pokémons n’étant pas la forme par défaut (colonne is_default)


SELECT *
FROM pokemon
WHERE is_default = 0;


------------------------------------------
-- Afficher la moyenne de chaque statistique pour tous les pokemons (hp, atk, def, spa, spd et spe)



SELECT	AVG(hp) AS 'avg hp',
	AVG(atk) AS 'avg atk',
	AVG(def) AS 'avg def',
	AVG(spa) AS 'avg spa',
	AVG(spd) AS 'avg spd',
	AVG(spe) AS 'avg spe'
FROM pokemon;


------------------------------------------
--Afficher le pokémon le plus lourd


SELECT *
FROM pokemon
ORDER BY weight DESC
LIMIT 1;


------------------------------------------
--Afficher le pokémon le plus petit


SELECT *
FROM pokemon
ORDER BY height
LIMIT 1;


------------------------------------------
--Afficher le pokémon le plus lent


SELECT *
FROM pokemon
ORDER BY spe
LIMIT 1;


--Exemple avec une sous-requête :

--On récupère d'abord la vitesse minimum parmis tous les Pokémons :


SELECT MIN(spe) FROM pokemon;


--On l'intègre dans une requête récupérant les informations que l'on souhaite et réutilisant cette donnée :


SELECT *
FROM pokemon
WHERE spe = (SELECT MIN(spe) FROM pokemon)
ORDER BY name;


------------------------------------------
--Afficher les pokémons par atk, dont l’atk est supérieur à 150

SELECT name, atk
FROM pokemon
WHERE atk >= 150;


------------------------------------------
--Afficher la somme des statistiques avec le nom du pokémon lié


SELECT	name,
	(atk + def + spa + spd + spe + hp) AS 'stats'
		
FROM pokemon;


------------------------------------------
--Afficher les pokémons dont le « slug » est égal au « name_api »


SELECT *
FROM pokemon
WHERE slug = name_api;

------------------------------------------
--Afficher les pokémons dont l’atk est supérieure à la moyenne d’atk de tous les pokémons


-- Récupère la moyenne d'atk parmis tous les pokémons
SELECT AVG(atk) FROM pokemon; 

SELECT *
FROM pokemon
WHERE atk >= (SELECT AVG(atk) FROM pokemon);


------------------------------------------
--Afficher les pokémons dont le name contient le mot « Mew »

SELECT *
FROM pokemon
WHERE name LIKE '%Mew%';


------------------------------------------
--Afficher les pokémons dont le name est inférieure à 3 lettres


SELECT *
FROM pokemon
WHERE LENGTH(name) <= 3;


------------------------------------------
--Afficher le pokémon dont le name est le plus long


SELECT *
FROM pokemon
ORDER BY LENGTH(name) DESC
LIMIT 1;


------------------------------------------
--Afficher le pokémon ayant la somme de statistique (hp, atk, def, spa, spd, spe) la plus élevée


SELECT	name,
	(atk + def + spa + spd + spe + hp) AS stats
FROM pokemon
ORDER BY stats DESC
LIMIT 1;



--Afficher le pokémon le plus facile à monter de niveau (base_experience la plus basse)


SELECT	name,
	base_experience
FROM pokemon
ORDER BY base_experience
LIMIT 1;

------------------------------------------
--Afficher le pokémon le rapport « efficace » pour chaque pokémon

--Rapport efficace : (somme des statistiques / base_experience) * 100
--(arrondie à 2 après la virgule et avec un % à la fin)

SELECT	*,
  	CONCAT(ROUND((base_experience / (atk + def + spa + spd + spe + hp)) * 100, 2), '%')

FROM pokemon
ORDER BY ROUND((base_experience / (atk + def + spa + spd + spe + hp)) * 100, 2) DESC;

-----------------------------------
-----------------------------------
--ex_1 students 

1- SELECT last_name, first_name FROM students;

2-SELECT * FROM `students` WHERE sex = 'M' AND height < 160 OR sex = 'F' AND height > 160;

3- SELECT height FROM students ORDER by height LIMIT 1;

4- SELECT AVG(height) AS moyenne FROM `students` WHERE sex = 'M';

5- SELECT sex, COUNT(*) AS number_of_students FROM students GROUP by sex;

6- SELECT sex, COUNT(*) AS nombres FROM students WHERE ( sex = 'M' AND height > 160) OR ( sex = 'F' AND height < 160) GROUP BY sex;

7- SELECT DISTINCT height FROM students ORDER BY height;

8- SELECT * FROM students WHERE height BETWEEN '170' AND '190' ORDER by height;

9- SELECT * FROM students WHERE height IN ('160', '170', '180', '190');

-----------------------------------
-----------------------------------
--correction TP table 

-- Création de la base de données
CREATE DATABASE IF NOT EXISTS `db_autovente`;
USE db_autovente;

-- Création des tables SANS FOREIGN KEY
CREATE TABLE brands (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255)
) ENGINE = InnoDB, DEFAULT CHARACTER SET = 'utf8';

CREATE TABLE categories (
    id INT(11) NOT NULL AUTO_INCREMENT,
    name VARCHAR(255),
    PRIMARY KEY(id)
) ENGINE = InnoDB, DEFAULT CHARACTER SET = 'utf8';

CREATE TABLE sellers (
     id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
     last_name VARCHAR(255) NOT NULL,
     first_name VARCHAR(255) NOT NULL,
     email VARCHAR(127) NOT NULL,
     phone_number VARCHAR(10) DEFAULT NULL,
     location VARCHAR(255) DEFAULT NULL
) ENGINE = InnoDB, DEFAULT CHARACTER SET = 'utf8';

-- Création des tables AVEC FOREIGN KEY
CREATE TABLE models (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT(11) NOT NULL,
    category_id INT(11) NOT NULL,
    FOREIGN KEY(brand_id) REFERENCES brands(id),
    FOREIGN KEY(category_id) REFERENCES categories(id)
) ENGINE = InnoDB, DEFAULT CHARACTER SET = 'utf8';

CREATE TABLE listings (
    id INT(11) NOT NULL AUTO_INCREMENT PRIMARY KEY,
    creation_year DATE DEFAULT NULL,
    km INT(11) DEFAULT NULL,
    price INT(11) NOT NULL,
    description TEXT DEFAULT NULL,
    title VARCHAR(255) NOT NULL,
    publish_at DATETIME NOT NULL,
    model_id INT(11) NOT NULL,
    FOREIGN KEY(model_id) REFERENCES models(id),
    seller_id INT(11) NOT NULL,
    FOREIGN KEY(seller_id) REFERENCES sellers(id)
) ENGINE = InnoDB, DEFAULT CHARACTER SET = 'utf8';