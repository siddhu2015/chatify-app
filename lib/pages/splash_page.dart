// //packages
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:get_it/get_it.dart';

// //services
// import '../services/media_services.dart';
// import '../services/navigation_service.dart';
// import '../services/cloud_storage_services.dart';
// import '../services/database_services.dart';

// class SplashPage extends StatefulWidget {
//   final VoidCallback onIniti;
//   const SplashPage({required Key? key, required this.onIniti})
//       : super(key: key);

//   @override
//   State<SplashPage> createState() => _SplashPageState();
// }

// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 4)).then((_) {
//       _setup().then(
//         (_) => widget.onIniti(),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Chatify',
//       theme: ThemeData(
//           backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
//           scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0)),
//       home: Scaffold(
//         body: Center(
//           child: Container(
//             height: 200,
//             width: 200,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 fit: BoxFit.contain,
//                 image: AssetImage('assets/images/logo.png'),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _setup() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     await Firebase.initializeApp();

//     _registerServices();
//   }

//   void _registerServices() {
//     GetIt.instance.registerSingleton<NavigationService>(
//       NavigationService(),
//     );
//     GetIt.instance.registerSingleton<MediaService>(
//       MediaService(),
//     );
//     GetIt.instance.registerSingleton<CloudStorageService>(
//       CloudStorageService(),
//     );
//     GetIt.instance.registerSingleton<DatabaseServices>(
//       DatabaseServices(),
//     );
//   }
// }

import 'package:flutter/material.dart';

//Packages
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

//Services
import '../services/navigation_service.dart';
import '../services/media_services.dart';
import '../services/cloud_storage_services.dart';
import '../services/database_services.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    required Key key,
    required this.onInitializationComplete,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then(
      (_) {
        _setup().then(
          (_) => widget.onInitializationComplete(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatify',
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
        scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1.0),
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage('assets/images/logo.png'),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(
      NavigationService(),
    );
    GetIt.instance.registerSingleton<MediaService>(
      MediaService(),
    );
    GetIt.instance.registerSingleton<CloudStorageService>(
      CloudStorageService(),
    );
    GetIt.instance.registerSingleton<DatabaseServices>(
      DatabaseServices(),
    );
  }
}
