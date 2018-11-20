-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

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
  `location_id` INT NOT NULL,
  `neighborhood` VARCHAR(50) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`location_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`size`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`size` ;

CREATE TABLE IF NOT EXISTS `bosart`.`size` (
  `size_id` INT NOT NULL,
  `size` ENUM('small', 'medium', 'large') NOT NULL,
  PRIMARY KEY (`size_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`public_art`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`public_art` ;

CREATE TABLE IF NOT EXISTS `bosart`.`public_art` (
  `public_art_id` INT NOT NULL,
  `existence` TINYINT NOT NULL,
  `time` DATETIME NULL,
  `description` VARCHAR(300) NULL,
  `location_id` INT NOT NULL,
  `size_id` INT NOT NULL,
  `title` VARCHAR(50) NULL,
  PRIMARY KEY (`public_art_id`),
  INDEX `fk_public_art_location_idx` (`location_id` ASC) VISIBLE,
  INDEX `fk_public_art_size1_idx` (`size_id` ASC) VISIBLE,
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
  `genre_id` INT NOT NULL,
  `medium` VARCHAR(30) NULL,
  PRIMARY KEY (`genre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bosart`.`artist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bosart`.`artist` ;

CREATE TABLE IF NOT EXISTS `bosart`.`artist` (
  `artist_id` INT NOT NULL,
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
  INDEX `fk_public_art_has_artist_artist1_idx` (`artist_id` ASC) VISIBLE,
  INDEX `fk_public_art_has_artist_public_art1_idx` (`public_art_id` ASC) VISIBLE,
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
  INDEX `fk_public_art_has_genre_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_public_art_has_genre_public_art1_idx` (`public_art_id` ASC) VISIBLE,
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
