-- MySQL Script generated by MySQL Workbench
-- Wed Oct 30 11:24:22 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Pizzeria
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Pizzeria` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `Pizzeria` ;

-- -----------------------------------------------------
-- Table `Pizzeria`.`Province`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Province` (
  `idProvince` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idProvince`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Location` (
  `idLocation` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `idProvince` INT NULL,
  PRIMARY KEY (`idLocation`),
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizzeria`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Customers` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `lastName` VARCHAR(45) NULL,
  `address` VARCHAR(200) NULL,
  `postalCode` VARCHAR(45) NULL,
  `phoneNumber` INT NULL,
  `idLocation` INT NULL,
  `idProvince` INT NULL,
  PRIMARY KEY (`idCustomer`),
  INDEX `idLocation_idx` (`idLocation` ASC) VISIBLE,
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idLocation`
    FOREIGN KEY (`idLocation`)
    REFERENCES `Pizzeria`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizzeria`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Orders` (
  `idOrders` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `date/time` VARCHAR(45) NULL,
  `delivery/pickup` ENUM('delivery', 'pick-up') NULL,
  `totalPrice` DOUBLE NULL,
  PRIMARY KEY (`idOrders`),
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `Pizzeria`.`Customers` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Products` (
  `idProduct` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `description` VARCHAR(300) NULL,
  `image` VARCHAR(45) NULL,
  `price` DOUBLE NULL,
  PRIMARY KEY (`idProduct`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Categories` (
  `idCategory` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  PRIMARY KEY (`idCategory`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Pizzas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Pizzas` (
  `idPizza` INT NOT NULL AUTO_INCREMENT,
  `idProduct` INT NULL,
  `idCategory` INT NULL,
  PRIMARY KEY (`idPizza`),
  INDEX `idProduct_idx` (`idProduct` ASC) VISIBLE,
  INDEX `idCategory_idx` (`idCategory` ASC) VISIBLE,
  CONSTRAINT `idProduct`
    FOREIGN KEY (`idProduct`)
    REFERENCES `Pizzeria`.`Products` (`idProduct`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCategory`
    FOREIGN KEY (`idCategory`)
    REFERENCES `Pizzeria`.`Categories` (`idCategory`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Stores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Stores` (
  `idStore` INT NOT NULL AUTO_INCREMENT,
  `address` VARCHAR(45) NULL,
  `postalCode` VARCHAR(45) NULL,
  `idLocation` INT NULL,
  `idProvince` INT NULL,
  PRIMARY KEY (`idStore`),
  INDEX `idLocation_idx` (`idLocation` ASC) VISIBLE,
  INDEX `idProvince_idx` (`idProvince` ASC) VISIBLE,
  CONSTRAINT `idLocation`
    FOREIGN KEY (`idLocation`)
    REFERENCES `Pizzeria`.`Location` (`idLocation`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idProvince`
    FOREIGN KEY (`idProvince`)
    REFERENCES `Pizzeria`.`Province` (`idProvince`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pizzeria`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pizzeria`.`Employees` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `surname` VARCHAR(45) NULL,
  `NIF` INT NULL,
  `phone` INT NULL,
  `type` ENUM('cook', 'delivery') NULL,
  `idStore` INT NULL,
  PRIMARY KEY (`idEmployee`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE,
  INDEX `idStore_idx` (`idStore` ASC) VISIBLE,
  CONSTRAINT `idStore`
    FOREIGN KEY (`idStore`)
    REFERENCES `Pizzeria`.`Stores` (`idStore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;