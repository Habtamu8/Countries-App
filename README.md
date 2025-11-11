This app shows countries with some spesfic information.
 the enviromnetal dependencies used to build this app are  
  * cupertino_icons: ^1.0.8
  * dio: ^5.9.0
  * flutter_bloc: ^9.1.1
  * shimmer: ^3.0.0
  * shared_preferences: ^2.5.3
I used Bloc state managment to build this app because of BLoC (Business Logic Component) separates UI from business logic, which improves maintainability and testability.

N.B in the detialed screen of the app, the Region and sub region fetches 


N.B in the detailed screen of the app, the Region and sub region fetches the number of people and the country name. i used this for showcase purpose only, the detailed data of REST API from app requirement description is not working. it displays like this
{
"message": "Bad Request",
"status": 400
}
