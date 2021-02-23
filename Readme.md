# Book My Vaccine
An iOS app that serves as a medium for people to book COVID-19 vaccines from the comfort of their homes.

## App Demo
[Link to Video](https://player.vimeo.com/video/515028720)

## What It Does
We wanted to highlight the fact that the general masses are now getting vaccinated and we wanted to help more to this process. So we created BookMyVaccine. 

#### Booking Vaccines

Users can look for their nearest hospitals, book the available time slots and select the type of vaccines they want and all this can be done with just a few clicks from this App.

#### Widget

We have incorporated Widgets too with the help of `WidgetKit` and we display the total number of people getting vaccinated in a specific country with the help of the widgets as we wanted to be optimistic of the fact that we are slowly defeating COVID-19.

<a href="https://drive.google.com/uc?export=view&id=1qaAIt7zv_7_VIsBHEQT0ulV4VWXUKe_7"><img src="https://drive.google.com/uc?export=view&id=1qaAIt7zv_7_VIsBHEQT0ulV4VWXUKe_7" width="400" ></a>


### **QR Code**

Once the user is finished with booking his/her slot, we provide them with a QR code that is generately automatically with the help of their username.



<a href="https://drive.google.com/uc?export=view&id=1q7_8kMTg1Z1BAyyykqsgGm0H5B0xv9cA"><img src="https://drive.google.com/uc?export=view&id=1q7_8kMTg1Z1BAyyykqsgGm0H5B0xv9cA" width="400" ></a>

#### Dark Mode And Light Mode

We have implemented this app in both Dark and Light Mode and users can choose either of the two according to their convenience.

## Building the App
### Use Case Diagram

<a href="https://drive.google.com/uc?export=view&id=1YjSUu7016VxYXohm00TETqbdfRPdlBNk"><img src="https://drive.google.com/uc?export=view&id=1YjSUu7016VxYXohm00TETqbdfRPdlBNk" ></a>


### Wireframe

<a href="https://drive.google.com/uc?export=view&id=1l_f0clkDSXqn2MgqeQGjlqc4QibQo6Xo"><img src="https://drive.google.com/uc?export=view&id=1l_f0clkDSXqn2MgqeQGjlqc4QibQo6Xo"  ></a>


### API
We started working on the client and server side by side and successfully implemented our bookings API with the help of Node.JS and Express.JS. We have hosted our API on Heroku.

   - `GET` to check available timeslot
   - `POST` to create appointment, send back a hash that can be made into a QR code
   - `GET` to show time, location, vaccine info and hash after appointment is booked
 * How to uniquely identify each hospital
   - MapKit will find hospitals near you
   - MapKit will provide the coordinates of the hospital
   - When requesting to backend, send the coordinates, so backend will hash it and check records in the database
   - If two hospitals ends up with same hash, send 400 Bad Request

### Endpoints


**Part related to handle registration to be vaccinated**


1. `GET /slots/:hospitalName` 
Endpoint returns all slots for needed hospital 
Params:  
* `hospitalName: String`

2. `GET /appointments/:userId` 
Endpoint returns appointments for user ID 
Params:  
* `userId: String`

3. `POST /bookAppointment`
Endpoint books appointment and returns its uuid if slot is free 
Params needed:  
* `userId: String`
* `hospitalName: String`
* `timeSlot: String`

4. `POST /addHospital`
Endpoint creates new hospital 
Params needed:  
* `hospitalName: String`

5. `GET /clearSlotsData`
Utility endpoint to clear database records  

6. `GET /clearAppointmentsData`
Utility endpoint to clear database records



**Part related to fetch data related to numbers of vaccinations in different countries**

7. `GET /newestData/:countryName`
Endpoint returns the newest statistics for the country selected in request parameters 
Params needed:
* `countryName: String`

8. `GET /allData/:countryName`
Endpoint returns the all statistics for some country selected in request parameters 
Params needed: 
* `countryName: String`


### Database schema

**hosital_slots** table
* `hospital_name` [String] 
The name of hospital  
* `slots: [Dictionary<String, String>]` 
List of the possible slots. Each slot has two values *free* or *value of uuid* 
If it's free then it's possibe to book appointment for that time otherwise it's uuid of appoitment.  

**appointment** table
* `uuid: [String]` 
This uuid is the same as in hospital_slots table.  
* `user_id: [String]`
* hospital_name: [String]
* `time_slot: [String]`

## Problems We Faced 
We had some issues in order to implement the QR code logic, and we didnt want to provide the QR code to the users who have not booked , so that was a bummer for us, but we overcame that problem shortly.

## What's Next 
1. **Voice Over** - We could surely implement a VoiceOver feature for the Differently Abled so that they can also easily access the app.
2. **Scalability** - Right now, our app only has a handful of data of few hospitals and time slots, we could surely add more hospitals of different cities and their time slots too.
3. **OAuth** which allows users to login functionality by using their Apple, Facebook, or Twitter account


## Technologies Used
- SwiftUI
- WidgetKit
- Node.JS
- MapKit
- Combine
- MongoDB




