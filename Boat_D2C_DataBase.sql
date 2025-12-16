-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema boat
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema boat
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `boat` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `boat` ;

-- -----------------------------------------------------
-- Table `boat`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`customers` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(50) NOT NULL,
  `last_name` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `phone` VARCHAR(15) NULL DEFAULT NULL,
  `address` TEXT NULL DEFAULT NULL,
  `city` VARCHAR(50) NULL DEFAULT NULL,
  `state` VARCHAR(50) NULL DEFAULT NULL,
  `pincode` VARCHAR(10) NULL DEFAULT NULL,
  `loyalty_points` INT NULL DEFAULT '0',
  `registration_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`customer_id`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE,
  INDEX `idx_customer_email` (`email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`carts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`carts` (
  `cart_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_id`),
  UNIQUE INDEX `unique_customer_cart` (`customer_id` ASC) VISIBLE,
  INDEX `idx_cart_customer` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `carts_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `boat`.`customers` (`customer_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`categories` (
  `category_id` INT NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(100) NOT NULL,
  `category_description` TEXT NULL DEFAULT NULL,
  `parent_category_id` INT NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  INDEX `parent_category_id` (`parent_category_id` ASC) VISIBLE,
  CONSTRAINT `categories_ibfk_1`
    FOREIGN KEY (`parent_category_id`)
    REFERENCES `boat`.`categories` (`category_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`products`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`products` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `category_id` INT NOT NULL,
  `product_name` VARCHAR(200) NOT NULL,
  `brand` VARCHAR(50) NULL DEFAULT 'boAt',
  `model_number` VARCHAR(50) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `specifications` JSON NULL DEFAULT NULL,
  `mrp` DECIMAL(10,2) NOT NULL,
  `selling_price` DECIMAL(10,2) NOT NULL,
  `discount_percent` DECIMAL(5,2) NULL DEFAULT '0.00',
  `warranty_months` INT NULL DEFAULT '12',
  `is_available` TINYINT(1) NULL DEFAULT '1',
  `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`product_id`),
  UNIQUE INDEX `model_number` (`model_number` ASC) VISIBLE,
  INDEX `idx_product_category` (`category_id` ASC) VISIBLE,
  CONSTRAINT `products_ibfk_1`
    FOREIGN KEY (`category_id`)
    REFERENCES `boat`.`categories` (`category_id`)
    ON DELETE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`product_variants`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`product_variants` (
  `variant_id` INT NOT NULL AUTO_INCREMENT,
  `product_id` INT NOT NULL,
  `color` VARCHAR(50) NULL DEFAULT NULL,
  `variant_name` VARCHAR(100) NULL DEFAULT NULL,
  `sku` VARCHAR(50) NOT NULL,
  `additional_price` DECIMAL(8,2) NULL DEFAULT '0.00',
  `image_url` VARCHAR(500) NULL DEFAULT NULL,
  `stock_quantity` INT NULL DEFAULT '0',
  PRIMARY KEY (`variant_id`),
  UNIQUE INDEX `sku` (`sku` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  CONSTRAINT `product_variants_ibfk_1`
    FOREIGN KEY (`product_id`)
    REFERENCES `boat`.`products` (`product_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`cart_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`cart_items` (
  `cart_item_id` INT NOT NULL AUTO_INCREMENT,
  `cart_id` INT NOT NULL,
  `variant_id` INT NOT NULL,
  `quantity` INT NOT NULL DEFAULT '1',
  `added_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`cart_item_id`),
  UNIQUE INDEX `unique_cart_variant` (`cart_id` ASC, `variant_id` ASC) VISIBLE,
  INDEX `variant_id` (`variant_id` ASC) VISIBLE,
  CONSTRAINT `cart_items_ibfk_1`
    FOREIGN KEY (`cart_id`)
    REFERENCES `boat`.`carts` (`cart_id`)
    ON DELETE CASCADE,
  CONSTRAINT `cart_items_ibfk_2`
    FOREIGN KEY (`variant_id`)
    REFERENCES `boat`.`product_variants` (`variant_id`)
    ON DELETE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`coupons`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`coupons` (
  `coupon_id` INT NOT NULL AUTO_INCREMENT,
  `coupon_code` VARCHAR(50) NOT NULL,
  `discount_type` ENUM('percentage', 'fixed') NULL DEFAULT 'percentage',
  `discount_value` DECIMAL(8,2) NOT NULL,
  `min_order_value` DECIMAL(10,2) NULL DEFAULT NULL,
  `usage_limit` INT NULL DEFAULT NULL,
  `used_count` INT NULL DEFAULT '0',
  `valid_from` DATE NULL DEFAULT NULL,
  `valid_till` DATE NULL DEFAULT NULL,
  `is_active` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`coupon_id`),
  UNIQUE INDEX `coupon_code` (`coupon_code` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `coupon_id` INT NULL DEFAULT NULL,
  `order_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `order_status` ENUM('pending', 'confirmed', 'shipped', 'delivered', 'cancelled', 'returned') NULL DEFAULT 'pending',
  `total_amount` DECIMAL(10,2) NOT NULL,
  `discount_amount` DECIMAL(10,2) NULL DEFAULT '0.00',
  `shipping_charges` DECIMAL(8,2) NULL DEFAULT '0.00',
  `tax_amount` DECIMAL(8,2) NULL DEFAULT '0.00',
  `shipping_address` TEXT NOT NULL,
  `tracking_id` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `customer_id` (`customer_id` ASC) VISIBLE,
  INDEX `coupon_id` (`coupon_id` ASC) VISIBLE,
  INDEX `idx_order_status_date` (`order_status` ASC, `order_date` ASC) VISIBLE,
  CONSTRAINT `orders_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `boat`.`customers` (`customer_id`)
    ON DELETE RESTRICT,
  CONSTRAINT `orders_ibfk_2`
    FOREIGN KEY (`coupon_id`)
    REFERENCES `boat`.`coupons` (`coupon_id`)
    ON DELETE SET NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`order_items`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`order_items` (
  `order_item_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `variant_id` INT NOT NULL,
  `quantity` INT NOT NULL,
  `unit_price` DECIMAL(10,2) NOT NULL,
  `total_price` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`order_item_id`),
  INDEX `order_id` (`order_id` ASC) VISIBLE,
  INDEX `idx_order_items_variant` (`variant_id` ASC) VISIBLE,
  CONSTRAINT `order_items_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `boat`.`orders` (`order_id`)
    ON DELETE CASCADE,
  CONSTRAINT `order_items_ibfk_2`
    FOREIGN KEY (`variant_id`)
    REFERENCES `boat`.`product_variants` (`variant_id`)
    ON DELETE RESTRICT)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`payments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`payments` (
  `payment_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `payment_method` ENUM('COD', 'UPI', 'Card', 'Wallet', 'Netbanking') NULL DEFAULT NULL,
  `amount` DECIMAL(10,2) NOT NULL,
  `payment_status` ENUM('pending', 'success', 'failed', 'refunded') NULL DEFAULT 'pending',
  `transaction_id` VARCHAR(100) NULL DEFAULT NULL,
  `payment_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`payment_id`),
  UNIQUE INDEX `unique_order_payment` (`order_id` ASC) VISIBLE,
  CONSTRAINT `payments_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `boat`.`orders` (`order_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`reviews`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`reviews` (
  `review_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `order_item_id` INT NOT NULL,
  `rating` INT NULL DEFAULT NULL,
  `review_title` VARCHAR(200) NULL DEFAULT NULL,
  `review_text` TEXT NULL DEFAULT NULL,
  `review_date` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  `is_verified` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`review_id`),
  UNIQUE INDEX `unique_review_item` (`customer_id` ASC, `order_item_id` ASC) VISIBLE,
  INDEX `order_item_id` (`order_item_id` ASC) VISIBLE,
  CONSTRAINT `reviews_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `boat`.`customers` (`customer_id`)
    ON DELETE CASCADE,
  CONSTRAINT `reviews_ibfk_2`
    FOREIGN KEY (`order_item_id`)
    REFERENCES `boat`.`order_items` (`order_item_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`shipping`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`shipping` (
  `shipping_id` INT NOT NULL AUTO_INCREMENT,
  `order_id` INT NOT NULL,
  `courier_partner` VARCHAR(50) NULL DEFAULT NULL,
  `shipping_cost` DECIMAL(8,2) NULL DEFAULT NULL,
  `shipped_date` TIMESTAMP NULL DEFAULT NULL,
  `delivered_date` TIMESTAMP NULL DEFAULT NULL,
  `return_date` TIMESTAMP NULL DEFAULT NULL,
  PRIMARY KEY (`shipping_id`),
  UNIQUE INDEX `unique_order_shipping` (`order_id` ASC) VISIBLE,
  CONSTRAINT `shipping_ibfk_1`
    FOREIGN KEY (`order_id`)
    REFERENCES `boat`.`orders` (`order_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `boat`.`wishlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `boat`.`wishlist` (
  `wishlist_id` INT NOT NULL AUTO_INCREMENT,
  `customer_id` INT NOT NULL,
  `product_id` INT NOT NULL,
  `variant_id` INT NOT NULL,
  `added_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`wishlist_id`),
  UNIQUE INDEX `unique_wishlist` (`customer_id` ASC, `variant_id` ASC) VISIBLE,
  INDEX `product_id` (`product_id` ASC) VISIBLE,
  INDEX `variant_id` (`variant_id` ASC) VISIBLE,
  CONSTRAINT `wishlist_ibfk_1`
    FOREIGN KEY (`customer_id`)
    REFERENCES `boat`.`customers` (`customer_id`)
    ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_2`
    FOREIGN KEY (`product_id`)
    REFERENCES `boat`.`products` (`product_id`)
    ON DELETE CASCADE,
  CONSTRAINT `wishlist_ibfk_3`
    FOREIGN KEY (`variant_id`)
    REFERENCES `boat`.`product_variants` (`variant_id`)
    ON DELETE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
