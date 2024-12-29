USE airline_reservation;

-- Drop existing table if it exists
DROP TABLE IF EXISTS registration;

-- Create registration table with minimal required fields
CREATE TABLE registration (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
