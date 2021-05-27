import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:hund_pvt/Services/getmarkersfromapi.dart';

class DogsInPark extends StatefulWidget {
  final LocationPark currentLoc;

  DogsInPark({this.currentLoc});

  @override
  DogsInParkState createState() => DogsInParkState();
}

class DogsInParkState extends State<DogsInPark> {
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
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              title: Text("Dogs in the park right now"),
              centerTitle: true,
            ),
            body: Center(
                child: SingleChildScrollView(
//                    padding: EdgeInsets.only(left: 25),
                    child: Container(
                        alignment: Alignment.topCenter,
                        width: 340,
//                        height: 600,
                        height: 1000,
                        child: ListView.builder(
                          itemCount: widget.currentLoc.dogsInPark.length,
                          itemBuilder: (context, index) {
                            return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                color: Color(0x22000000),
                                shadowColor: Colors.transparent,
                                child: ListTile(
                                  onTap: () {},
                                  title: Text(
                                      widget.currentLoc.dogsInPark[index].name,
                                      style: TextStyle(color: Colors.white)),
                                  subtitle: Text(
                                    widget.currentLoc.dogsInPark[index].race,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  trailing: Text(
                                    'Age: ' +
                                        widget.currentLoc.dogsInPark[index].age
                                            .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ));
                          },
                        ))))));
  }
}

Future<Widget> _getImage(BuildContext context, String imageName) async {
  Image image;
  await FireStorageService.loadImage(context, imageName).then((value) {
    image = Image.network(value.toString(), fit: BoxFit.scaleDown);
  });
  return image;
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();
  static Future<dynamic> loadImage(BuildContext context, String Image) async {
    return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
  }
}
