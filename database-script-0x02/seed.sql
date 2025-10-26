-- ================================================
-- AirBnB Database - Sample Data Seeding Script
-- ================================================
-- This script populates the database with realistic sample data
-- for testing and development purposes
-- ================================================

-- Disable foreign key checks temporarily for easier insertion
SET FOREIGN_KEY_CHECKS = 0;

-- Clear existing data (in reverse order of dependencies)
TRUNCATE TABLE Message;
TRUNCATE TABLE Review;
TRUNCATE TABLE Payment;
TRUNCATE TABLE Booking;
TRUNCATE TABLE Property;
TRUNCATE TABLE User;

-- Re-enable foreign key checks
SET FOREIGN_KEY_CHECKS = 1;

-- ================================================
-- Insert Users
-- ================================================
-- Mix of guests, hosts, and admins with realistic data
-- Password hashes are placeholder values (in production, use bcrypt/argon2)

INSERT INTO User (user_id, first_name, last_name, email, password_hash, phone_number, role, created_at) VALUES
-- Admins
('550e8400-e29b-41d4-a716-446655440000', 'Alice', 'Admin', 'alice.admin@airbnb.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0100', 'admin', '2024-01-15 10:00:00'),

-- Hosts
('550e8400-e29b-41d4-a716-446655440001', 'John', 'Smith', 'john.smith@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0101', 'host', '2024-02-01 08:30:00'),
('550e8400-e29b-41d4-a716-446655440002', 'Sarah', 'Johnson', 'sarah.j@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0102', 'host', '2024-02-10 14:20:00'),
('550e8400-e29b-41d4-a716-446655440003', 'Michael', 'Chen', 'michael.chen@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0103', 'host', '2024-03-05 09:15:00'),
('550e8400-e29b-41d4-a716-446655440004', 'Emma', 'Davis', 'emma.davis@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0104', 'host', '2024-03-12 16:45:00'),
('550e8400-e29b-41d4-a716-446655440005', 'David', 'Martinez', 'david.m@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0105', 'host', '2024-04-01 11:30:00'),

