import 'package:firebase_auth/firebase_auth.dart';
import 'package:hund_pvt/Pages/registration_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hund_pvt/Services/userdatabase.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
        child: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 70, top: 171),
                child: Text("Welcome!", style: TextStyle(letterSpacing: 5, color: Colors.white, fontSize: 25))),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Image.asset("assets/images/Dog_siluette.png", height: 150),
                ),
              Container(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Form(
                        autovalidateMode: AutovalidateMode.always, key: _formStateKey,
                        child: Column(
                          children: <Widget>[
//--------------------------------------------FIRST-----------------------------------------------------------
                            Padding(
                              padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 10),
                              child: Container(
                                width: 320,
                                child: TextFormField(
                                style: TextStyle(color: Colors.white),
                                validator: validateEmail,
                                onSaved: (value) {
                                  _emailId = value;
                                },
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailIdController,
                                
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))

                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  labelText: "Email",
                                  icon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  //fillColor: Colors.white,
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ),
                            ),
//--------------------------------------------------SECOND-------------------------------------------------------------
                            Padding(
                              padding:
                              EdgeInsets.only(left: 10, right: 10, bottom: 5),
                              child: Container(
                                width: 320,
                                child: TextFormField(
                                validator: validatePassword,
                                style: TextStyle(color: Colors.white),
                                onSaved: (value) {
                                  _password = value;
                                },
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  fillColor: Color(0x22000000),
                                  filled: true,
                                  errorStyle: TextStyle(color: Colors.white),
                                  errorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  
                                  ),
                                  focusedErrorBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                    
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.transparent),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                  ),
                                  labelText: "Password",
                                  icon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              ),
                            ),
//-------------------------------------------------------ENDS OF FIELDS---------------------------------------------------------
                          ],
                        ),
                      ),
                      (errorMessage != ''
                          ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                          : Container()),
                      ButtonBarTheme(
                        data: ButtonBarThemeData(buttonTextTheme: ButtonTextTheme.accent),
                        child: ButtonBar(

                          alignment: MainAxisAlignment.start,
                          children: <Widget>[
//---------------------------------------------CREATING SOME ROOM------------------------------------------------------
                            Container(
                              width: 50,
                            ),
                            // ignore: deprecated_member_use
//-----------------------------------------SIGN IN BUTTON----------------------------------------------------------------
                            SizedBox(
                              height: 40, 
                              width: 100,
                              child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0x22000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Sign in',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              onPressed: () {
                                if (_formStateKey.currentState.validate()) {
                                  _formStateKey.currentState.save();
                                  signIn(_emailId, _password).then((user) {
                                    if (user != null) {
                                      print('Logged in successfully.');
                                      setState(() {
                                        successMessage =
                                        'Logged in successfully.';
                                      });
                                      Navigator.pushReplacementNamed(context, '/loading');
                                    } else {
                                      setState(() {
                                        successMessage =
                                        'Incorrect email or password.';
                                      });
                                    }
                                  });
                                }
                              },
                            ),
                            ),
                           
//---------------------------------------CREATING SOME ROOM------------------------------------------------------------
                            Container(
                              width: 65,
                            ),
//---------------------------------------REGISTER BUTTON-----------------------------------------------
                            SizedBox(
                              height: 40,
                              width: 100,
                              child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0x22000000),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                )),
                              onPressed: () { 
                                Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => RegistrationPage(),
                                ),
                              );
                               },
                            ),
                            ),
                            
//-------------------------------------------END OF REGISTER BUTTON-------------------------------------------------
                            // ignore: deprecated_member_use
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (successMessage != ''
                  ? Text(
                successMessage,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Colors.white),
              )
                  : Container()),
              (!isGoogleSignIn
                  // ignore: deprecated_member_use
                  ? TextButton(
                    
                child: Text('Sign in with Google', style: TextStyle(color: Colors.white)),
                style: TextButton.styleFrom(
                  backgroundColor: Color(0x22000000),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  googleSignin(context).then((user) {
                    if (user != null) {
                      print('Logged in successfully.');
                      setState(() {
                        isGoogleSignIn = true;
                        successMessage =
                        'Logged in successfully.\nEmail : ${user.email}';
                      });
                      Navigator.pushReplacementNamed(context, '/loading');
                    } else {
                      print('Error');
                    }
                  });
                },
              )
                  // ignore: deprecated_member_use
                  : RaisedButton(
                child: Text('Sign out'),
                onPressed: () {
                  googleSignout().then((response) {
                    if (response) {
                      setState(() {
                        isGoogleSignIn = false;
                        successMessage = '';
                      });
                    }
                  });
                },
              )),
              Container(
                height: 94,
              ),
            ],
          )
        ),
      ),
      );
  }

  Future<User> signIn(String email, String password) async {
    try {
      User user = (await auth.signInWithEmailAndPassword( //_CastError HERE
          email: email, password: password)).user;
      assert(user != null);
      assert(await user.getIdToken() != null);
      final User currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);

      return user;
    } catch (FirebaseAuthException) {
      handleError(FirebaseAuthException);
      return null;
    }
  }

  Future<User> googleSignin(BuildContext context) async {
    User currentUser;
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,);

      final User user = (await auth.signInWithCredential(credential)).user; // _CastError here
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);
    } catch (FirebaseAuthException) {
      handleError(FirebaseAuthException);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }




  handleError(FirebaseAuthException error) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Unable to sign in'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('The email or password is incorrect'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please enter a valid email';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length<6) {
      return 'Enter a valid password';
    }
    return null;
  }

  String validateString(String value) {
    if (value.trim().isEmpty) {
      return 'Cant be empty';
    }
    return null;
  }
}