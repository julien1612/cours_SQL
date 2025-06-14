
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