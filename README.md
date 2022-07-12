# Flutter Chat App Socket IO

A flutter app that utilized socket io for realtime chat.

## Getting Started

* Make sure to install all the required packages/libraries
  * at the root folder run this on the terminal `pub get` or `flutter pub get`
  * now go to the server folder then run `npm install`
* Create an environment variable for Mongo db database and private key for Jwt token
  * name it MONGO_DB and PRIVATE_KEY it still depends on you
* Also change the ip address on the server to your ip address, in flutter change the global variables, in the server change the ip where it listens to. This is applicable if you only run in locally, remove the ip address if hosting online.

### Running the application locally
* after installing all the libraries/packages
* go to the server then run `npm start` and for running in phones type in the terminal `flutter run` to instal the app

## Functions

* Can login and signup using email
* Can add friends using email
* Can chat friends with realtime data going to both users

## Future Updates

* Search function
* User Profile
* Chat UI