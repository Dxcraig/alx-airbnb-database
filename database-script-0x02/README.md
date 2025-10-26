# AirBnB Database - Sample Data Seeding

## Overview
This directory contains SQL scripts to populate the AirBnB database with realistic sample data for testing and development purposes.

## Files
- `seed.sql` - Complete seeding script with INSERT statements for all tables

## What's Included

### Sample Data Statistics

| Table | Records | Description |
|-------|---------|-------------|
| **User** | 13 | 1 admin, 5 hosts, 7 guests |
| **Property** | 10 | Various property types across different locations |
| **Booking** | 15 | 10 confirmed, 3 pending, 2 canceled |
| **Payment** | 10 | One payment per confirmed booking |
| **Review** | 15 | Ratings from 3-5 stars with detailed comments |
| **Message** | 24 | 6 conversation threads between guests and hosts |

---

## Data Details

### Users
The sample includes a diverse set of users representing all three roles:

- **1 Admin:** System administrator account
- **5 Hosts:** Property owners with 2 listings each
- **7 Guests:** Travelers who book properties and leave reviews

**Features:**
- Realistic names and email addresses
- Mix of users with and without phone numbers
- Password hashes (placeholder values using bcrypt format)
- Account creation dates spanning from January to August 2024

### Properties
10 diverse property listings across major US cities:

| Location | Property Type | Price/Night |
|----------|--------------|-------------|
| New York, NY | Downtown Loft | $189.99 |
| Austin, TX | Family Home | $275.00 |
| Miami, FL | Beachfront Condo | $320.50 |
| Denver, CO | Mountain Cabin | $195.00 |
| San Francisco, CA | Urban Studio | $145.00 |
| Chicago, IL | Luxury Penthouse | $450.00 |
| Boston, MA | Historic Brownstone | $210.00 |
| Seattle, WA | Lakeside Cottage | $165.00 |
| Phoenix, AZ | Desert Villa | $235.00 |
| Portland, OR | Downtown Condo | $155.00 |

**Features:**
- Detailed, marketing-quality descriptions
- Variety of property types (studio, house, condo, cabin, villa)
- Price range: $145 - $450 per night
- Each host manages 2 properties

### Bookings
15 bookings with realistic date ranges and pricing:

- **10 Confirmed:** Completed bookings with associated payments
- **3 Pending:** Future bookings awaiting confirmation
- **2 Canceled:** Bookings that were canceled by guests

**Date Range:** October 2024 - February 2025

**Features:**
- Total prices calculated based on nightly rate × number of nights
- Various stay durations (3-9 nights)
- Status distribution reflects real-world patterns

### Payments
10 payment records (one for each confirmed booking):

**Payment Methods:**
- Credit Card: 5 payments
- PayPal: 3 payments
- Stripe: 2 payments

**Features:**
- Payment amounts exactly match booking totals
- Payment timestamps align with booking creation
- 1:1 relationship with confirmed bookings

### Reviews
15 authentic-sounding reviews from guests:

**Rating Distribution:**
- 5 Stars: 11 reviews (73%)
- 4 Stars: 3 reviews (20%)
- 3 Stars: 1 review (7%)

**Features:**
- Detailed comments mentioning specific aspects (location, cleanliness, host responsiveness)
- Reviews only from guests who actually booked the properties
- Realistic feedback including both praise and constructive criticism
- Posted after booking completion dates

### Messages
24 messages organized into 6 conversation threads:

**Conversation Topics:**
1. Parking and check-in logistics
2. Beach amenities and restaurant recommendations
3. Laundry facilities and early check-in
4. Welcome message and thank you
5. Pool heating and crib availability
6. Winter road access questions
7. Anniversary celebration special requests

**Features:**
- Natural back-and-forth dialogue between guests and hosts
- Questions about amenities, check-in, and special requests
- Professional and friendly communication style
- Chronological message threading

---

## Installation

### Prerequisites
- MySQL 5.7+ or MariaDB 10.2+
- Database schema already created (see `database-script-0x01`)
- Appropriate database privileges

### Steps

1. **Ensure Schema Exists:**
   ```bash
   # First, make sure you've run the schema creation script
   mysql -u your_username -p airbnb_db < ../database-script-0x01/schema.sql
   ```

2. **Run Seed Script:**
   ```bash
   mysql -u your_username -p airbnb_db < seed.sql
   ```

   Or from MySQL prompt:
   ```sql
   USE airbnb_db;
   SOURCE seed.sql;
   ```

3. **Verify Data:**
   ```sql
   -- Check record counts
   SELECT COUNT(*) as total_users FROM User;
   SELECT COUNT(*) as total_properties FROM Property;
   SELECT COUNT(*) as total_bookings FROM Booking;
   SELECT COUNT(*) as total_payments FROM Payment;
   SELECT COUNT(*) as total_reviews FROM Review;
   SELECT COUNT(*) as total_messages FROM Message;
   
   -- Check data distribution
   SELECT role, COUNT(*) as count FROM User GROUP BY role;
   SELECT status, COUNT(*) as count FROM Booking GROUP BY status;
   SELECT payment_method, COUNT(*) as count FROM Payment GROUP BY payment_method;
   SELECT rating, COUNT(*) as count FROM Review GROUP BY rating;
   ```

---

## Usage Examples

