import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/imagepicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  TextStyle _style = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Color(0xffDD5151), Color(0xff583177)])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: Text("Profile", style: TextStyle(letterSpacing: 2)),
            centerTitle: true,
        ),
        body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              child: Container(
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: _getImage(
                        context, "profilePicture/" + auth.currentUser.uid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Image.asset(
                                "assets/images/standardpicture.png",
                                color: Colors.white,
                                height: 150),
                          );
                        } else {
                          return Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 1.2,
                            height: MediaQuery.of(context).size.width / 1.2,
                            child: snapshot.data,
                          );
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.width / 1.2,
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Container();
                    }),
              ),
              onTap: () async {
                await new PicPicker(uid: auth.currentUser.uid).getImage();
                Timer(Duration(seconds: 2), () {
                  setState(() {});
                });
                //WidgetsBinding.instance.addPostFrameCallback((_) => setState);
              },
            ),
            const SizedBox(height: 25.0),
//----------------------------------------------------PROFILE PIC END---------------------------------------------------------
            Padding(
              padding: EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 10, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ListTile(
                    tileColor: Color(0x22000000),
                    leading: Icon(Icons.account_circle, color: Colors.white),
                    trailing: Icon(Icons.edit, color: Colors.white),
                    title: Text(auth.currentUser.email, style: _style),
                    onTap: () {
                      Navigator.of(context).pushNamed('/editprofile');
                    }),
                ListTile(
                    tileColor: Color(0x22000000),
                    leading: Icon(Icons.lock_outline, color: Colors.white),
                    title: Text("Change password", style: _style),
                    trailing:
                        Icon(Icons.keyboard_arrow_right, color: Colors.white), //add lock button icon
                    onTap: () {
                      Navigator.of(context).pushNamed('/changepassword');
                    }),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  child: Text(
                  "About DogApp",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white, 
                  ),
                ),
                ),
                ListTile(
                    tileColor: Color(0x22000000),
                  leading: Icon(Icons.chat_bubble, color: Colors.white),
                  title: Text("Contact us/help", style: _style),
                  onTap: () {
                    Navigator.of(context).pushNamed('/contactus');
                  },
                ),
              

            const SizedBox(height: 10.0),
            Padding(
              padding: EdgeInsets.only(bottom: 10, top: 20),
              child: Text(
              "Personal settings",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white, 
              ),
            ),
            ),

            ListTile(
              tileColor: Color(0x22000000),
              leading: Icon(Icons.settings, color: Colors.white),
              title: Text("Manage location settings", style: _style),
              onTap: () => openAppSettings(),
            ),

            /*SwitchListTile(
              tileColor: Color(0x22000000),
              activeColor: Colors.white,
              value: true,
              title: Text("Day and night mode", style: _style),
              onChanged: (val) {},
            ),*/

            /*ListTile(
                tileColor: Color(0x22000000),
                leading: Icon(Icons.help, color: Colors.white),
                title: Text("Help?", style: _style),
                trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.white), //add lock button icon
                onTap: () {
                  //Open help!
                }),*/

            ListTile(
                tileColor: Color(0x22000000),
                leading: Icon(Icons.logout, color: Colors.white),
                title: Text("Log out", style: _style),
                trailing:
                    Icon(Icons.keyboard_arrow_right, color: Colors.white), //add lock button icon
                onTap: () {
                  signOut();
                  Navigator.pushReplacementNamed(context, '/loginpage');
                }),

            //App version
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
              "App version 1.0.0",
              textAlign: TextAlign.center,
              style: _style,
            ),
            ),
            ],
            )),
          ],
        ),
      ),
      ),
    );
  }

  Future<bool> signOut() async {
    try {
      await auth.signOut();
      return true;
    } catch (FireBaseAuthException) {
      return false;
    }
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(value.toString(), fit: BoxFit.scaleDown);
    });
    return image;
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
