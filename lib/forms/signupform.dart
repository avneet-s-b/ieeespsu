import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ieeespsu/screens/accountcreated.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formkey = GlobalKey<FormState>();
  var _email = '';
  var _password = '';
  var _username = '';

  startauthentication() {
    final validity = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (validity) {
      _formkey.currentState!.save();
      submitform(_email, _password, _username);
    }
  }

  submitform(String email, String password, String username) async {
    final auth = FirebaseAuth.instance;
    UserCredential authResult;
    try {
      authResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = authResult.user!.uid;

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .set({'username': username, 'email': email});
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
      child: Container(
        padding: EdgeInsets.all(15),
        height: 400,
        width: 400,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.cyan,
                Colors.white,
              ],
              stops: [0.1, 1],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 40,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('username'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Add username";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _username = value!;
                  },
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.person_add_outlined),
                    hintText: "Username",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
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
                  decoration: InputDecoration(
                    // border: OutlineInputBorder(
                    //     borderRadius: BorderRadius.circular(8.0),
                    //     borderSide: BorderSide()),
                    prefixIcon: Icon(Icons.person_outline),
                    hintText: "Email",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  key: ValueKey('password'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Incorrect Password.";
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.lock),
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      startauthentication();
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>AccCreated()));
                    });
                    
                  },
                  child: Text(
                    "Create",
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
              SizedBox(
                height: 10,
              ),
              Spacer(),
              Divider(thickness: 2),
              Text("Already have an account?"),
              SizedBox(
                height: 60,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Login",
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
      ),
    );
  }
}
