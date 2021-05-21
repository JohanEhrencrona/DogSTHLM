import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';
import 'package:permission_handler/permission_handler.dart';

class Settings extends StatelessWidget {
 static final String path = "lib/src/pages/settings.dart";
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
 


 
 body: SingleChildScrollView(
   child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
       
       const SizedBox(height: 50.0),
       Text("Profile", style: TextStyle(
         fontSize:20.0,
         fontWeight: FontWeight.bold,
         color: Colors.red, //White text later
         ),),       

          ListTile(
           onTap: (){
             //Open edit profile
           },
            trailing: CircleAvatar(
            radius:20,
            backgroundColor: Colors.grey.shade500,
            child: IconButton(     
              icon: Icon(
                Icons.edit, color: Colors.white, size:15,),
            alignment: Alignment.topRight,
            onPressed:(){
              //what happens after press
            }
            )
           ),
         ),
       
         Column(
           children: <Widget>[
             ListTile(
               leading: Icon(Icons.account_circle),
               title: Text("example@gmail.com"),
               onTap: (){
                 //what does it do?
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

}

//Settings colors (need to fix topBar)
