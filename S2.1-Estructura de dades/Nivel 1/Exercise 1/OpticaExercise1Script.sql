-- MySQL Script generated by MySQL Workbench
-- Wed Oct 30 11:16:43 2024
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Optics
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Optics
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Optics` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema new_schema1
-- -----------------------------------------------------
USE `Optics` ;

-- -----------------------------------------------------
-- Table `Optics`.`Supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Supplier` (
  `idSupplier` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NULL,
  `phone` INT NULL,
  `Fax` VARCHAR(45) NULL,
  `NIF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSupplier`),
  UNIQUE INDEX `NIF_UNIQUE` (`NIF` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Brand`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Brand` (
  `idBrand` INT NOT NULL AUTO_INCREMENT,
  `Name` VARCHAR(45) NULL,
  `idSupplier` INT NULL,
  PRIMARY KEY (`idBrand`),
  INDEX `idSupplier_idx` (`idSupplier` ASC) VISIBLE,
  CONSTRAINT `idSupplier`
    FOREIGN KEY (`idSupplier`)
    REFERENCES `Optics`.`Supplier` (`idSupplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Glasses` (
  `idGlasses` INT NOT NULL AUTO_INCREMENT,
  `PrescriptionLeftEye` DOUBLE NULL,
  `PrescriptionRightEye` DOUBLE NULL,
  `MountType` ENUM('floating', 'paste', 'metallic') NULL,
  `MountColor` VARCHAR(45) NULL,
  `ColorLeftGlass` VARCHAR(45) NULL,
  `ColorRightGlass` VARCHAR(45) NULL,
  `Price` DOUBLE NULL,
  `IdBrand` INT NULL,
  PRIMARY KEY (`idGlasses`),
  INDEX `IdBrand_idx` (`IdBrand` ASC) VISIBLE,
  CONSTRAINT `IdBrand`
    FOREIGN KEY (`IdBrand`)
    REFERENCES `Optics`.`Brand` (`idBrand`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Customer` (
  `idCustomer` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `postalAddress` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `registrationDate` DATE NULL,
  `customerReferredby` INT NULL,
  PRIMARY KEY (`idCustomer`),
  INDEX `idCustomerWhoRecommended_idx` (`customerReferredby` ASC) VISIBLE,
  CONSTRAINT `idCustomerWhoRecommended`
    FOREIGN KEY (`customerReferredby`)
    REFERENCES `Optics`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Employee` (
  `idEmployee` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `position` VARCHAR(45) NULL,
  PRIMARY KEY (`idEmployee`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Sale`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Sale` (
  `idSale` INT NOT NULL AUTO_INCREMENT,
  `idCustomer` INT NULL,
  `idEmployee` INT NULL,
  `DateSale` DATE NULL,
  `idGlasses` INT NULL,
  `invoice` INT NULL,
  PRIMARY KEY (`idSale`),
  INDEX `idEmployee_idx` (`idEmployee` ASC) VISIBLE,
  INDEX `idCustomer_idx` (`idCustomer` ASC) VISIBLE,
  UNIQUE INDEX `invoice_UNIQUE` (`invoice` ASC) VISIBLE,
  CONSTRAINT `idEmployee`
    FOREIGN KEY (`idEmployee`)
    REFERENCES `Optics`.`Employee` (`idEmployee`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idCustomer`
    FOREIGN KEY (`idCustomer`)
    REFERENCES `Optics`.`Customer` (`idCustomer`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Optics`.`Sale_has_Glasses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Optics`.`Sale_has_Glasses` (
  `Sale_idSale` INT NOT NULL,
  `Glasses_idGlasses` INT NOT NULL,
  PRIMARY KEY (`Sale_idSale`, `Glasses_idGlasses`),
  INDEX `fk_Sale_has_Glasses_Glasses1_idx` (`Glasses_idGlasses` ASC) VISIBLE,
  INDEX `fk_Sale_has_Glasses_Sale1_idx` (`Sale_idSale` ASC) VISIBLE,
  CONSTRAINT `fk_Sale_has_Glasses_Sale1`
    FOREIGN KEY (`Sale_idSale`)
    REFERENCES `Optics`.`Sale` (`idSale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sale_has_Glasses_Glasses1`
    FOREIGN KEY (`Glasses_idGlasses`)
    REFERENCES `Optics`.`Glasses` (`idGlasses`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;