# E-Restaurant

**Summary:** users order dishes to their addresses and get it delivered after some time.

**Deployed:** https://erestaurant.herokuapp.com/

### Customer
When customers go to main page they see the menu. They can choose dishes by category of full dishes list. Here they fill up their shopping cart when choose dish they want to order.
![alt text](https://cloud.githubusercontent.com/assets/11503436/16850422/c2facff2-4a07-11e6-9ba1-a182bded5651.png "Customer use case diagram")

### Order
After customers finish with choosing dishes, they can specify its quantity on the shopping cart page. They can also edit or confirm their order there. Then every kitchen-made dish goes to the kitchen.
![alt text](https://cloud.githubusercontent.com/assets/11503436/16850489/13abb18c-4a08-11e6-8338-889747c73447.png "Order use case diagram")

### Kitchen & Delivery Staff
Kitchen Staff have access to kitchen pending screen page where they see all the dishes waiting to be prepared. Just when they cook it they mark it as ‘done’ and this dish disappear from kitchen pending screen.
![alt text](https://cloud.githubusercontent.com/assets/11503436/16850727/272a2c60-4a09-11e6-95c4-67340164e867.png "Kitchen & Delivery Staff use case diagram")

### Administrator
There is an administrator in ERestaurant. Administrator's duty is managing the menu - to add new dishes, edit existing ones, set prices, mark dishes as available/unavailable.
Administrator also can manage customers and block them.
![alt text](https://cloud.githubusercontent.com/assets/11503436/16850912/cdd2ccc0-4a09-11e6-99f6-d6ce877dc351.png "Administrator use case diagram")

### Business Analyst
Another employee role in ERestaurant is Business Analyst. He makes reports about restaurant statistics - how many dishes were sold, what is the most profitable dish category and the total income of specified period of time.
![alt text](https://raw.githubusercontent.com/DimaSanKiev/E-Restaurant/master/files/description/use-case-diagram5.jpg "Business Analyst use case diagram")

### Super User
The Super User is the master of the restaurant. He hires and dismisses employees. There is only one Super User in ERestaurant system.
![alt text](https://raw.githubusercontent.com/DimaSanKiev/E-Restaurant/master/files/description/use-case-diagram6.jpg "Super User use case diagram")

## Project Architecture
My application is flexible and reusable because it is based on three-tier architecture:
- *Presentation layer*,
- *Business layer* and
- *Persistence layer*.
![alt text](https://raw.githubusercontent.com/DimaSanKiev/E-Restaurant/master/files/description/structure.jpg "Project structure diagram")

In Persistence layer is used **SQL** for modelling data and creating DB structure.
Persistence layer cooperate with Business layer with **JPA**, **JP QL** and **EclipseLink**.

In Business layer **Spring Framework** is used as dependency injection and inversion of control container. It collaborates with Persistence layer and Presentation layer directly. Here **DAO pattern** is used to provide some specific data operations without exposing details of the database.

In Presentation layer such technologies as **JSF**, **PrimeFaces**, **HTML** and **CSS** are used.

Project is written in **Java 8** and built with **Maven**. It runs under lightweight **Jetty** HTTP Web Server, but can be easily replaced to Tomcat or any other Web Server.
I tested my service methods with **JUnit** and used **Log4J** as a logging tool.

## Database Architecture
Here is the structure of the database.
![alt text](https://raw.githubusercontent.com/DimaSanKiev/E-Restaurant/master/files/description/db.jpg "Database structure diagram")

Main tables are **Customer**, **Employee**, **Orders**, **Dish** and **OrderDishes** (as a linking table).
**Role**, **OrderStatus** and **DishCategory** are subsidiary tables.
Here is shown only the main fields and relations.

## Accounts
Some registered **_customers' accounts_**:
+ olga.romanova@gmail.com:pass1
+ igor.shevchenko@yahoo.com:pass2
+ kate.belova@gmail.com:pass3


**_Employees signing-in form_** is available on different URL https://erestaurant.herokuapp.com/employeeSignIn.xhtml:
+ **Super User** (super@erestaurant.com:pass1)
+ **Administrator** (admin@erestaurant.com:pass2)
+ **Kitchen Staff** (kitchen@erestaurant.com:pass3)
+ **Delivery Staff** (delivery@erestaurant.com:pass4)
+ **Business Analyst** (business@erestaurant.com:pass5)
