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
            centerTitle: true,
            title: Text('Contact Us'),
          ),
        ),
      );
  
  
  
  }
  }
  
  