### Query Users by Role
```sql
SELECT first_name, last_name, email, role 
FROM User 
WHERE role = 'host';
```

### Find Available Properties
```sql
SELECT p.name, p.location, p.pricepernight,
       CONCAT(u.first_name, ' ', u.last_name) as host_name
FROM Property p
JOIN User u ON p.host_id = u.user_id
ORDER BY p.pricepernight;
```

### View Confirmed Bookings with Guest Info
```sql
SELECT b.booking_id, 
       p.name as property_name,
       CONCAT(u.first_name, ' ', u.last_name) as guest_name,
       b.start_date, b.end_date, b.total_price
FROM Booking b
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id
WHERE b.status = 'confirmed'
ORDER BY b.start_date;
```

### Get Property Reviews with Ratings
```sql
SELECT p.name as property,
       CONCAT(u.first_name, ' ', u.last_name) as reviewer,
       r.rating,
       r.comment,
       r.created_at
FROM Review r
JOIN Property p ON r.property_id = p.property_id
JOIN User u ON r.user_id = u.user_id
ORDER BY r.created_at DESC;
```

### View Payment History
```sql
SELECT pay.payment_id,
       CONCAT(u.first_name, ' ', u.last_name) as guest,
       p.name as property,
       pay.amount,
       pay.payment_method,
       pay.payment_date
FROM Payment pay
JOIN Booking b ON pay.booking_id = b.booking_id
JOIN Property p ON b.property_id = p.property_id
JOIN User u ON b.user_id = u.user_id
ORDER BY pay.payment_date DESC;
```

### Find Message Conversations
```sql
SELECT m.sent_at,
       CONCAT(sender.first_name, ' ', sender.last_name) as sender,
       CONCAT(recipient.first_name, ' ', recipient.last_name) as recipient,
       m.message_body
FROM Message m
JOIN User sender ON m.sender_id = sender.user_id
JOIN User recipient ON m.recipient_id = recipient.user_id
ORDER BY m.sent_at;
```

---

## Data Characteristics

### Realistic Relationships
- ✅ All foreign key relationships properly maintained
- ✅ Guests only review properties they've booked
- ✅ Payments only exist for confirmed bookings
- ✅ Messages occur between actual users in the system
- ✅ Properties owned by users with 'host' role

### Data Validation
- ✅ Email addresses are unique
- ✅ Booking end dates are after start dates
- ✅ Review ratings are between 1 and 5
- ✅ Payment amounts are non-negative
- ✅ Message senders and recipients are different users

### Temporal Consistency
- ✅ Reviews posted after booking completion
- ✅ Payments made when bookings are created
- ✅ Messages sent before and during booking periods
- ✅ Property updates tracked with timestamps

---

## Resetting Data

To clear all data and re-seed:

```bash
# Simply re-run the seed script
mysql -u your_username -p airbnb_db < seed.sql
```

The script includes `TRUNCATE` statements that safely clear existing data before inserting new records.

**Note:** Foreign key checks are temporarily disabled during seeding to allow smooth data insertion.

---

## Extending the Dataset

To add more sample data:

1. **Generate UUIDs:** Use MySQL's `UUID()` function or generate them externally
2. **Maintain Relationships:** Ensure foreign key references are valid
3. **Follow Patterns:** Use existing data as templates for consistency
4. **Validate Constraints:** Respect CHECK constraints and ENUM values

### Example: Adding a New User
```sql
INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at)
VALUES (UUID(), 'Jane', 'Doe', 'jane.doe@email.com', '$2a$12$...', '+1-555-9999', 'guest', NOW());
```

### Example: Adding a New Property
```sql
INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at)
VALUES (UUID(), 'existing-host-uuid', 'Beach House', 'Beautiful oceanfront property', 'Malibu, CA', 399.00, NOW(), NOW());
```

---

## Testing Scenarios

This dataset supports testing of:

- **User Management:** Multiple user roles and authentication
- **Property Listings:** Search, filter, and display properties
- **Booking Flow:** Create, confirm, and cancel bookings
- **Payment Processing:** Handle different payment methods
- **Review System:** Rating and feedback mechanisms
- **Messaging:** User-to-user communication
- **Analytics:** Revenue reports, occupancy rates, popular properties
- **Relationships:** Complex JOIN queries across multiple tables

---

## Notes

- **UUIDs:** All primary keys use UUID format (36 characters with hyphens)
- **Passwords:** Hash values are placeholders; in production, use proper hashing (bcrypt, argon2)
- **Dates:** Sample data uses dates from 2024-2025 for relevance
- **Cascading Deletes:** Schema supports `ON DELETE CASCADE` for related records
- **Real-world Usage:** Data patterns reflect actual AirBnB-style usage

---

## Troubleshooting

### Error: Cannot add or update a child row
**Solution:** Ensure the schema is created first and all foreign key references exist.

### Error: Duplicate entry for key 'email'
**Solution:** Clear existing data or modify email addresses to be unique.

### Error: Data too long for column
**Solution:** Check that VARCHAR lengths in schema match the seed data.

### Error: Incorrect datetime value
**Solution:** Verify your MySQL server's timezone and datetime format settings.

---

## Contributing

When adding new seed data:
1. Follow the existing UUID format
2. Maintain referential integrity
3. Use realistic, professional sample data
4. Add verification queries to test new data
5. Update this README with new data statistics

---

**Last Updated:** October 26, 2025
