USE airline_reservation;

-- Create payments table
CREATE TABLE payments (
    payment_id VARCHAR(36) PRIMARY KEY,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES registration(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Create flight_status table
CREATE TABLE flight_status (
    flight_number VARCHAR(10) PRIMARY KEY,
    status_message TEXT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (flight_number) REFERENCES flights(flight_number)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Add payment_id to bookings table
ALTER TABLE bookings ADD COLUMN payment_id VARCHAR(36);
ALTER TABLE bookings ADD FOREIGN KEY (payment_id) REFERENCES payments(payment_id);

-- Create indexes
CREATE INDEX idx_payment_status ON payments(payment_status);
CREATE INDEX idx_flight_status_update ON flight_status(last_updated);

-- Add necessary columns to flights table if not exists
ALTER TABLE flights ADD COLUMN flight_status VARCHAR(20) DEFAULT 'Scheduled' 
    AFTER available_seats;
