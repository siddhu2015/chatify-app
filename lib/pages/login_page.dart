// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:get_it/get_it.dart';

// //widgets
// import '../widgets/custom_input_field.dart';
// import '../widgets/rounded_button.dart';

// //providers
// import '../providers/authentication_provider.dart';

// //services
// import '../services/navigation_service.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   late double _deviceHeight;
//   late double _deviceWidth;

//   late AuthenticationProvider _auth;
//   late NavigationService _navigation;

//   final _loginformKey = GlobalKey<FormState>();

//   String? _email;
//   String? _password;
//   @override
//   Widget build(BuildContext context) {
//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;

//     //getiing access to authennction provider
//     _auth = Provider.of<AuthenticationProvider>(context);
//     _navigation = GetIt.instance.get<NavigationService>();

//     return _buildUI();
//   }

//   Widget _buildUI() {
//     return Scaffold(
//       body: Container(
//         padding: EdgeInsets.symmetric(
//             horizontal: _deviceWidth * 0.03, vertical: _deviceHeight * 0.02),
//         height: _deviceHeight * 0.98,
//         width: _deviceWidth * 0.97,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _pageTitle(),
//             SizedBox(
//               height: _deviceHeight * 0.04,
//             ),
//             _loginForm(),
//             SizedBox(
//               height: _deviceHeight * 0.06,
//             ),
//             _loginButton(),
//             SizedBox(
//               height: _deviceHeight * 0.03,
//             ),
//             _registerAccountLink(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _pageTitle() {
//     return Container(
//       height: _deviceHeight * 0.10,
//       child: Text(
//         'Chatify',
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: 40,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _loginForm() {
//     return Container(
//       height: _deviceHeight * 0.21,
//       child: Form(
//         key: _loginformKey, //key maintains these data for form
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CustomTextFormField(
//               onSaved: (_value) {
//                 setState(() {
//                   _email = _value;
//                 });
//               },
//               regEx:
//                   r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//               hintText: 'Email',
//               obscureText: false,
//             ),
//             CustomTextFormField(
//               onSaved: (_value) {
//                 setState(() {
//                   _password = _value;
//                 });
//               },
//               regEx: r".{8,}",
//               hintText: 'Password',
//               obscureText: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _loginButton() {
//     return RoundedButton(
//       name: 'Login',
//       height: _deviceHeight * 0.065,
//       width: _deviceWidth * 0.65,
//       onPressed: () {
//         print("working");
//         if (_loginformKey.currentState?.validate() == true) {
//           _loginformKey.currentState!.save();
//           // print(_email);
//           // print(_password);
//           _auth.loginUsingEmailAndPassword(_email!, _password!);
//         }
//       },
//     );
//   }

//   Widget _registerAccountLink() {
//     return GestureDetector(
//       onTap: () => _navigation.navigateToRoute('/register'),
//       child: Container(
//         child: Text(
//           'Dont have an account?',
//           style: TextStyle(
//             color: Colors.blueAccent,
//           ),
//         ),
//       ),
//     );
//   }
// }

//Packages
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';

//Widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';

//Providers
import '../providers/authentication_provider.dart';

//Services
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _loginFormKey = GlobalKey<FormState>();

  String? _email;
  String? _password;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(
              height: _deviceHeight * 0.04,
            ),
            _loginForm(),
            SizedBox(
              height: _deviceHeight * 0.06,
            ),
            _loginButton(),
            SizedBox(
              height: _deviceHeight * 0.03,
            ),
            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return Container(
      height: _deviceHeight * 0.10,
      child: Text(
        'Chatify',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return Container(
      height: _deviceHeight * 0.21,
      child: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _email = _value;
                });
              },
              regEx:
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
              hintText: "Email",
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (_value) {
                setState(() {
                  _password = _value;
                });
              },
              regEx: r".{8,}",
              hintText: "Password",
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      name: "Login",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () {
        if (_loginFormKey.currentState!.validate()) {
          _loginFormKey.currentState!.save();

          _auth.loginUsingEmailAndPassword(_email!, _password!);
        }
      },
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () => _navigation.navigateToRoute('/register'),
      child: Container(
        child: Text(
          'Don\'t have an account?',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
