import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:hund_pvt/Services/imagepicker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
 final FirebaseAuth auth = FirebaseAuth.instance;
 FirebaseStorage storage = FirebaseStorage.instance;

 @override
  Widget build(BuildContext context) {

  return Scaffold(
    appBar: AppBar(
      centerTitle: true,
        title: Text("Settings"),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                Color(0xffDD5151), Color(0xff583177)
            ])          
         ),        
     ),      
 ),



 
 body:
 SingleChildScrollView(
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
          InkWell(
            child: Container(
              alignment: Alignment.center,
              child: FutureBuilder(
                future: _getImage(context, "profilePicture/"+auth.currentUser.uid),
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    if (snapshot.data==null){
                      return Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Image.asset("assets/images/standardpicture.png", height: 150),
                      );
                    }else {
                      return Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 1.2,
                        height: MediaQuery.of(context).size.width / 1.2,
                        child: snapshot.data,
                      );
                    }
                  }
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.width / 1.2,
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Container();
                }
            ),
            ),
           onTap: (){
             new PicPicker(uid: auth.currentUser.uid).getImage();
             setState(() {
             });
           },
         ),
       const SizedBox(height: 50.0),
       Text("Profile", style: TextStyle(
         fontSize:20.0,
         fontWeight: FontWeight.bold,
         color: Colors.red, //White text later
       ),),
         Column(
           children: <Widget>[
             ListTile(
               leading: Icon(Icons.account_circle),
               trailing: Icon(Icons.edit),
               title: Text(auth.currentUser.email),
               onTap: (){
                 Navigator.of(context).pushNamed('/editprofile');
               }
             ),
             
             ListTile(
               leading: Icon(Icons.lock_outline),
               title: Text("Change password"),
               trailing: Icon(Icons.keyboard_arrow_right), //add lock button icon
               onTap: (){
                 Navigator.of(context).pushNamed('/changepassword');
               }
             ),
             
             SwitchListTile(
              activeColor: Colors.grey, //white later
              value: true,
              title: Text("Notifications"),
              onChanged: (val){
                //Activate Notifications
              },
               ),
       
            const SizedBox(height: 10.0),
              Text("About DogApp", style: TextStyle(
              fontSize:20.0,
              fontWeight: FontWeight.bold,
              color: Colors.red, //White text later
               ),),
           
             ListTile(
                leading: Icon(Icons.chat_bubble),
                 title: Text("Contact us"),
                  onTap: () {
                  Navigator.of(context).pushNamed('/contactus');
                  },
               
             ),
           ],
         ),
       
       
           const SizedBox(height: 10.0),
           Text("Personal settings", style: TextStyle(
             fontSize:20.0,
             fontWeight: FontWeight.bold,
             color: Colors.red, //White text later
           ),),
       
           ListTile(
               leading: Icon(Icons.settings),
               title: Text("Manage location settings"),
               
              onTap: () =>  openAppSettings(),
            
             ),
             
       
          SwitchListTile(
            activeColor: Colors.grey, //white later
            value: true,
            title: Text("Day and night mode"),
            onChanged: (val){},
           ),

         ListTile(
               leading: Icon(Icons.help),
               title: Text("Help?"),
               trailing: Icon(Icons.keyboard_arrow_right), //add lock button icon
               onTap: (){
                 //Open help!
               }
             ),

      ListTile(
               leading: Icon(Icons.logout),
               title: Text("Log out"),
               trailing: Icon(Icons.keyboard_arrow_right), //add lock button icon
               onTap: (){
                 signOut();
                 Navigator.pushReplacementNamed(context, '/loginpage');
               }
             ),
    
    
         //App version
       Text("App version 1.0.0",
         textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
          ),

     ],
   ),
 ),
  );
  

  }

  Future <bool> signOut () async {
   try {
     await auth.signOut();
     return true;
   } catch (FireBaseAuthException){
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

