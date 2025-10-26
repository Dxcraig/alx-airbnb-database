# AirBnB Database Schema

## Overview
This directory contains the SQL schema definition for the AirBnB database system. The schema implements a complete relational database structure for managing users, properties, bookings, payments, reviews, and messages.

## Files
- `schema.sql` - Complete database schema with all table definitions, constraints, and indexes

## Database Structure

### Tables

#### 1. **User**
Stores information about all users in the system (guests, hosts, and admins).

**Columns:**
- `user_id` (CHAR(36), PK) - Unique identifier
- `first_name` (VARCHAR(100)) - User's first name
- `last_name` (VARCHAR(100)) - User's last name
- `email` (VARCHAR(255), UNIQUE) - User's email address
- `password_hash` (VARCHAR(255)) - Hashed password
- `phone_number` (VARCHAR(20), NULL) - Contact number
- `role` (ENUM) - User role: guest, host, or admin
- `created_at` (TIMESTAMP) - Account creation timestamp

**Indexes:** `email`, `role`

---

#### 2. **Property**
Stores property listings created by hosts.

**Columns:**
- `property_id` (CHAR(36), PK) - Unique identifier
- `host_id` (CHAR(36), FK) - Reference to User
- `name` (VARCHAR(255)) - Property name
- `description` (TEXT) - Detailed description
- `location` (VARCHAR(255)) - Property location
- `pricepernight` (DECIMAL(10,2)) - Nightly rate
- `created_at` (TIMESTAMP) - Listing creation time
- `updated_at` (TIMESTAMP) - Last update time

**Foreign Keys:** `host_id` → `User(user_id)`  
**Indexes:** `host_id`, `location`, `pricepernight`

---

#### 3. **Booking**
Stores booking records for properties.

**Columns:**
- `booking_id` (CHAR(36), PK) - Unique identifier
- `property_id` (CHAR(36), FK) - Reference to Property
- `user_id` (CHAR(36), FK) - Reference to User (guest)
- `start_date` (DATE) - Check-in date
- `end_date` (DATE) - Check-out date
- `total_price` (DECIMAL(10,2)) - Total booking cost
- `status` (ENUM) - Booking status: pending, confirmed, or canceled
- `created_at` (TIMESTAMP) - Booking creation time

**Foreign Keys:** 
- `property_id` → `Property(property_id)`
- `user_id` → `User(user_id)`

**Constraints:**
- `end_date` must be after `start_date`
- `total_price` must be non-negative

**Indexes:** `property_id`, `user_id`, `start_date/end_date`, `status`

---

#### 4. **Payment**
Stores payment transactions for bookings (1:1 relationship with Booking).

**Columns:**
- `payment_id` (CHAR(36), PK) - Unique identifier
- `booking_id` (CHAR(36), FK, UNIQUE) - Reference to Booking
- `amount` (DECIMAL(10,2)) - Payment amount
- `payment_date` (TIMESTAMP) - Payment timestamp
- `payment_method` (ENUM) - Method: credit_card, paypal, or stripe

**Foreign Keys:** `booking_id` → `Booking(booking_id)` (UNIQUE for 1:1 relationship)  
**Constraints:** `amount` must be non-negative  
**Indexes:** `booking_id`, `payment_date`, `payment_method`

---

#### 5. **Review**
Stores user reviews for properties.

**Columns:**
- `review_id` (CHAR(36), PK) - Unique identifier
- `property_id` (CHAR(36), FK) - Reference to Property
- `user_id` (CHAR(36), FK) - Reference to User (reviewer)
- `rating` (INTEGER) - Rating value (1-5)
- `comment` (TEXT) - Review text
- `created_at` (TIMESTAMP) - Review creation time

**Foreign Keys:**
- `property_id` → `Property(property_id)`
- `user_id` → `User(user_id)`

**Constraints:** `rating` must be between 1 and 5  
**Indexes:** `property_id`, `user_id`, `rating`, `created_at`

---

#### 6. **Message**
Stores messages between users.

