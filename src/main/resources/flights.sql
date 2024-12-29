USE airline_reservation;

-- Drop existing table if exists
DROP TABLE IF EXISTS flights;

-- Create flights table
CREATE TABLE flights (
    flight_id INT PRIMARY KEY AUTO_INCREMENT,
    flight_number VARCHAR(10) NOT NULL,
    departure_city VARCHAR(50) NOT NULL,
    arrival_city VARCHAR(50) NOT NULL,
    departure_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    economy_price DECIMAL(10, 2) NOT NULL,
    business_price DECIMAL(10, 2) NOT NULL,
    available_seats INT NOT NULL,
    flight_status VARCHAR(20) DEFAULT 'Scheduled'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert sample flights
INSERT INTO flights (
    flight_number, 
    departure_city, 
    arrival_city, 
    departure_date, 
    departure_time, 
    arrival_time, 
    economy_price, 
    business_price, 
    available_seats
) VALUES 
-- Mumbai to Delhi flights
('AI101', 'Mumbai', 'Delhi', '2024-01-01', '06:00:00', '08:00:00', 5000.00, 12000.00, 180),
('AI102', 'Mumbai', 'Delhi', '2024-01-01', '14:00:00', '16:00:00', 5500.00, 13000.00, 180),

-- Delhi to Mumbai flights
('AI201', 'Delhi', 'Mumbai', '2024-01-01', '09:00:00', '11:00:00', 5200.00, 12500.00, 180),
('AI202', 'Delhi', 'Mumbai', '2024-01-01', '17:00:00', '19:00:00', 5700.00, 13500.00, 180),

-- Bangalore routes
('AI301', 'Bangalore', 'Mumbai', '2024-01-01', '07:30:00', '09:00:00', 4500.00, 11000.00, 180),
('AI302', 'Mumbai', 'Bangalore', '2024-01-01', '10:00:00', '11:30:00', 4700.00, 11500.00, 180),

-- Chennai routes
('AI401', 'Chennai', 'Mumbai', '2024-01-01', '08:00:00', '10:00:00', 4800.00, 11800.00, 180),
('AI402', 'Mumbai', 'Chennai', '2024-01-01', '11:00:00', '13:00:00', 5100.00, 12100.00, 180);

-- Create index for searching
CREATE INDEX idx_flight_search ON flights(departure_city, arrival_city, departure_date);
