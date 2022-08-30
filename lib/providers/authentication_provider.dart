// //Packages
// import 'package:chatify/models/chat_user.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get_it/get_it.dart'; // we will need to interact with the nagivation and database services  within the class and to accss them we need get it package

// //services
// import '../services/database_services.dart';
// import '../services/navigation_service.dart';

// //models
// import '../models/chat_user.dart';

// class AuthenticationProvider extends ChangeNotifier {
//   //changenotifier allows other pieces of code to acutally listen to changes that happens within the class and interact to them
//   late final FirebaseAuth _auth;
//   late final NavigationService _navigationService;
//   late final DatabaseServices _databaseServices;
//   late ChatUser user;

//   AuthenticationProvider() {
//     _auth = FirebaseAuth.instance;
//     _navigationService = GetIt.instance.get<NavigationService>();
//     _databaseServices = GetIt.instance.get<DatabaseServices>();

//     _auth.signOut();

//     _auth.authStateChanges().listen((_user) {
//       if (_user != null) {
//         // print("Logged in");
//         _databaseServices.updateUserLastSeenTime(_user.uid);
//         _databaseServices.getUser(_user.uid).then(
//           (_snapshot) {
//             Map<String, dynamic> _userData =
//                 _snapshot.data()! as Map<String, dynamic>;
//             user = ChatUser.fromJSON(
//               {
//                 "uid": user.uid,
//                 "name": _userData['name'],
//                 "email": _userData['email'],
//                 "last_Active": _userData['last_Active'],
//                 "image": _userData['image'],
//               },
//             );
//             //print(user);
//           },
//         );
//         _navigationService.removeAndNavigateToRoute('/home');
//       } else {
//         //print("Not authenticated");
//         _navigationService.removeAndNavigateToRoute('/login');
//       }
//     });
//   }

//   Future<void> loginUsingEmailAndPassword(
//       String _email, String _password) async {
//     //we use try catch becoz if we have an error we can catch it anf perform an appropriate actions instead of having an app crash
//     try {
//       print(_email);
//       print(_password);
//       await FirebaseAuth.instance.signInWithEmailAndPassword(
//           email: _email.trim(), password: _password.trim());
//       print(_auth.currentUser!.uid);
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<String?> registerUserUsingEmailAndPassword(
//       String _email, String _password) async {
//     try {
//       UserCredential _credintals = await _auth.createUserWithEmailAndPassword(
//           email: _email, password: _password);
//       return _credintals.user!.uid;
//     } on FirebaseAuthException {
//       print("Error registering user.");
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> logOut() async {
//     try {
//       await _auth.signOut();
//     } catch (e) {
//       print(e);
//     }
//   }
// }

//Packages
//import 'package:chatify_app/models/chat_user.dart';
import 'package:chatify/models/chat_user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/database_services.dart';
import '../services/navigation_service.dart';

//Models
import '../models/chat_user.dart';

class AuthenticationProvider extends ChangeNotifier {
  late final FirebaseAuth _auth;
  late final NavigationService _navigationService;
  late final DatabaseServices _databaseService;

  late ChatUser user;

  AuthenticationProvider() {
    _auth = FirebaseAuth.instance;
    _navigationService = GetIt.instance.get<NavigationService>();
    _databaseService = GetIt.instance.get<DatabaseServices>();

    _auth.authStateChanges().listen((_user) {
      if (_user != null) {
        //_databaseService.updateUserLastSeenTime(_user.uid);
        _databaseService.getUser(_user.uid).then(
          (_snapshot) {
            Map<String, dynamic> _userData =
                _snapshot.data()! as Map<String, dynamic>;
            user = ChatUser.fromJSON(
              {
                "uid": _user.uid,
                "name": _userData["name"],
                "email": _userData["email"],
                "last_Active": _userData['last_Active'],
                "image": _userData["image"],
              },
            );
            print(user.toMap());
          },
        );
      } else {
        print("Not aunthictaed");
      }
      // if (_user != null) {
      //   _databaseService.updateUserLastSeenTime(_user.uid);
      //   _databaseService.getUser(_user.uid).then(
      //     (_snapshot) {
      //       Map<String, dynamic> _userData =
      //           _snapshot.data()! as Map<String, dynamic>;
      //       user = ChatUser.fromJSON(
      //         {
      //           "uid": _user.uid,
      //           "name": _userData["name"],
      //           "email": _userData["email"],
      //           "last_Active": _userData['last_Active'],
      //           "image": _userData["image"],
      //         },
      //       );
      //       _navigationService.removeAndNavigateToRoute('/home');
      //     },
      //   );
      // } else {
      //   if (_navigationService.getCurrentRoute() != '/login') {
      //     _navigationService.removeAndNavigateToRoute('/login');
      //   }
      // }
    });
  }
  Future<void> loginUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: _email.trim(), password: _password.trim());
      print(_auth.currentUser);
    } on FirebaseAuthException {
      print("Error logging user into Firebase");
    } catch (e) {
      print(e);
    }
  }

  Future<String?> registerUserUsingEmailAndPassword(
      String _email, String _password) async {
    try {
      UserCredential _credentials = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      return _credentials.user!.uid;
    } on FirebaseAuthException {
      print("Error registering user.");
    } catch (e) {
      print(e);
    }
  }

  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }
}