**Columns:**
- `message_id` (CHAR(36), PK) - Unique identifier
- `sender_id` (CHAR(36), FK) - Reference to User (sender)
- `recipient_id` (CHAR(36), FK) - Reference to User (recipient)
- `message_body` (TEXT) - Message content
- `sent_at` (TIMESTAMP) - Message timestamp

**Foreign Keys:**
- `sender_id` → `User(user_id)`
- `recipient_id` → `User(user_id)`

**Constraints:** `sender_id` and `recipient_id` must be different  
**Indexes:** `sender_id`, `recipient_id`, `sent_at`, composite index on `(sender_id, recipient_id, sent_at)` for conversation queries

---

## Key Features

### Data Integrity
- ✅ All tables use UUID (CHAR(36)) for primary keys
- ✅ Foreign key constraints with CASCADE delete
- ✅ CHECK constraints for data validation
- ✅ UNIQUE constraints where needed
- ✅ NOT NULL constraints on required fields

### Performance Optimization
- ✅ Strategic indexes on frequently queried columns
- ✅ Composite indexes for common query patterns
- ✅ Foreign key indexes for efficient joins
- ✅ InnoDB engine for transaction support

### Data Types
- ✅ Proper use of VARCHAR, TEXT, DECIMAL, DATE, TIMESTAMP
- ✅ ENUM types for constrained values
- ✅ UTF8MB4 character set for international support

### Automatic Features
- ✅ Auto-updating timestamps (`updated_at` on Property)
- ✅ Default CURRENT_TIMESTAMP on creation timestamps
- ✅ Audit trail with creation timestamps

## Relationships

| From | To | Type | Description |
|------|-----|------|-------------|
| User | Property | 1:N | A host can own multiple properties |
| User | Booking | 1:N | A guest can make multiple bookings |
| Property | Booking | 1:N | A property can have multiple bookings |
| Booking | Payment | 1:1 | Each booking has exactly one payment |
| Property | Review | 1:N | A property can have multiple reviews |
| User | Review | 1:N | A user can write multiple reviews |
| User | Message | 1:N | A user can send/receive multiple messages |

## Installation

### Prerequisites
- MySQL 5.7+ or MariaDB 10.2+
- Appropriate database privileges

### Steps

1. **Create Database:**
```sql
CREATE DATABASE airbnb_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE airbnb_db;
```

2. **Run Schema:**
```bash
mysql -u your_username -p airbnb_db < schema.sql
```

Or from MySQL prompt:
```sql
SOURCE schema.sql;
```

3. **Verify Installation:**
```sql
SHOW TABLES;
DESCRIBE User;
```

## Usage Examples

### Create a New User
```sql
INSERT INTO User (user_id, first_name, last_name, email, password_hash, role)
VALUES (UUID(), 'John', 'Doe', 'john@example.com', 'hashed_password', 'guest');
```

### Create a Property Listing
```sql
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight)
VALUES (UUID(), 'host_uuid_here', 'Cozy Apartment', 'Beautiful 2BR apartment', 'New York', 150.00);
```

### Create a Booking
```sql
INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status)
VALUES (UUID(), 'property_uuid', 'user_uuid', '2025-11-01', '2025-11-05', 600.00, 'confirmed');
```

## Maintenance

### Backup
```bash
mysqldump -u username -p airbnb_db > airbnb_backup.sql
```

### Restore
```bash
mysql -u username -p airbnb_db < airbnb_backup.sql
```

### View Indexes
```sql
SHOW INDEX FROM User;
```

## Notes

- All UUID values should be generated using appropriate UUID functions (e.g., `UUID()` in MySQL)
- Password hashing should be done at the application level before insertion
- The schema includes `ON DELETE CASCADE` for automatic cleanup of related records
- Regular index maintenance and query optimization may be needed as data grows

## Contributing

When modifying the schema:
1. Update this README with any changes
2. Test migrations on a development database first
3. Document any breaking changes
4. Update the ERD if relationships change

## License

This schema is part of the ALX AirBnB Database project.

---

**Last Updated:** October 26, 2025
