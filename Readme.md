# BOOK MY APP
An iOS App that serves as a medium for people to book COVID vaccines from the comfort of their homes.

# APP DEMO <br>


# WHAT IT DOES<br>
We wanted to be apprehensive of the fact that the general masses are now getting vaccinated and we wanted to help more to this process. So we created BookMyVaccine.
The general features of this App are-
1. **BOOKING VACCINE SLOT** - With the medium of this App, Users can look for their nearest Hospitals, book the available time slots and select the type of vaccines they want and all this can be done with just a few clicks from this App.
2. **WIDGET** - We have incorporated Widgets too with the help of WidgetKit and we display the total number of people getting vaccinated in a specific country with the help of the widgets as we wanted to be optimistic of the fact that we are slowly defeating COVID-19.
3. **QR CODE** - Once the user is finished with booking his/her slot, we provide them with a QR code that is generately automatically with the help of their username.
4.  **DARK MODE AND LIGHT MODE** - We have implemented this App in both Dark and Light Mode and users can choose either of the two according to thier convinience.

# BUILDING THE APP<br>
**SYSTEM DESIGN**<br>
We started our project with building the system design and started to brainstorm ideas in order to make our USE CASE DIAGRAMS AND THE WIREFRAMES. <br>
USE CASE DIAGRAM<br>
![image](Screenshot 2021-02-21 at 2.05.06 PM.png)<br>
WIREFRAME<br>
![image](Screenshot 2021-02-21 at 2.07.52 PM.png)<br>
**API**<br>
We started working on the client and server side by side and successfully implemented our bookings API with the help of NodeJS and ExpressJS.We have hosted our API on swiftuijam.herokuapp.com.
Our API logic-
   - GET to check available timeslot
   - POST to create appointment, send back a hash that can be made into a QR code
   - GET to show time, location, vaccine info and hash after appointment is booked
 * How to uniquely identify each hospital
   - MapKit will find hospitals near you
   - MapKit will provide the coordinates of the hospital
   - When requesting to backend, send the coordinates, so backend will hash it and check records in the database
   - If two hospitals ends up with same hash, send 400 Bad Request


SOME INTERESTING ENDPOINTS IN OUR API
1. GET REQUEST - bookAppointment/userID/HospitalName/Slot - This endpoint would help us check if the user is already booked or not.
2. GET REQUEST - bookAppointment/HospitalName - This endpoint would let us know about the different time slots available at a particular Hospital.
3. POST REQUEST - /bookAppointment - This endpoint would help the user book his.her appointment.

# TECHNOLOGIES USED<br>
SWIFTUI,WIDGETKIT,NODE,MAPKIT




