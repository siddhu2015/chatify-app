// //packages

// import 'dart:ui';

// import 'package:flutter/material.dart';
// import 'package:get_it/get_it.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:provider/provider.dart';

// //services
// import '../services/cloud_storage_services.dart';
// import '../services/database_services.dart';
// import '../services/media_services.dart';
// //import '../services/navigation_service.dart';

// //widgets
// import '../widgets/custom_input_field.dart';
// import '../widgets/rounded_button.dart';
// import '../widgets/rounded_image.dart';

// //providers
// import '../providers/authentication_provider.dart';

// class RegisterPage extends StatefulWidget {
//   const RegisterPage({Key? key}) : super(key: key);

//   @override
//   State<RegisterPage> createState() => _RegisterPageState();
// }

// class _RegisterPageState extends State<RegisterPage> {
//   late double _deviceHeight;
//   late double _deviceWidth;

//   late AuthenticationProvider _auth;
//   late DatabaseServices _db;
//   late CloudStorageService _cloudStorage;

//   String? _email;
//   String? _name;
//   String? _password;

//   PlatformFile? _profileImage;

//   final _registerFormKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     _auth = Provider.of<AuthenticationProvider>(context);
//     _db = GetIt.instance.get<DatabaseServices>();
//     _cloudStorage = GetIt.instance.get<CloudStorageService>();

//     _deviceHeight = MediaQuery.of(context).size.height;
//     _deviceWidth = MediaQuery.of(context).size.width;
//     return _buildUI();
//   }

//   Widget _buildUI() {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Container(
//         padding: EdgeInsets.symmetric(
//           horizontal: _deviceWidth * 0.03,
//           vertical: _deviceHeight * 0.02,
//         ),
//         height: _deviceHeight * 0.98,
//         width: _deviceWidth * 0.97,
//         child: Column(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             _profileImageField(),
//             SizedBox(
//               height: _deviceHeight * 0.05,
//             ),
//             _registerForm(),
//             SizedBox(
//               height: _deviceHeight * 0.05,
//             ),
//             _registerButton(),
//             SizedBox(
//               height: _deviceHeight * 0.02,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _profileImageField() {
//     return GestureDetector(
//         onTap: () {
//           GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
//             (_file) {
//               setState(
//                 () {
//                   _profileImage = _file;
//                 },
//               );
//             },
//           );
//         },
//         child: _profileImage != null
//             ? RoundedImageFile(
//                 key: UniqueKey(),
//                 image: _profileImage!,
//                 size: _deviceHeight * 0.15,
//               )

//             // ClipRRect(
//             //     borderRadius: BorderRadius.circular(100),
//             //     child: Container(
//             //       height: _deviceHeight * 0.15,
//             //       width: _deviceHeight * 0.15,
//             //       child: Image.asset(_profileImage!.path!),
//             //     ),
//             //   )
//             : RoundedImageNetwork(
//                 key: UniqueKey(),
//                 imagePath:
//                     "https://pbs.twimg.com/profile_images/981855662157295617/ulTdrDHd_400x400.jpg",
//                 size: _deviceHeight * 0.15,
//               ));
//   }

//   Widget _registerForm() {
//     return Container(
//       height: _deviceHeight * 0.35,
//       child: Form(
//           key: _registerFormKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _name = _value;
//                   });
//                 },
//                 regEx: r'.{8,}',
//                 hintText: "Name",
//                 obscureText: false,
//               ),
//               CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _email = _value;
//                   });
//                 },
//                 regEx:
//                     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
//                 hintText: "Email",
//                 obscureText: false,
//               ),
//               CustomTextFormField(
//                 onSaved: (_value) {
//                   setState(() {
//                     _password = _value;
//                   });
//                 },
//                 regEx: r".{8,}",
//                 hintText: "Password",
//                 obscureText: true,
//               ),
//             ],
//           )),
//     );
//   }

//   Widget _registerButton() {
//     return RoundedButton(
//       name: "Register",
//       height: _deviceHeight * 0.065,
//       width: _deviceWidth * 0.65,
//       onPressed: () async {
//         //print('working');
//         if (_registerFormKey.currentState!.validate() &&
//             _profileImage != null) {
//           //continue with registering user
//           _registerFormKey.currentState!.save();

//           // print('hello its saved');
//           String? _uid = await _auth.registerUserUsingEmailAndPassword(
//               _email!, _password!);
//           String? _imageURL =
//               await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
//           await _db.createUser(_uid, _email!, _name!, _imageURL!);
//           await _auth.logOut();
//           await _auth.loginUsingEmailAndPassword(_email!, _password!);
//         }
//       },
//     );
//   }
// }

//Packages
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';

//Services
import '../services/media_services.dart';
import '../services/database_services.dart';
import '../services/cloud_storage_services.dart';
import '../services/navigation_service.dart';

//Widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_image.dart';

//Providers
import '../providers/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseServices _db;
  late CloudStorageService _cloudStorage;
  late NavigationService _navigation;

  String? _email;
  String? _password;
  String? _name;
  PlatformFile? _profileImage;

  final _registerFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _db = GetIt.instance.get<DatabaseServices>();
    _cloudStorage = GetIt.instance.get<CloudStorageService>();
    _navigation = GetIt.instance.get<NavigationService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            _profileImageField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibrary().then(
          (_file) {
            setState(
              () {
                _profileImage = _file;
              },
            );
          },
        );
      },
      child: () {
        if (_profileImage != null) {
          return RoundedImageFile(
            key: UniqueKey(),
            image: _profileImage!,
            size: _deviceHeight * 0.15,
          );
        } else {
          return RoundedImageNetwork(
            key: UniqueKey(),
            imagePath: "https://i.pravatar.cc/150?img=65",
            size: _deviceHeight * 0.15,
          );
        }
      }(),
    );
  }

  Widget _registerForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _name = _value;
                  });
                },
                regEx: r'.{8,}',
                hintText: "Name",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _email = _value;
                  });
                },
                regEx:
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                hintText: "Email",
                obscureText: false),
            CustomTextFormField(
                onSaved: (_value) {
                  setState(() {
                    _password = _value;
                  });
                },
                regEx: r".{8,}",
                hintText: "Password",
                obscureText: true),
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      name: "Register",
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      onPressed: () async {
        if (_registerFormKey.currentState!.validate() &&
            _profileImage != null) {
          _registerFormKey.currentState!.save();
          String? _uid = await _auth.registerUserUsingEmailAndPassword(
              _email!, _password!);
          String? _imageURL =
              await _cloudStorage.saveUserImageToStorage(_uid!, _profileImage!);
          //await _db.createUser(_uid, _email!, _name!, _imageURL!);
          await _auth.logout();
          await _auth.loginUsingEmailAndPassword(_email!, _password!);
        }
      },
    );
  }
}
