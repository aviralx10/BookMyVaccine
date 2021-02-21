# BOOK MY VACCINE
An iOS App that serves as a medium for people to book COVID vaccines from the comfort of their homes.

# APP DEMO <br>


# WHAT IT DOES<br>
We wanted to be apprehensive of the fact that the general masses are now getting vaccinated and we wanted to help more to this process. So we created BookMyVaccine.
The general features of this App are-
1. **BOOKING VACCINE SLOT** - With the medium of this App, Users can look for their nearest Hospitals, book the available time slots and select the type of vaccines they want and all this can be done with just a few clicks from this App.
2. **WIDGET** - We have incorporated Widgets too with the help of WidgetKit and we display the total number of people getting vaccinated in a specific country with the help of the widgets as we wanted to be optimistic of the fact that we are slowly defeating COVID-19.<br>

<a href="https://drive.google.com/uc?export=view&id=1qaAIt7zv_7_VIsBHEQT0ulV4VWXUKe_7"><img src="https://drive.google.com/uc?export=view&id=1qaAIt7zv_7_VIsBHEQT0ulV4VWXUKe_7" width="400" ></a>
<br> 

3. **QR CODE** - Once the user is finished with booking his/her slot, we provide them with a QR code that is generately automatically with the help of their username.
<br> <a href="https://drive.google.com/uc?export=view&id=1q7_8kMTg1Z1BAyyykqsgGm0H5B0xv9cA"><img src="https://drive.google.com/uc?export=view&id=1q7_8kMTg1Z1BAyyykqsgGm0H5B0xv9cA" width="400" ></a>
<br>
4. **DARK MODE AND LIGHT MODE** - We have implemented this App in both Dark and Light Mode and users can choose either of the two according to thier convinience.

# BUILDING THE APP<br>
## SYSTEM DESIGN
<br> 
We started our project with building the system design and started to brainstorm ideas in order to make our USE CASE DIAGRAMS AND THE WIREFRAMES. <br>

## USE CASE DIAGRAM <br>
<br>
<a href="https://drive.google.com/uc?export=view&id=1YjSUu7016VxYXohm00TETqbdfRPdlBNk"><img src="https://drive.google.com/uc?export=view&id=1YjSUu7016VxYXohm00TETqbdfRPdlBNk" ></a>
<br>

## WIREFRAME <br>
<br>
<a href="https://drive.google.com/uc?export=view&id=1l_f0clkDSXqn2MgqeQGjlqc4QibQo6Xo"><img src="https://drive.google.com/uc?export=view&id=1l_f0clkDSXqn2MgqeQGjlqc4QibQo6Xo"  ></a>
<br>

## API<br>
<br>

We started working on the client and server side by side and successfully implemented our bookings API with the help of NodeJS and ExpressJS.We have hosted our API on swiftuijam.herokuapp.com.<br>
Our API logic-<br>
   - GET to check available timeslot<br>
   - POST to create appointment, send back a hash that can be made into a QR code<br>
   - GET to show time, location, vaccine info and hash after appointment is booked<br>
 * How to uniquely identify each hospital<br>
   - MapKit will find hospitals near you<br>
   - MapKit will provide the coordinates of the hospital<br>
   - When requesting to backend, send the coordinates, so backend will hash it and check records in the database<br>
   - If two hospitals ends up with same hash, send 400 Bad Request<br>


**API address: [https://swiftuijam.herokuapp.com/](https://swiftuijam.herokuapp.com)**<br>

## Endpoints:


**Part related to handle registration to be vaccinated**


1. /slots/:hospitalName [GET]  
Endpoint returns all slots for needed hospital  
Params:  
* hospitalName: String

2. /appointments/:userId [GET]  
Endpoint returns appointments for user ID  
Params:  
* userId: String

3. /bookAppointment [POST]  
Endpoint books appointment and returns its uuid if slot is free  
Params needed:  
* userId: String
* hospitalName: String
* timeSlot: String

4. /addHospital [POST]  
Endpoint creates new hospital  
Params needed:  
* hospitalName: String

5. /clearSlotsData [GET]  
Util endpoint to clear database records  

6. /clearAppointmentsData [GET]  
Util endpoint to clear database records



**Part related to fetch data related to numbers of vaccinations in different countries**

7. /newestData/:countryName [GET]  
Endpoint returns the newest statistics for the country selected in request parameters  
Params needed:
* countryName: String

8. /allData/:countryName [GET]  
Endpoint returns the all statistics for some country selected in request parameters  
Params needed: 
* countryName: String


## Database schema:

**hosital_slots** table
* hospital_name [String]  
The name of hospital  
* slots [Dictionary<String, String>]  
List of the possible slots. Each slot has two values *free* or *value of uuid*  
If it's free then it's possibe to book appointment for that time otherwise it's uuid of appoitment.  
 
**appointment** table
* uuid [String]  
This uuid is the same as in hospital_slots table.  
* user_id [String]
* hospital_name [String]
* time_slot [String]

# PROBLEMS WE FACED <br>
We had some issues in order to implement the QR code logic, and we didnt want to provide the QR code to the users who have not booked , so that was a bummer for us, but we overcame that problem shortly.

# WHAT'S NEXT <br>
1. **VOICE OVER** - We could surely implement a VoiceOver feature for the Differently Abled so that they can also easily access the App.
2. **SCALABILITY** - Right now, our app only has a handful of data of few hospitals and time slots, we could surely add more Hospitals of different cities and their time slots too.<br>
3. **IMPLEMENTING LOGIN FUNCTIONALITY BY USING APPLE,FACEBOOK,TWITTER ACCOUNTS OF USERS** 
<br>

# TECHNOLOGIES USED<br>
SWIFTUI,
WIDGETKIT,
NODEJS,
MAPKIT,
COMBINE,
MONGODB,
ORM