-- Guests
('550e8400-e29b-41d4-a716-446655440006', 'Jessica', 'Taylor', 'jessica.t@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0106', 'guest', '2024-05-10 13:20:00'),
('550e8400-e29b-41d4-a716-446655440007', 'Robert', 'Brown', 'robert.brown@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0107', 'guest', '2024-05-15 10:00:00'),
('550e8400-e29b-41d4-a716-446655440008', 'Linda', 'Wilson', 'linda.wilson@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0108', 'guest', '2024-06-01 15:30:00'),
('550e8400-e29b-41d4-a716-446655440009', 'James', 'Anderson', 'james.a@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0109', 'guest', '2024-06-10 09:45:00'),
('550e8400-e29b-41d4-a716-446655440010', 'Maria', 'Garcia', 'maria.garcia@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0110', 'guest', '2024-07-05 12:00:00'),
('550e8400-e29b-41d4-a716-446655440011', 'William', 'Lee', 'william.lee@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', NULL, 'guest', '2024-07-20 14:30:00'),
('550e8400-e29b-41d4-a716-446655440012', 'Patricia', 'White', 'patricia.w@email.com', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyYIr4Yn5pKe', '+1-555-0112', 'guest', '2024-08-01 08:15:00');

-- ================================================
-- Insert Properties
-- ================================================
-- Diverse property listings across different locations and price points

INSERT INTO Property (property_id, host_id, name, description, location, pricepernight, created_at, updated_at) VALUES
-- John Smith's properties
('660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'Cozy Downtown Loft', 'Modern loft in the heart of downtown with stunning city views. Perfect for business travelers and couples. Features high-speed WiFi, fully equipped kitchen, and workspace.', 'New York, NY', 189.99, '2024-02-05 10:00:00', '2024-09-15 14:20:00'),
('660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', 'Spacious Family Home', 'Beautiful 4-bedroom house with large backyard and pool. Great for families! Located in a quiet neighborhood with easy access to schools and parks.', 'Austin, TX', 275.00, '2024-03-10 11:30:00', '2024-10-01 09:00:00'),

-- Sarah Johnson's properties
('660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440002', 'Beachfront Paradise', 'Wake up to ocean waves! Luxurious beachfront condo with private balcony, 2 bedrooms, and resort-style amenities including pool and gym.', 'Miami, FL', 320.50, '2024-02-15 13:45:00', '2024-09-20 16:30:00'),
('660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440002', 'Mountain Cabin Retreat', 'Escape to nature in this charming cabin. Features fireplace, hot tub, and panoramic mountain views. Perfect for romantic getaways or family adventures.', 'Denver, CO', 195.00, '2024-04-01 15:00:00', '2024-10-10 11:15:00'),

-- Michael Chen's properties
('660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440003', 'Urban Studio Apartment', 'Minimalist studio perfect for solo travelers. Walking distance to metro, restaurants, and entertainment. Smart home features and high-speed internet.', 'San Francisco, CA', 145.00, '2024-03-15 09:20:00', '2024-09-25 10:00:00'),
('660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440003', 'Luxury Penthouse Suite', 'Top-floor penthouse with 360-degree city views. 3 bedrooms, 3 baths, chef\'s kitchen, and private terrace. Premium amenities and concierge service.', 'Chicago, IL', 450.00, '2024-04-20 14:30:00', '2024-10-15 13:45:00'),

-- Emma Davis's properties
('660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440004', 'Historic Brownstone', 'Charming renovated brownstone in historic district. Original details preserved with modern updates. 2 bedrooms, office space, and garden.', 'Boston, MA', 210.00, '2024-03-20 10:15:00', '2024-09-30 12:00:00'),
('660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440004', 'Lakeside Cottage', 'Peaceful cottage on private lake. Kayaks and fishing equipment included. Perfect for nature lovers seeking tranquility. Pet-friendly!', 'Seattle, WA', 165.00, '2024-05-10 12:00:00', '2024-10-05 15:30:00'),

-- David Martinez's properties
('660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440005', 'Desert Oasis Villa', 'Southwestern-style villa with pool and mountain views. 3 bedrooms, outdoor kitchen, and fire pit. Resort living in a private setting.', 'Phoenix, AZ', 235.00, '2024-04-05 11:45:00', '2024-10-12 14:00:00'),
('660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440005', 'Downtown Condo', 'Sleek 1-bedroom condo in vibrant downtown area. Walk to restaurants, shops, and nightlife. Building amenities include gym and rooftop lounge.', 'Portland, OR', 155.00, '2024-05-01 13:30:00', '2024-10-08 11:20:00');

-- ================================================
-- Insert Bookings
-- ================================================
-- Mix of confirmed, pending, and canceled bookings

INSERT INTO Booking (booking_id, property_id, user_id, start_date, end_date, total_price, status, created_at) VALUES
-- Confirmed bookings
('770e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '2024-10-15', '2024-10-18', 569.97, 'confirmed', '2024-09-20 14:30:00'),
('770e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', '2024-11-01', '2024-11-07', 1923.00, 'confirmed', '2024-10-01 10:15:00'),
('770e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', '2024-10-20', '2024-10-23', 435.00, 'confirmed', '2024-09-25 11:45:00'),
('770e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', '2024-11-10', '2024-11-14', 840.00, 'confirmed', '2024-10-05 09:20:00'),
('770e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', '2024-12-20', '2024-12-27', 1925.00, 'confirmed', '2024-10-15 13:00:00'),
('770e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', '2024-11-15', '2024-11-18', 585.00, 'confirmed', '2024-10-10 15:30:00'),
('770e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440012', '2024-10-25', '2024-10-28', 1350.00, 'confirmed', '2024-09-28 12:45:00'),
('770e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440006', '2024-11-20', '2024-11-25', 825.00, 'confirmed', '2024-10-18 14:00:00'),
('770e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440007', '2024-12-01', '2024-12-05', 940.00, 'confirmed', '2024-11-01 10:30:00'),
('770e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', '2024-11-05', '2024-11-08', 465.00, 'confirmed', '2024-10-12 16:20:00'),

-- Pending bookings
('770e8400-e29b-41d4-a716-446655440011', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440009', '2025-01-15', '2025-01-20', 949.95, 'pending', '2024-10-22 11:00:00'),
('770e8400-e29b-41d4-a716-446655440012', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440010', '2025-02-01', '2025-02-10', 2884.50, 'pending', '2024-10-23 13:30:00'),
('770e8400-e29b-41d4-a716-446655440013', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440011', '2025-01-10', '2025-01-12', 290.00, 'pending', '2024-10-24 09:15:00'),

-- Canceled bookings
('770e8400-e29b-41d4-a716-446655440014', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440012', '2024-10-28', '2024-11-02', 1375.00, 'canceled', '2024-09-15 10:00:00'),
('770e8400-e29b-41d4-a716-446655440015', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440006', '2024-10-30', '2024-11-05', 1170.00, 'canceled', '2024-09-18 14:20:00');

-- ================================================
-- Insert Payments
-- ================================================
-- Payments only for confirmed bookings (1:1 relationship)

INSERT INTO Payment (payment_id, booking_id, amount, payment_date, payment_method) VALUES
('880e8400-e29b-41d4-a716-446655440001', '770e8400-e29b-41d4-a716-446655440001', 569.97, '2024-09-20 14:35:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440002', '770e8400-e29b-41d4-a716-446655440002', 1923.00, '2024-10-01 10:20:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440003', '770e8400-e29b-41d4-a716-446655440003', 435.00, '2024-09-25 11:50:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440004', '770e8400-e29b-41d4-a716-446655440004', 840.00, '2024-10-05 09:25:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440005', '770e8400-e29b-41d4-a716-446655440005', 1925.00, '2024-10-15 13:05:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440006', '770e8400-e29b-41d4-a716-446655440006', 585.00, '2024-10-10 15:35:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440007', '770e8400-e29b-41d4-a716-446655440007', 1350.00, '2024-09-28 12:50:00', 'stripe'),
('880e8400-e29b-41d4-a716-446655440008', '770e8400-e29b-41d4-a716-446655440008', 825.00, '2024-10-18 14:05:00', 'credit_card'),
('880e8400-e29b-41d4-a716-446655440009', '770e8400-e29b-41d4-a716-446655440009', 940.00, '2024-11-01 10:35:00', 'paypal'),
('880e8400-e29b-41d4-a716-446655440010', '770e8400-e29b-41d4-a716-446655440010', 465.00, '2024-10-12 16:25:00', 'stripe');

-- ================================================
-- Insert Reviews
-- ================================================
-- Reviews from guests for properties they've booked

INSERT INTO Review (review_id, property_id, user_id, rating, comment, created_at) VALUES
-- Reviews for confirmed completed bookings
('990e8400-e29b-41d4-a716-446655440001', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 5, 'Amazing location and beautiful loft! John was an excellent host, very responsive and accommodating. The space was exactly as described and perfect for our city getaway. Would definitely stay again!', '2024-10-19 15:30:00'),

('990e8400-e29b-41d4-a716-446655440002', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440007', 5, 'Absolutely stunning beachfront property! Waking up to the ocean view was incredible. The condo was spotless, well-equipped, and Sarah provided excellent recommendations for local restaurants. Perfect vacation!', '2024-11-08 10:20:00'),

('990e8400-e29b-41d4-a716-446655440003', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440008', 4, 'Great studio in a fantastic location. Very clean and modern. Only minor issue was some street noise at night, but overall a wonderful stay. Michael was quick to respond to all questions.', '2024-10-24 12:45:00'),

('990e8400-e29b-41d4-a716-446655440004', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440009', 5, 'The brownstone exceeded our expectations! Beautiful historic charm with all modern conveniences. Emma was a wonderful host and the neighborhood was lovely. Highly recommend!', '2024-11-15 14:00:00'),

('990e8400-e29b-41d4-a716-446655440005', '660e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440010', 5, 'Perfect family home for our holiday stay! The kids loved the pool and the house had everything we needed. Very spacious and comfortable. John was great to work with. Thank you!', '2024-12-28 11:30:00'),

('990e8400-e29b-41d4-a716-446655440006', '660e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440011', 5, 'Mountain cabin was absolutely magical! Hot tub under the stars, cozy fireplace, and breathtaking views. Sarah thought of everything. This is our new favorite getaway spot!', '2024-11-19 16:20:00'),

('990e8400-e29b-41d4-a716-446655440007', '660e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440012', 4, 'Luxury penthouse with amazing views! The space is gorgeous and the amenities are top-notch. Only gave 4 stars because the building elevator was under maintenance during our stay, but Michael was very apologetic and offered a discount.', '2024-10-29 13:15:00'),

('990e8400-e29b-41d4-a716-446655440008', '660e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440006', 5, 'Peaceful lakeside retreat! We loved kayaking and fishing. The cottage is charming and well-maintained. Emma allowed us to bring our dog which was wonderful. Highly recommend for nature lovers!', '2024-11-26 09:45:00'),

('990e8400-e29b-41d4-a716-446655440009', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440007', 4, 'Beautiful desert villa with stunning mountain views. Pool was fantastic! David was helpful and responsive. The outdoor kitchen was perfect for evening BBQs. Great stay overall!', '2024-12-06 14:30:00'),

('990e8400-e29b-41d4-a716-446655440010', '660e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440008', 4, 'Convenient downtown location with easy access to everything. Condo was clean and modern. Building gym was a nice bonus. Would have been 5 stars but parking was a bit challenging. Overall good value!', '2024-11-09 11:00:00'),

-- Additional reviews from different users
('990e8400-e29b-41d4-a716-446655440011', '660e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440007', 5, 'Stayed here for a business trip and it was perfect. Great WiFi, comfortable workspace, and walking distance to everything. Highly recommend for business travelers!', '2024-09-10 10:15:00'),

('990e8400-e29b-41d4-a716-446655440012', '660e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440009', 5, 'Dream beachfront vacation! Everything was perfect from check-in to check-out. Can\'t wait to return!', '2024-08-15 16:40:00'),

('990e8400-e29b-41d4-a716-446655440013', '660e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440012', 3, 'Decent studio for the price. Location is excellent but the space is quite small for two people. Good for solo travelers.', '2024-07-20 13:25:00'),

('990e8400-e29b-41d4-a716-446655440014', '660e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440010', 5, 'Fell in love with this brownstone! The historic details are beautiful and Emma is a fantastic host. Boston at its best!', '2024-09-05 12:00:00'),

('990e8400-e29b-41d4-a716-446655440015', '660e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440011', 4, 'Great villa for a winter escape to the desert. Pool was heated which was nice. Outdoor space is amazing. David provided great local tips!', '2024-08-25 15:50:00');

-- ================================================
-- Insert Messages
-- ================================================
-- Realistic message conversations between guests and hosts

INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES
-- Conversation: Jessica (guest) and John (host) about Downtown Loft
('aa0e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! I\'m interested in booking your downtown loft for October 15-18. Is it available? Also, is there parking available?', '2024-09-15 09:30:00'),
('aa0e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Hi Jessica! Yes, the loft is available for those dates. There\'s a parking garage one block away with guest parking for $20/day. Would you like me to send you the details?', '2024-09-15 10:15:00'),
('aa0e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440001', 'Perfect! Yes please send the parking info. I\'ll go ahead and book now. What\'s the check-in process?', '2024-09-15 10:45:00'),
('aa0e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440006', 'Great! Check-in is at 3 PM. I\'ll send you the door code the day before your arrival. Looking forward to hosting you!', '2024-09-15 11:00:00'),

-- Conversation: Robert (guest) and Sarah (host) about Beachfront Paradise
('aa0e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'Hi Sarah, your beachfront condo looks amazing! Quick question - are beach chairs and umbrellas provided?', '2024-09-28 14:20:00'),
('aa0e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Hi Robert! Thank you! Yes, we provide 4 beach chairs, 2 umbrellas, and beach towels. There\'s also a cooler in the closet you\'re welcome to use!', '2024-09-28 15:00:00'),
('aa0e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440007', '550e8400-e29b-41d4-a716-446655440002', 'That\'s perfect! Just booked for November 1-7. Can\'t wait! Any restaurant recommendations?', '2024-09-28 15:30:00'),
('aa0e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440007', 'Wonderful! I\'ll send you my full list of favorite spots. For seafood, you MUST try Ocean Grill - it\'s a 5 minute walk. Enjoy your stay!', '2024-09-28 16:00:00'),

-- Conversation: Linda (guest) and Michael (host) about Urban Studio
('aa0e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'Hi Michael! Is there a washer/dryer in the studio? I\'m staying for 3 nights and would love to do laundry.', '2024-09-20 11:00:00'),
('aa0e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Hi Linda! There\'s a shared laundry room on the ground floor of the building. It takes quarters. There\'s also a laundromat 2 blocks away if you prefer.', '2024-09-20 11:30:00'),
('aa0e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440008', '550e8400-e29b-41d4-a716-446655440003', 'The shared laundry works for me! Thank you. Also, is early check-in possible? My flight arrives at 11 AM.', '2024-09-20 12:00:00'),
('aa0e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440008', 'Let me check with the previous guest. If they check out on time, I can have it ready by noon. I\'ll confirm the day before!', '2024-09-20 12:30:00'),

-- Conversation: James (guest) and Emma (host) about Historic Brownstone
('aa0e8400-e29b-41d4-a716-446655440013', '550e8400-e29b-41d4-a716-446655440009', '550e8400-e29b-41d4-a716-446655440004', 'Emma, we just checked in and WOW! This place is stunning. Thank you for the welcome basket - that was so thoughtful!', '2024-11-10 16:30:00'),
('aa0e8400-e29b-41d4-a716-446655440014', '550e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440009', 'I\'m so glad you like it! You\'re very welcome. Let me know if you need anything during your stay. Enjoy Boston!', '2024-11-10 17:00:00'),

-- Conversation: Maria (guest) and John (host) about Family Home
('aa0e8400-e29b-41d4-a716-446655440015', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'Hi John! We\'re bringing our 3 kids for Christmas week. Is the pool heated? Also, is there a crib available?', '2024-10-10 13:45:00'),
('aa0e8400-e29b-41d4-a716-446655440016', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Hi Maria! Yes, the pool is heated year-round. I have a pack-n-play crib I can set up for you. How old is your youngest?', '2024-10-10 14:15:00'),
('aa0e8400-e29b-41d4-a716-446655440017', '550e8400-e29b-41d4-a716-446655440010', '550e8400-e29b-41d4-a716-446655440001', 'She just turned 18 months. The pack-n-play would be perfect! This is going to be such a great family Christmas. Thank you!', '2024-10-10 14:45:00'),
('aa0e8400-e29b-41d4-a716-446655440018', '550e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440010', 'Wonderful! I\'ll have it all set up before you arrive. There are also some kids toys in the garage you\'re welcome to use. Have a great trip!', '2024-10-10 15:00:00'),

-- Conversation: William (guest) and Sarah (host) about Mountain Cabin
('aa0e8400-e29b-41d4-a716-446655440019', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440002', 'Sarah, quick question about the cabin - how\'s the road access in winter? We\'re planning to visit in November.', '2024-10-05 10:20:00'),
('aa0e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440002', '550e8400-e29b-41d4-a716-446655440011', 'Hi William! November should be fine - the road is paved and maintained. If there\'s snow, I recommend an SUV or 4WD. I always check the forecast and will let you know if there are any concerns!', '2024-10-05 11:00:00'),

-- Conversation: Patricia (guest) and Michael (host) about Luxury Penthouse
('aa0e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'Hi Michael, I\'m celebrating my anniversary at your penthouse. Is it possible to arrange flowers or champagne for arrival?', '2024-09-25 15:30:00'),
('aa0e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'Hi Patricia! Happy anniversary! I\'d be delighted to help. I can arrange a bouquet and champagne for an additional $75. Would you like me to set that up?', '2024-09-25 16:00:00'),
('aa0e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440003', 'That would be perfect! Yes please! You can add it to my booking total. Thank you so much!', '2024-09-25 16:15:00'),
('aa0e8400-e29b-41d4-a716-446655440024', '550e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440012', 'All set! The flowers will be on the dining table and champagne chilled in the fridge. Congratulations and enjoy your celebration!', '2024-09-25 16:30:00');

-- ================================================
-- Verification Queries
-- ================================================
-- Uncomment these to verify the data was inserted correctly

-- SELECT COUNT(*) as total_users FROM User;
-- SELECT COUNT(*) as total_properties FROM Property;
-- SELECT COUNT(*) as total_bookings FROM Booking;
-- SELECT COUNT(*) as total_payments FROM Payment;
-- SELECT COUNT(*) as total_reviews FROM Review;
-- SELECT COUNT(*) as total_messages FROM Message;

-- SELECT role, COUNT(*) as count FROM User GROUP BY role;
-- SELECT status, COUNT(*) as count FROM Booking GROUP BY status;
-- SELECT payment_method, COUNT(*) as count FROM Payment GROUP BY payment_method;
-- SELECT rating, COUNT(*) as count FROM Review GROUP BY rating;

-- ================================================
-- End of Seed Data Script
-- ================================================
