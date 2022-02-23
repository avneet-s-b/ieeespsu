import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  final emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        return Container(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  // overflow: Overflow.visible,
                  clipBehavior: Clip.none,
                  children: [
                    Opacity(
                      opacity: 1,
                      child: ClipPath(
                        clipper: Clipper(),
                        child: Container(
                          color: Colors.cyan,
                          height: 320,
                        ),
                      ),
                    ),
                    Positioned(
                      height: 450,
                      left: 105,
                      child: CircleAvatar(
                        radius: 100,
                        backgroundColor: Colors.cyan[600],
                        child: CircleAvatar(
                          radius: 95,
                          backgroundColor: Colors.white,
                          //backgroundImage:  AssetImage("assets/images/logo.png"),
                          child: Container(
                            height: 100,
                            width: 160,
                            child: Image.asset(
                              "assets/images/logo.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Enter the email to recieve the password reset link."),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  child: TextFormField(
                    controller: emailcontroller,
                    keyboardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value!.isEmpty || !value.contains('@')) {
                        return "Incorrect Email.";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                    decoration: const InputDecoration(
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(8.0),
                      //     borderSide: BorderSide()),
                      prefixIcon: Icon(Icons.person_outline),
                      hintText: "Email",
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 60,
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {
                      resetPassword();
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.normal),
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.text.trim());
      SnackBar mySnackBar = SnackBar(content: Text("Reset link sent to email"));
      ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
    } catch (err) {
      print(err);
      SnackBar mySnackBar = SnackBar(content: Text("Error"));
      ScaffoldMessenger.of(context).showSnackBar(mySnackBar);
    }
  }
}

//CLIPPER class for the wave design

class Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 100);
    path.quadraticBezierTo(
        size.width / 3, size.height - 170, size.width / 1.001, size.height);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height);
    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(Clipper oldClipper) => false;
}
