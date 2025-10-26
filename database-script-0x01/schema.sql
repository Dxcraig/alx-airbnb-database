-- ================================================
-- AirBnB Database Schema
-- ================================================
-- This script creates all tables for the AirBnB database system
-- with proper constraints, indexes, and relationships
-- ================================================

-- Drop existing tables if they exist (in reverse order of dependencies)
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS User;

-- ================================================
-- Table: User
-- Description: Stores user information for guests, hosts, and admins
-- ================================================
CREATE TABLE User (
    user_id CHAR(36) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Indexes
    INDEX idx_user_email (email),
    INDEX idx_user_role (role)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- Table: Property
-- Description: Stores property listings created by hosts
-- ================================================
CREATE TABLE Property (
    property_id CHAR(36) PRIMARY KEY,
    host_id CHAR(36) NOT NULL,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255) NOT NULL,
    pricepernight DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Indexes
    INDEX idx_property_host_id (host_id),
    INDEX idx_property_location (location),
    INDEX idx_property_price (pricepernight)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- Table: Booking
-- Description: Stores booking information for properties
-- ================================================
CREATE TABLE Booking (
    booking_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_booking_dates CHECK (end_date > start_date),
    CONSTRAINT chk_booking_price CHECK (total_price >= 0),
    
    -- Indexes
    INDEX idx_booking_property_id (property_id),
    INDEX idx_booking_user_id (user_id),
    INDEX idx_booking_dates (start_date, end_date),
    INDEX idx_booking_status (status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- Table: Payment
-- Description: Stores payment information for bookings
-- ================================================
CREATE TABLE Payment (
    payment_id CHAR(36) PRIMARY KEY,
    booking_id CHAR(36) UNIQUE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    
    -- Foreign Key Constraints
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_payment_amount CHECK (amount >= 0),
    
    -- Indexes
    INDEX idx_payment_booking_id (booking_id),
    INDEX idx_payment_date (payment_date),
    INDEX idx_payment_method (payment_method)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- Table: Review
-- Description: Stores user reviews for properties
-- ================================================
CREATE TABLE Review (
    review_id CHAR(36) PRIMARY KEY,
    property_id CHAR(36) NOT NULL,
    user_id CHAR(36) NOT NULL,
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_review_rating CHECK (rating >= 1 AND rating <= 5),
    
    -- Indexes
    INDEX idx_review_property_id (property_id),
    INDEX idx_review_user_id (user_id),
    INDEX idx_review_rating (rating),
    INDEX idx_review_created_at (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- Table: Message
-- Description: Stores messages between users
-- ================================================
CREATE TABLE Message (
    message_id CHAR(36) PRIMARY KEY,
    sender_id CHAR(36) NOT NULL,
    recipient_id CHAR(36) NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    -- Foreign Key Constraints
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,
    
    -- Check Constraints
    CONSTRAINT chk_message_different_users CHECK (sender_id != recipient_id),
    
    -- Indexes
    INDEX idx_message_sender_id (sender_id),
    INDEX idx_message_recipient_id (recipient_id),
    INDEX idx_message_sent_at (sent_at),
    INDEX idx_message_conversation (sender_id, recipient_id, sent_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ================================================
-- End of Schema Creation
-- ================================================
