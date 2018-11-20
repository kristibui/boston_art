-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema bosart
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `bosart` ;

-- -----------------------------------------------------
-- Schema bosart
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bosart` DEFAULT CHARACTER SET utf8 ;
USE `bosart` ;

-- -----------------------------------------------------
-- Table `bosart`.`location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`location` ;

CREATE TABLE IF NOT EXISTS `bosart`.`location` (
  `location_id` INT NOT NULL AUTO_INCREMENT,
  `neighborhood` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`size` ;

CREATE TABLE IF NOT EXISTS `bosart`.`size` (
  `size_id` INT NOT NULL AUTO_INCREMENT,
  `size` ENUM('small', 'medium', 'large', 'extra large') NOT NULL,
  PRIMARY KEY (`size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art` (
  `public_art_id` INT NOT NULL AUTO_INCREMENT,
  `existence` TINYINT NOT NULL,
  `time` DATETIME NULL,
  `description` VARCHAR(300) NULL,
  `location_id` INT NOT NULL,
  `size_id` INT NOT NULL,
  `title` VARCHAR(50) NULL,
  PRIMARY KEY (`public_art_id`),
  INDEX `fk_public_art_location_idx` (`location_id` ASC),
  INDEX `fk_public_art_size1_idx` (`size_id` ASC),
  CONSTRAINT `fk_public_art_location`
    FOREIGN KEY (`location_id`)
    REFERENCES `bosart`.`location` (`location_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_size1`
    FOREIGN KEY (`size_id`)
    REFERENCES `bosart`.`size` (`size_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`genre` ;

CREATE TABLE IF NOT EXISTS `bosart`.`genre` (
  `genre_id` INT NOT NULL AUTO_INCREMENT,
  `medium` VARCHAR(30) NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`artist` ;

CREATE TABLE IF NOT EXISTS `bosart`.`artist` (
  `artist_id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(30) NULL,
  `lastname` VARCHAR(30) NULL,
  `biography` VARCHAR(300) NULL,
  `dob` DATE NULL,
  `link` VARCHAR(100) NULL,
  PRIMARY KEY (`artist_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art_has_artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art_has_artist` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art_has_artist` (
  `public_art_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`public_art_id`, `artist_id`),
  INDEX `fk_public_art_has_artist_artist1_idx` (`artist_id` ASC),
  INDEX `fk_public_art_has_artist_public_art1_idx` (`public_art_id` ASC),
  CONSTRAINT `fk_public_art_has_artist_public_art1`
    FOREIGN KEY (`public_art_id`)
    REFERENCES `bosart`.`public_art` (`public_art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_has_artist_artist1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `bosart`.`artist` (`artist_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art_has_genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art_has_genre` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art_has_genre` (
  `public_art_id` INT NOT NULL,
  `genre_id` INT NOT NULL,
  PRIMARY KEY (`public_art_id`, `genre_id`),
  INDEX `fk_public_art_has_genre_genre1_idx` (`genre_id` ASC),
  INDEX `fk_public_art_has_genre_public_art1_idx` (`public_art_id` ASC),
  CONSTRAINT `fk_public_art_has_genre_public_art1`
    FOREIGN KEY (`public_art_id`)
    REFERENCES `bosart`.`public_art` (`public_art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_public_art_has_genre_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `bosart`.`genre` (`genre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- iniatialize all the data

insert into artist(firstname, lastname) values 
('Augustus', 'Saint-Gaudens'),
('Stanley', 'Saitowitz'), 
('Nancy', 'Schön'), 
('Louis D. Brown Peace Institute', null), 
('Lilli Ann Killen', 'Rosenberg'),
('Araldo', 'Cossutta'), 
('Corita',  'Kent'),
('Arthur', 'Gagner'),
('Susumu', 'Shingu'),
('Solomon', 'Willard'),
('Arrigo', 'Minerbi'),
('Matt', 'Hincman'),
('Lego Master Model Builders', null),
('Mayor\'s Mural Crew', null),
('Rafael Rivera', 'Garcia'),
('Richard "Deme5"', 'Gomez'), 
('Thomas "Kwest"', 'Burns'),
('George', 'Rhoads'),
('Louis Paul Jonas Studios', null),
('Bostonian Society', null),
('Paul', 'Matisse'),
('Boston Women’s Heritage Trail', null),
('Mayor\'s Mural Crew', null),
('Kim', 'Giordano'),
('Nicholas', 'Shaplyko'),
('Ekaterina', 'Sorokina'),
('El Mac', null),
('Liz', 'LaManche');

insert into genre(medium) values 
('Memorial'),
('Sculpture'),
('Graffiti'),
('Statue'),
('Mural'),
('Vehicle'),
('Historic Site'),
('Sign'),
('Bench'),
('Kinetic Art'),
('Plaque');

insert into size(size) values
('small'),
('medium'),
('large'),
('extra large');

insert into location(neighborhood, address) values
('Beacon Hill', 'On Boston Common, along Beacon Street at Park Street, across from the State House'),
('South Boston', 'On Congress Street between Hanover and North streets, Boston'),
('Back Bay', 'At Boston Public Garden, near Beacon and Charles streets'),
('Cambridge', 'Modica Way, next to 567 Massachuesetts Ave., Central Square, Cambridge'),
('N/A', 'Various locations around Boston'),
('Saugus', 'Route 1, Saugus'), 
('South End', 'At Villa Victoria, Aguadilla Street, off Tremont Street, Boston'),
('Back Bay', 'Boston Public Garden pond'),
('Boston', 'Boston Common to Bunker Hill'),
('Fenway', 'At 660 Beacon St., Kenmore Square, Boston'),
('Fenway', 'At Christian Science Plaza, Huntington Avenue, Boston'),
('Dorchester', 'On Victory Road at Boston Harbor, Dorchester, Boston'),
('Jamaica Plain', 'Outside the Boston Children\'s Museum, 308 Congress St.'),
('Cambridge', 'At Porter Square, Cambridge'),
('Charlestown', 'At Monument Square, Charlestown'), 
('East Boston', 'At 150 Orient Ave., East Boston'),
('Jamaica Plain', 'At Jamaica Pond, near Pond St, Boston'), 
('Somerville', 'At Legoland Discovery Center, 598 Assembly Row, Somerville'), 
('Jamaica Plain', 'On Purple Cactus, 674 Centre St., Boston'), 
('Jamaica Plain', 'Perkins Street off Centre Street, behind Whole Foods'),
('Roxbury', 'On Warren Street at Clifford Street, Boston'),
('East Cambridge', 'At Boston Museum of Science lobby, 1 Science Park'), 
('East Cambridge', 'Outside Museum of Science, 1 Science Park, Boston'), 
('Downtown', 'In front of Old State House, Devonshire Street at State Street'),
('Bunker Hill', 'Paul Revere Park, Boston'),
('Chinatown', 'Corner of Tyler and Beach streets, Chinatown'),
('Jamaica Plain', '2 Harris Ave., at Centre Street'),
('Dorchester', 'Atop Expressway Toyota, 700 Morrissey Blvd., Boston'),
('Somerville', '115 College Ave., Somerville'),
('Fenway', 'On Northeastern University\'s Meserve Hall, 35-37 Leon St., Boston'), 
('East Boston', 'At HarborArts, 256 Marginal St., East Boston');

insert into public_art(existence, time, location_id, size_id, title) values
(1, '1897-05-31', 1,  2, 'Shaw Memorial'),
(1, '1995-01-01', 2, 4, 'New England Holocaust Memorial'), 
(1, '1987-10-04', 3, 1, 'Make Way for Ducklings'), 
(1, '2007-01-01', 4, 3, 'Graffiti Wall'), 
(1, '1994-01-01', 5, 1, 'Memorial Buttons'), 
(1, '1960-01-01', 6, 2, 'Orange Dinosaur'), 
(1, '1979-01-01', 7, 3, 'Betances Mural'), 
(1, '1877-01-01', 8, 1, 'Swan Boats'), 
(1, '1951-01-01', 9, 4, 'Freedom Trail'), 
(1, '1965-01-01', 10, 4, 'Citgo Sign'), 
(1, '1972-01-01', 11, 4, 'Reflecting Pool'), 
(1, '1971-01-01', 12, 4, 'Rainbow Swash'), 
(1, '1934-01-01', 13, 4, 'Giant Milk Bottle'), 
(1, '1985-01-01', 14, 4, 'Gift of the Wind'), 
(1, '1842-01-01', 15, 4, 'Bunker Hill Monument'),
(1, '1954-01-01', 16, 3, 'Madonna Queen of the Universe Shrine'),
(1, '2006-01-01', 17, 1, 'Jamaica Pond Bench'), 
(1, '2014-01-01', 18, 2, 'Tessie the Giraffe'), 
(1, '2013-01-01', 19, 4, 'Nieli\'ka'), 
(1, '2013-01-01', 20, 4, 'Taino Indians'), 
(1, '2014-01-01', 21, 4, 'Roxbury Love "Mandela"'), 
(1, '1987-01-01', 22, 3, 'Archimedean Excogitation'), 
(1, '1966-01-01', 23, 4, 'Tyrannosaurus Rex'),
(1, '1887-01-01', 24, 2, 'Site of the Boston Massacre'), 
(1, '2000-01-01', 25, 3, 'Charlestown Bells'), 
(1, null, 26, 1, 'Phillis Wheatley Plaque'), 
(1, '2014-01-01', 27, 3, 'Tenango'), 
(1, '2008-01-01', 28, 2, 'Super Saver'), 
(1, '2002-01-01', 29, 3, 'Mural façade of the Museum of Modern Renaissance'),
(1, '2015-01-01', 30, 4, 'Ars et Scienta'),
(1, '2014-01-01', 31, 4, 'Connected by Sea');

insert into public_art_has_genre(public_art_id, genre_id) values
(1, 1),
(2, 1),
(3, 2),
(4, 3),
(6, 4),
(7, 5),
(8, 6),
(9, 7),
(10, 8),
(14, 2),
(15, 4),
(16, 4),
(17, 9),
(18, 4),
(19, 5),
(20, 5),
(21, 5),
(22, 10),
(23, 4),
(26, 11),
(27, 5),
(28, 4),
(29, 3),
(30, 3),
(31, 3);

insert into public_art_has_artist(public_art_id, artist_id) values
(1, 1), 
(2, 2), 
(3, 3), 
(5, 4), 
(7, 5),
(11,6), 
(12, 7),
(13, 8),
(14, 9),
(15, 10), 
(16, 11),
(17,12),
(18,13),
(19,14),
(20,15),
(21,16),
(22,17),
(23,18),
(24,19),
(25,20),
(26,21),
(27,22),
(28,23),
(29,24),
(30,25),
(31,26);