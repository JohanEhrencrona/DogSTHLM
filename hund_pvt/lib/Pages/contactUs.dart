import 'package:flutter/material.dart';


class ContactUs extends StatefulWidget {
  @override
  ContactUsState createState() => ContactUsState();
}
  
  class ContactUsState extends State<ContactUs> {
    @override
    Widget build(BuildContext context) {
      return Container(
        decoration: BoxDecoration(gradient: 
                LinearGradient(begin:
                Alignment.topCenter, end: Alignment.bottomCenter, colors: 
                <Color>[
                  Color(0xffDD5151), Color(0xff583177)
                ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            centerTitle: true,
            title: Text('Contact Us', style: TextStyle(letterSpacing: 2)),
          ),
          body: Padding(
            padding: EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                  "Support",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                ),
                Text(
                  "Are you having trouble with the app? Contact us at dogAppSuport@gmail.com and we will offer you help as soon as possible.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10, top: 20),
                  child: Text(
                  "Feedback",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                ),
                Text(
                  "Do you feel like something needs a little tweak or improvement? Please contact us at dogAppFeedback@gmail.com with your suggestions.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Image.asset(
            "assets/images/Dog_siluette.png",
            height: 150,
            color: Color(0x22000000)
            ),
        ),
      );
  
  
  
  }
  }
  
  