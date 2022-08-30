// //packages
// import 'package:flutter/material.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:provider/provider.dart';

// //provider
// import './providers/authentication_provider.dart';

// //service
// import './services/navigation_service.dart';

// //pages
// import 'package:chatify/pages/splash_page.dart';
// import './pages/login_page.dart';
// import './pages/register_page.dart';
// import './pages/home_page.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp();
//   runApp(
//     SplashPage(
//       key: UniqueKey(),
//       onIniti: () {
//         runApp(MainApp());
//       },
//     ),
//   );
// }

// class MainApp extends StatelessWidget {
//   const MainApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       //multiprovider allow to have a single widget that can have many  different providers and all of these providers caan be accessed by whatever chid this widget has.
//       providers: [
//         ChangeNotifierProvider<AuthenticationProvider>(
//           create: (BuildContext _context) {
//             return AuthenticationProvider();
//           },
//         )
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Chatify',
//         theme: ThemeData(
//           // backgroundColor: Color.fromARGB(255, 30, 16, 228),
//           scaffoldBackgroundColor: Color.fromARGB(255, 15, 15, 16),
//           bottomNavigationBarTheme: BottomNavigationBarThemeData(
//               backgroundColor: Color.fromRGBO(30, 29, 37, 1.0)),
//         ),
//         navigatorKey: NavigationService.navigatorKey,
//         initialRoute: '/login',
//         routes: {
//           '/login': (BuildContext _context) => LoginPage(),
//           '/register': (BuildContext _context) => RegisterPage(),
//           '/home': (BuildContext _context) => HomePage(),
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

//Packages
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:provider/provider.dart';

//Services
import './services/navigation_service.dart';

//Providers
import './providers/authentication_provider.dart';

//Pages
import './pages/splash_page.dart';
import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/home_page.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
          create: (BuildContext _context) {
            return AuthenticationProvider();
          },
        )
      ],
      child: MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        navigatorKey: NavigationService.navigatorKey,
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext _context) => LoginPage(),
          '/register': (BuildContext _context) => RegisterPage(),
          '/home': (BuildContext _context) => HomePage(),
        },
      ),
    );
  }
}
