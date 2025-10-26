# Database Normalization Review - AirBnB Database

## Objective
Apply normalization principles to ensure the database is in Third Normal Form (3NF).

---

## Table of Contents
1. [Normalization Overview](#normalization-overview)
2. [Current Schema Analysis](#current-schema-analysis)
3. [First Normal Form (1NF) Review](#first-normal-form-1nf-review)
4. [Second Normal Form (2NF) Review](#second-normal-form-2nf-review)
5. [Third Normal Form (3NF) Review](#third-normal-form-3nf-review)
6. [Identified Issues and Solutions](#identified-issues-and-solutions)
7. [Final Normalized Schema](#final-normalized-schema)
8. [Summary of Changes](#summary-of-changes)

---

## Normalization Overview

### What is Database Normalization?
Database normalization is the process of organizing data to reduce redundancy and improve data integrity. The main goals are:
- Eliminate redundant data
- Ensure data dependencies make sense
- Minimize data anomalies (insertion, update, deletion)

### Normal Forms
- **1NF (First Normal Form)**: Eliminate repeating groups and ensure atomic values
- **2NF (Second Normal Form)**: 1NF + eliminate partial dependencies on composite keys
- **3NF (Third Normal Form)**: 2NF + eliminate transitive dependencies

---

## Current Schema Analysis

### Existing Tables
1. **User** - Stores user information (guests, hosts, admins)
2. **Property** - Stores property listings
3. **Booking** - Stores booking transactions
4. **Payment** - Stores payment information
5. **Review** - Stores property reviews
6. **Message** - Stores user-to-user messages

---

## First Normal Form (1NF) Review

### Requirements for 1NF:
✅ Each column contains atomic (indivisible) values
✅ Each column contains values of a single type
✅ Each column has a unique name
✅ The order in which data is stored does not matter

### Analysis:

#### ✅ User Table
- All attributes are atomic
- No repeating groups
- **Status: Complies with 1NF**

#### ✅ Property Table
- All attributes are atomic
- Single-valued attributes only
- **Status: Complies with 1NF**

#### ✅ Booking Table
- All attributes are atomic
- Dates and amounts are single values
- **Status: Complies with 1NF**

#### ✅ Payment Table
- All attributes are atomic
- No multi-valued attributes
- **Status: Complies with 1NF**

#### ✅ Review Table
- All attributes are atomic
- Rating is a single integer value
- **Status: Complies with 1NF**

#### ✅ Message Table
- All attributes are atomic
- Message body is a single text value
- **Status: Complies with 1NF**

**Conclusion**: All tables comply with First Normal Form (1NF).

---

## Second Normal Form (2NF) Review

### Requirements for 2NF:
✅ Must be in 1NF
✅ All non-key attributes must be fully dependent on the entire primary key (no partial dependencies)

**Note**: Partial dependencies only occur when there is a composite primary key.

### Analysis:

#### ✅ User Table
- **Primary Key**: `user_id` (single column)
- All attributes depend on `user_id`
- **Status: Complies with 2NF** (no composite key, so no partial dependencies possible)

#### ✅ Property Table
- **Primary Key**: `property_id` (single column)
- All attributes depend on `property_id`
- **Status: Complies with 2NF**

#### ✅ Booking Table
- **Primary Key**: `booking_id` (single column)
- All attributes depend on `booking_id`
- **Status: Complies with 2NF**

#### ✅ Payment Table
- **Primary Key**: `payment_id` (single column)
- All attributes depend on `payment_id`
- **Status: Complies with 2NF**

#### ✅ Review Table
- **Primary Key**: `review_id` (single column)
- All attributes depend on `review_id`
- **Status: Complies with 2NF**

#### ✅ Message Table
- **Primary Key**: `message_id` (single column)
- All attributes depend on `message_id`
- **Status: Complies with 2NF**

**Conclusion**: All tables comply with Second Normal Form (2NF) as they use single-column primary keys.

---

## Third Normal Form (3NF) Review

### Requirements for 3NF:
✅ Must be in 2NF
✅ No transitive dependencies (non-key attributes should not depend on other non-key attributes)

### Analysis:

#### ✅ User Table
**Attributes**: user_id, first_name, last_name, email, password_hash, phone_number, role, created_at

**Dependencies**:
- first_name → user_id ✅
- last_name → user_id ✅
- email → user_id ✅
- password_hash → user_id ✅
- phone_number → user_id ✅
- role → user_id ✅
- created_at → user_id ✅

**No transitive dependencies detected.**
**Status: Complies with 3NF**

---

#### ⚠️ Property Table
**Attributes**: property_id, host_id, name, description, location, pricepernight, created_at, updated_at

**Dependencies**:
- All attributes depend directly on `property_id` ✅

**Potential Issue**: The `location` field stored as a single VARCHAR may contain composite information (e.g., "123 Main St, New York, NY, 10001").

**Recommendation**: Consider normalizing location into a separate `Location` table if location details need to be queried independently:
- country
- state/province
- city
- postal_code
- street_address

However, for the current use case (simple location string for display), this is acceptable and maintains 3NF as long as location is treated as an atomic value.

**Status: Complies with 3NF** (with recommendation for future enhancement)

---

#### ⚠️ Booking Table
**Attributes**: booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at

**Dependencies Analysis**:
- property_id → booking_id ✅
- user_id → booking_id ✅
- start_date → booking_id ✅
- end_date → booking_id ✅
- status → booking_id ✅
- created_at → booking_id ✅
- **total_price** → booking_id

**Potential Issue**: `total_price` can be calculated from:
- Property.pricepernight
- (end_date - start_date) = number of nights
- Formula: total_price = pricepernight × number_of_nights

This creates a **transitive dependency**: total_price depends on property_id (via pricepernight), which is a non-key attribute.

**However**, storing `total_price` is justified because:
1. Property prices may change over time
2. Historical bookings need to preserve the original price
3. Discounts or special pricing may apply
4. It serves as a denormalized field for business reasons (audit trail)

**Decision**: Keep `total_price` for historical accuracy and business logic.
**Status: Complies with 3NF** (justified denormalization for historical data)

---

#### ✅ Payment Table
**Attributes**: payment_id, booking_id, amount, payment_date, payment_method

**Dependencies**:
- booking_id → payment_id ✅
- amount → payment_id ✅
- payment_date → payment_id ✅
- payment_method → payment_id ✅

**Potential Issue**: The `amount` field could theoretically be derived from `Booking.total_price`, creating a transitive dependency.

**Analysis**: Similar to the Booking table, `amount` should be stored because:
1. Payments may be partial
2. Refunds may occur
3. Payment amount may differ from booking total (fees, taxes, discounts)
4. Historical accuracy is critical for financial records

**Status: Complies with 3NF** (justified denormalization for financial integrity)

---

#### ✅ Review Table
**Attributes**: review_id, property_id, user_id, rating, comment, created_at

**Dependencies**:
- property_id → review_id ✅
- user_id → review_id ✅
- rating → review_id ✅
- comment → review_id ✅
- created_at → review_id ✅

**No transitive dependencies detected.**
**Status: Complies with 3NF**

---

#### ✅ Message Table
**Attributes**: message_id, sender_id, recipient_id, message_body, sent_at

**Dependencies**:
- sender_id → message_id ✅
- recipient_id → message_id ✅
- message_body → message_id ✅
- sent_at → message_id ✅

**No transitive dependencies detected.**
**Status: Complies with 3NF**

---

## Identified Issues and Solutions

### Issue 1: Property Location Field (Minor Enhancement)
**Current State**: Location stored as single VARCHAR
**Potential Issue**: May contain composite data (street, city, state, zip)
**Impact**: Low - does not violate 3NF if treated as atomic
**Recommendation**: Consider future normalization into Location table if complex queries needed

**Proposed Enhancement** (Optional):
```sql
CREATE TABLE Location (
    location_id UUID PRIMARY KEY,
    street_address VARCHAR,
    city VARCHAR NOT NULL,
    state_province VARCHAR,
    country VARCHAR NOT NULL,
    postal_code VARCHAR,
    latitude DECIMAL(10, 8),
    longitude DECIMAL(11, 8),
    INDEX idx_city (city),
    INDEX idx_country (country)
);

-- Modify Property table
ALTER TABLE Property 
    ADD COLUMN location_id UUID,
    ADD FOREIGN KEY (location_id) REFERENCES Location(location_id),
    DROP COLUMN location;
```

**Decision**: ✅ Keep current design for simplicity. Current schema complies with 3NF.

---

### Issue 2: Calculated Fields (Justified Denormalization)
**Fields Identified**:
- `Booking.total_price` (could be calculated from pricepernight × nights)
- `Payment.amount` (could reference Booking.total_price)

**Analysis**:
These fields appear to violate 3NF but are **intentionally denormalized** for:
- **Historical accuracy**: Prices change over time
- **Business logic**: Discounts, taxes, partial payments
- **Performance**: Avoid complex calculations on every query
- **Data integrity**: Immutable financial records

**Decision**: ✅ Keep both fields. This is a justified trade-off between normalization and practical business requirements.

---

### Issue 3: User Role Field (Acceptable)
**Current State**: role ENUM (guest, host, admin)
**Potential Concern**: User can have multiple roles simultaneously

**Analysis**:
- Current design assumes one role per user
- In reality, a user could be both guest and host
- However, this is handled at the application level, not database level
- The role field indicates the primary role or account type

**Alternative Approach** (if multiple roles needed):
```sql
CREATE TABLE Role (
    role_id UUID PRIMARY KEY,
    role_name VARCHAR UNIQUE NOT NULL
);

CREATE TABLE UserRole (
    user_id UUID,
    role_id UUID,
    assigned_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);
```

**Decision**: ✅ Keep current design. Single role per user is sufficient for this use case.

---

## Final Normalized Schema

### Summary of Normalization Compliance

| Table | 1NF | 2NF | 3NF | Notes |
|-------|-----|-----|-----|-------|
| User | ✅ | ✅ | ✅ | Fully normalized |
| Property | ✅ | ✅ | ✅ | Fully normalized |
| Booking | ✅ | ✅ | ✅ | total_price is justified denormalization |
| Payment | ✅ | ✅ | ✅ | amount is justified denormalization |
| Review | ✅ | ✅ | ✅ | Fully normalized |
| Message | ✅ | ✅ | ✅ | Fully normalized |

### Normalization Status: ✅ **All tables comply with 3NF**

---

## Final Schema (No Changes Required)

The current database schema **already complies with Third Normal Form (3NF)**. No structural changes are necessary.

### User Table
```sql
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR NOT NULL,
    last_name VARCHAR NOT NULL,
    email VARCHAR UNIQUE NOT NULL,
    password_hash VARCHAR NOT NULL,
    phone_number VARCHAR NULL,
    role ENUM('guest', 'host', 'admin') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_email (email)
);
```

### Property Table
```sql
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    host_id UUID NOT NULL,
    name VARCHAR NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR NOT NULL,
    pricepernight DECIMAL NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id),
    INDEX idx_host_id (host_id)
);
```

### Booking Table
```sql
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL NOT NULL,
    status ENUM('pending', 'confirmed', 'canceled') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id)
);
```

### Payment Table
```sql
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    payment_method ENUM('credit_card', 'paypal', 'stripe') NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    INDEX idx_booking_id (booking_id)
);
```

### Review Table
```sql
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id)
);
```

### Message Table
```sql
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id),
    INDEX idx_sender_id (sender_id),
    INDEX idx_recipient_id (recipient_id)
);
```

---

## Summary of Changes

### Changes Made: **NONE**

The current database schema is already in **Third Normal Form (3NF)**.

### Normalization Analysis Results:

1. ✅ **First Normal Form (1NF)**: All tables have atomic values, no repeating groups
2. ✅ **Second Normal Form (2NF)**: All non-key attributes fully depend on primary keys (no partial dependencies)
3. ✅ **Third Normal Form (3NF)**: No transitive dependencies (except justified denormalizations)

### Justified Denormalizations:

The following fields are intentionally denormalized for business and performance reasons:

1. **Booking.total_price**: Preserves historical pricing data
2. **Payment.amount**: Maintains financial record integrity

These denormalizations are **acceptable and recommended** in production systems for:
- Historical data accuracy
- Audit trail compliance
- Query performance optimization
- Business logic requirements (discounts, taxes, fees)

### Recommendations for Future Enhancements:

1. **Location Normalization** (Optional):
   - Consider extracting location details into a separate table if complex location-based queries are needed
   - Add geographical coordinates for mapping features

2. **User Roles** (Optional):
   - If users need multiple roles simultaneously, implement a UserRole junction table
   - Current single-role design is sufficient for most use cases

3. **Additional Indexes** (Performance):
   - Add composite indexes based on common query patterns
   - Example: `INDEX idx_booking_dates (start_date, end_date)` for availability queries

4. **Audit Tables** (Compliance):
   - Consider adding audit trails for critical operations
   - Track changes to bookings, payments, and property details

---

## Conclusion

The AirBnB database schema **successfully achieves Third Normal Form (3NF)** and requires no structural modifications. The design effectively:

✅ Eliminates data redundancy  
✅ Prevents update anomalies  
✅ Maintains data integrity through foreign keys  
✅ Uses appropriate denormalization where justified  
✅ Supports efficient querying through proper indexing  

The schema is **production-ready** and follows database design best practices.

---

**Document Version**: 1.0  
**Date**: October 26, 2025  
**Status**: ✅ Schema Normalized to 3NF
