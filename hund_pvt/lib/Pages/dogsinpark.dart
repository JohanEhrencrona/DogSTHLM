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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Dogs in the park right now"),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: widget.currentLoc.dogsInPark.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {},
                title: Text(widget.currentLoc.dogsInPark[index].name),
                subtitle: Text(widget.currentLoc.dogsInPark[index].race),
                trailing: Text('Age: ' +
                    widget.currentLoc.dogsInPark[index].age.toString()),
              ),
            );
          }),
    );
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
