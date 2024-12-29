-- Create Database
CREATE DATABASE airline_reservation;
USE airline_reservation;

-- Users Table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(15),
    gender ENUM('Male', 'Female', 'Other'),
    date_of_birth DATE,
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Admin Table
CREATE TABLE admin (
    admin_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Flights Table
CREATE TABLE flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) UNIQUE NOT NULL,
    departure_city VARCHAR(100) NOT NULL,
    arrival_city VARCHAR(100) NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    duration TIME NOT NULL,
    economy_price DECIMAL(10, 2) NOT NULL,
    business_price DECIMAL(10, 2) NOT NULL,
    total_seats INT NOT NULL,
    available_seats INT NOT NULL,
    status ENUM('Scheduled', 'Delayed', 'Cancelled') DEFAULT 'Scheduled',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Passengers Table
CREATE TABLE passengers (
    passenger_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(15) NOT NULL,
    gender ENUM('Male', 'Female', 'Other') NOT NULL,
    date_of_birth DATE NOT NULL,
    aadhar_number VARCHAR(12) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Bookings Table
CREATE TABLE bookings (
    booking_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    flight_id INT,
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_passengers INT NOT NULL,
    class_type ENUM('Economy', 'Business') NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    status ENUM('Pending', 'Confirmed', 'Cancelled') DEFAULT 'Pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (flight_id) REFERENCES flights(flight_id) ON DELETE SET NULL
);

-- Tickets Table
CREATE TABLE tickets (
    ticket_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    passenger_id INT,
    pnr_number VARCHAR(10) UNIQUE NOT NULL,
    seat_number VARCHAR(5) NOT NULL,
    status ENUM('Active', 'Cancelled') DEFAULT 'Active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL,
    FOREIGN KEY (passenger_id) REFERENCES passengers(passenger_id) ON DELETE SET NULL
);

-- Payments Table
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method ENUM('Card', 'UPI') NOT NULL,
    transaction_id VARCHAR(100) UNIQUE NOT NULL,
    status ENUM('Pending', 'Success', 'Failed') DEFAULT 'Pending',
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id) ON DELETE SET NULL
);

-- Insert Default Admin
INSERT INTO admin (username, password, email) 
VALUES ('admin', 'admin123', 'admin@skywings.com');

-- Insert Sample Cities
CREATE TABLE cities (
    city_id INT PRIMARY KEY AUTO_INCREMENT,
    city_name VARCHAR(100) NOT NULL,
    airport_code VARCHAR(3) NOT NULL UNIQUE
);

INSERT INTO cities (city_name, airport_code) VALUES 
('Mumbai', 'BOM'),
('Delhi', 'DEL'),
('Bangalore', 'BLR'),
('Chennai', 'MAA'),
('Kolkata', 'CCU'),
('Hyderabad', 'HYD'),
('Pune', 'PNQ'),
('Ahmedabad', 'AMD');

-- Sample Flights
INSERT INTO flights (flight_number, departure_city, arrival_city, departure_date, departure_time, arrival_time, duration, 
                    economy_price, business_price, total_seats, available_seats) 
VALUES 
('SK101', 'Mumbai', 'Delhi', '2024-01-01', '10:00:00', '12:00:00', '02:00:00', 5000.00, 12000.00, 180, 180),
('SK102', 'Delhi', 'Bangalore', '2024-01-01', '14:00:00', '16:30:00', '02:30:00', 6000.00, 14000.00, 180, 180),
('SK103', 'Bangalore', 'Mumbai', '2024-01-01', '18:00:00', '19:30:00', '01:30:00', 4500.00, 11000.00, 180, 180);

-- Indexes for better performance
CREATE INDEX idx_flights_date ON flights(departure_date);
CREATE INDEX idx_bookings_date ON bookings(booking_date);
CREATE INDEX idx_tickets_pnr ON tickets(pnr_number);
CREATE INDEX idx_users_email ON users(email);

-- Trigger to update available seats after booking
DELIMITER //
CREATE TRIGGER after_booking_insert
AFTER INSERT ON bookings
FOR EACH ROW
BEGIN
    UPDATE flights 
    SET available_seats = available_seats - NEW.total_passengers
    WHERE flight_id = NEW.flight_id;
END//
DELIMITER ;

-- Trigger to update available seats after booking cancellation
DELIMITER //
CREATE TRIGGER after_booking_cancel
AFTER UPDATE ON bookings
FOR EACH ROW
BEGIN
    IF NEW.status = 'Cancelled' AND OLD.status != 'Cancelled' THEN
        UPDATE flights 
        SET available_seats = available_seats + NEW.total_passengers
        WHERE flight_id = NEW.flight_id;
    END IF;
END//
DELIMITER ;

-- Function to generate PNR
DELIMITER //
CREATE FUNCTION generate_pnr() 
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_pnr VARCHAR(10);
    SET v_pnr = CONCAT('PNR', LPAD(FLOOR(RAND() * 1000000), 6, '0'));
    RETURN v_pnr;
END//
DELIMITER ;

-- Stored Procedure to book ticket
DELIMITER //
CREATE PROCEDURE book_ticket(
    IN p_user_id INT,
    IN p_flight_id INT,
    IN p_passengers INT,
    IN p_class VARCHAR(10),
    OUT p_booking_id INT
)
BEGIN
    DECLARE v_total_amount DECIMAL(10,2);
    DECLARE v_available_seats INT;
    
    -- Check available seats
    SELECT available_seats INTO v_available_seats 
    FROM flights WHERE flight_id = p_flight_id;
    
    IF v_available_seats >= p_passengers THEN
        -- Calculate total amount
        IF p_class = 'Economy' THEN
            SELECT economy_price * p_passengers INTO v_total_amount 
            FROM flights WHERE flight_id = p_flight_id;
        ELSE
            SELECT business_price * p_passengers INTO v_total_amount 
            FROM flights WHERE flight_id = p_flight_id;
        END IF;
        
        -- Create booking
        INSERT INTO bookings (user_id, flight_id, total_passengers, class_type, total_amount)
        VALUES (p_user_id, p_flight_id, p_passengers, p_class, v_total_amount);
        
        SET p_booking_id = LAST_INSERT_ID();
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Not enough seats available';
    END IF;
END//
DELIMITER ;

-- Views for easy reporting
CREATE VIEW flight_bookings_view AS
SELECT 
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    f.departure_date,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_amount) as total_revenue
FROM flights f
LEFT JOIN bookings b ON f.flight_id = b.flight_id
GROUP BY f.flight_id, f.departure_date;

CREATE VIEW passenger_bookings_view AS
SELECT 
    p.first_name,
    p.last_name,
    p.email,
    b.booking_date,
    f.flight_number,
    f.departure_city,
    f.arrival_city,
    t.pnr_number,
    t.seat_number
FROM passengers p
JOIN tickets t ON p.passenger_id = t.passenger_id
JOIN bookings b ON t.booking_id = b.booking_id
JOIN flights f ON b.flight_id = f.flight_id;
