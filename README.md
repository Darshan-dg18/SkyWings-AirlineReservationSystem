# SkyWings - Airline Reservation System

SkyWings is a comprehensive airline reservation system built with Java EE, offering a seamless experience for both users and administrators to manage flight bookings, user accounts, and airline operations.

## 🚀 Features

### User Features
- **Flight Search & Booking**
  - Search flights by destination and date
  - View flight details and pricing
  - Select seats and travel class
  - Make secure payments

- **User Account Management**
  - Personal profile management
  - Booking history
  - Flight status tracking
  - Email notifications

### Admin Features
- **Dashboard**
  - Real-time statistics
  - Booking trends
  - Revenue analytics

- **Flight Management**
  - Add/Edit/Delete flights
  - Update flight status
  - Manage seat availability

- **User Management**
  - View user details
  - Block/Unblock users
  - Track user activities

- **Booking Management**
  - View all bookings
  - Process cancellations
  - Generate reports
  - Export booking data

## 🛠️ Technologies Used

- **Backend**
  - Java EE
  - Servlets & JSP
  - JDBC
  - MySQL Database

- **Frontend**
  - HTML5
  - CSS3
  - JavaScript
  - Bootstrap
  - Chart.js

- **Tools & Libraries**
  - Apache Tomcat
  - MySQL Connector/J
  - JavaMail API
  - JSTL

## 📋 Prerequisites

- JDK 17 or higher
- Apache Tomcat 10.x
- MySQL 8.0 or higher
- Maven (for dependency management)

## 🔧 Installation & Setup

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/airline-reservation.git
   cd airline-reservation
   ```

2. **Database Setup**
   - Create a MySQL database named 'airline_reservation'
   - Import the SQL scripts from `src/main/resources/`
   ```bash
   mysql -u root -p airline_reservation < airline_reservation.sql
   mysql -u root -p airline_reservation < flights.sql
   ```

3. **Configure Database Connection**
   - Update database credentials in `src/main/java/com/skywings/util/DatabaseConnection.java`

4. **Email Configuration**
   - Update email credentials in `src/main/java/com/skywings/servlet/EmailNotificationServlet.java`

5. **Build & Deploy**
   - Deploy the project to Tomcat server
   - Access the application at `http://localhost:8080/AirlineReservation`

## 🏗️ Project Structure

```
AirlineReservation/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/
│   │   │       └── skywings/
│   │   │           ├── model/
│   │   │           ├── servlet/
│   │   │           ├── filter/
│   │   │           └── util/
│   │   ├── resources/
│   │   └── webapp/
│   │       ├── admin/
│   │       ├── WEB-INF/
│   │       └── *.jsp
└── pom.xml
```

## 👥 User Roles

1. **Regular Users**
   - Search and book flights
   - Manage bookings
   - View flight status
   - Update profile

2. **Administrators**
   - Manage flights and schedules
   - Handle user accounts
   - Process refunds
   - Generate reports

## 🔐 Security Features

- User authentication
- Session management
- Input validation
- SQL injection prevention
- XSS protection

⭐ Star this repository if you find it helpful!
