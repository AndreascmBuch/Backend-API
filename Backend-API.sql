-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema portfolio5
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema portfolio5
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `portfolio5` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `portfolio5` ;

-- -----------------------------------------------------
-- Table `portfolio5`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio5`.`users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(15) NULL DEFAULT NULL,
  `password` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `portfolio5`.`cafes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio5`.`cafes` (
  `cafe_id` INT NOT NULL AUTO_INCREMENT,
  `cafe_name` VARCHAR(50) NULL DEFAULT NULL,
  `location` VARCHAR(45) NULL DEFAULT NULL,
  `user_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`cafe_id`),
  INDEX `user_id` (`user_id` ASC) VISIBLE,
  CONSTRAINT `cafes_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `portfolio5`.`users` (`user_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `portfolio5`.`favorites`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `portfolio5`.`favorites` (
  `user_id` INT NOT NULL,
  `cafe_id` INT NOT NULL,
  `cafe_name` VARCHAR(50) NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`, `cafe_id`),
  INDEX `cafe_id` (`cafe_id` ASC) VISIBLE,
  CONSTRAINT `favorites_ibfk_1`
    FOREIGN KEY (`user_id`)
    REFERENCES `portfolio5`.`users` (`user_id`),
  CONSTRAINT `favorites_ibfk_2`
    FOREIGN KEY (`cafe_id`)
    REFERENCES `portfolio5`.`cafes` (`cafe_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
