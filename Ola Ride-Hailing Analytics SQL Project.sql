Use Ola;
CREATE TABLE RideData (
    Date DATE,
    Time TIME,
    BookingID VARCHAR(20) PRIMARY KEY,
    BookingStatus VARCHAR(50),
    CustomerID VARCHAR(20),
    VehicleType VARCHAR(50),
    PickupLocation VARCHAR(100),
    DropLocation VARCHAR(100),
    AvgVTAT DECIMAL(5,2),
    AvgCTAT DECIMAL(5,2),
    CancelledRidesByCustomer INT,
    ReasonForCancellingByCustomer TEXT,
    CancelledRidesByDriver INT,
    ReasonForCancellingByDriver TEXT,
    IncompleteRides INT,
    IncompleteRidesReason TEXT,
    paymentmode VARCHAR(50),
    BookingValue DECIMAL(10,2),
    RideDistance DECIMAL(10,2),
    DriverRatings DECIMAL(2,1),
    CustomerRating DECIMAL(2,1)
);

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bangalore_ola_data_february_2025.csv'
INTO TABLE RideData
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# 1. Retrieve all successful bookings: 
Create view all_successful_bookings as
Select * from RideData
Where BookingStatus = 'success';

Select * from all_successful_bookings;

# 2.Find the average ride distance for each vehicle type:
Create view ride_distance_for_each_vehicle As
SELECT VehicleType, AVG(RideDistance) as avgdistance FROM ridedata GROUP BY
VehicleType;

#3. Get the total number of cancelled rides by customers:
Create View cancelled_rides_by_customers As
SELECT COUNT(*) FROM ridedata WHERE BookingStatus = 'cancelled by Customer';

#4. List the top 5 customers who booked the highest number of rides:
Create View Top_5_Customers As
SELECT CustomerID, COUNT(BookingID) as totalrides
FROM ridedata
GROUP BY CustomerID
ORDER BY totalrides DESC LIMIT 5;

# 5. Get the number of rides cancelled by drivers due to personal and car-related issues: 
Create View Rides_cancelled_by_Drivers_Personal_Car_Issues As
SELECT COUNT(*) FROM ridedata WHERE ReasonforcancellingbyDriver = 'Personal & Car related issues';

# 6. Find the maximum and minimum driver ratings for Prime Sedan bookings: 
Create View Max_Min_Driver_Rating As
SELECT MAX(DriverRatings) as max_rating,
MIN(DriverRatings) as min_rating
FROM ridedata WHERE VehicleType = 'Prime Sedan';
Select * from Max_Min_Driver_Rating;

# 7. Retrieve all rides where payment was made using UPI: 
Create View UPI_Payment As
SELECT * FROM ridedata
WHERE PaymentMode= 'UPI';

#8. Find the average customer rating per vehicle type:
Create View AVG_Cust_Rating As
SELECT VehicleType, AVG(CustomerRating) as avg_customer_rating
FROM ridedata
GROUP BY VehicleType;

#9. Calculate the total booking value of rides completed successfully:
Create View total_successful_ride_value As
SELECT SUM(BookingValue) as total_successful_ride_value
FROM ridedata
WHERE BookingStatus = 'Success';

#10. List all incomplete rides along with the reason:
Create View Incomplete_Rides_Reason As
SELECT BookingID, IncompleteRidesReason  
FROM ridedata  
WHERE BookingStatus = 'Incomplete';
Select * from ridedata;