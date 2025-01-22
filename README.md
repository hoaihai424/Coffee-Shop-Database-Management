# Coffee Shop Management System

## Overview
The **Coffee Shop Management System** is a relational database project aimed at streamlining the management of coffee shop chains. This system integrates various features to optimize business operations, enhance customer experience, and support managerial decision-making through data insights.

## Objectives
- **Centralized Management:** Minimize errors and automate data storage and processing.
- **Enhanced Customer Experience:** Offer loyalty programs with point-based rewards and personalized services.
- **Managerial Support:** Provide detailed reporting tools to monitor revenues, staff performance, and product sales.
- **Business Decision Support:** Analyze sales trends and customer feedback for strategic planning.
- **Scalability:** Designed to handle business growth, including the addition of branches and new features.

## System Features
### Core Functionalities
1. **Customer Management:**
   - Maintain customer profiles, including personal details and transaction history.
   - Loyalty points and rewards system for customer retention.
   - Enable product reviews and feedback.
2. **Employee Management:**
   - Manage employee details, work schedules, and payroll.
   - Assign employees to shifts and track their performance.
3. **Order Management:**
   - Process orders with detailed tracking of products, quantities, and prices.
   - Automate payment status updates.
4. **Product Management:**
   - Maintain a catalog of products, including descriptions, pricing, and stock status.
   - Handle promotions and discounts.
5. **Gift Redemption:**
   - Allow customers to redeem loyalty points for gifts.
6. **Reporting and Analytics:**
   - Generate detailed reports on revenue, popular products, and customer activity.
   - Visualize data for strategic insights.

### Non-Functional Requirements
- **Performance:** Ensure the system can handle a high volume of transactions with minimal latency.
- **Security:** Protect sensitive customer and business data.
- **Usability:** Provide an intuitive interface for users.

## Database Schema
The database schema includes the following tables:
- `customer`: Stores customer information.
- `employee`: Stores employee information.
- `gift`: Stores gift information.
- `_order`: Stores order information.
- `exchange`: Stores gift exchange information.
- `product`: Stores product information.
- `has`: Stores order-product relationships.
- `review`: Stores product reviews.
- `shift`: Stores shift information.
- `schedule`: Stores employee shift schedules.

## Triggers
The system includes several triggers to automate updates:
- `product_rating_trigger`: Updates product ratings based on reviews.
- `customer_point_trigger`: Updates customer points based on orders.
- `gift_exchange_trigger`: Updates customer points based on gift exchanges.

## Procedures
The system includes stored procedures for various operations:
- `create_customer`: Adds a new customer.
- `create_employee`: Adds a new employee.
- `create_order`: Adds a new order.
- `exchange_gift`: Processes gift exchanges.
- `create_product`: Adds a new product.
- `create_review`: Adds a new product review.
- `create_schedule`: Adds a new employee schedule.

## Views
The system includes several views for reporting:
- `customer_log`: Displays customer order logs.
- `employee_log`: Displays employee order logs.
- `category_ranking`: Displays product category rankings based on reviews.
- `customer_analysis`: Analyzes customer spending.
- `employee_analysis`: Analyzes employee performance.

## Functions
The system includes several functions for data retrieval:
- `get_available_gifts`: Retrieves available gifts for a customer.
- `get_customer_order_log`: Retrieves a customer's order log.
- `get_customer_review_log`: Retrieves a customer's review log.
- `get_customer_exchange_log`: Retrieves a customer's gift exchange log.
- `calculate_total_revenue`: Calculates total revenue for a specific time span.

## Sample Data
The system includes sample data for customers, employees, orders, products, and more to facilitate testing and demonstration.

## Usage
To use the system, follow these steps:
1. Set up the database schema by running the SQL scripts in the following order:
   - `metadata.sql`
   - `inserted_data.sql`
   - `procedures.sql`
   - `functions.sql`
   - `views.sql`
   - `trigger.sql`
2. Use the provided procedures and functions to interact with the database.
3. Generate reports using the provided views.

## Conclusion
The Coffee Shop Management System is a robust solution for managing coffee shop operations, enhancing customer experience, and supporting business decision-making through comprehensive data management and reporting capabilities.