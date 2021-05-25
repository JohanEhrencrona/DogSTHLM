import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  FilterScreenState createState() => FilterScreenState();
}

List<CheckBoxListTileModel> checkBoxListTileModel =
    CheckBoxListTileModel.getFilters();

class FilterScreenState extends State<FilterScreen> {
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
              centerTitle: true,
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              title: Text(
                'Filter',
                style: TextStyle(letterSpacing: 5),
              ),
            ),
            body: ListView.builder(
              padding: EdgeInsets.all(15),
              itemCount: checkBoxListTileModel.length,
              itemBuilder: (BuildContext context, int index) {
                return new Card(
                  shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                  shadowColor: Colors.transparent,
                    color: Color(0x22000000),
                    child: new Container(
                      padding: new EdgeInsets.all(8),
                      child: Column(
                        children: <Widget>[
                          Theme(
                              //Gör så att man får vita borders på checkboxarna
                              data: ThemeData(
                                  unselectedWidgetColor:
                                      Colors.white), //vita färgen väljs
                              child: new CheckboxListTile(
                                activeColor: Colors.transparent,
                                checkColor: Colors.white,
                                dense: false,
                                title: Text(
                                  checkBoxListTileModel[index].filtername,
                                  style: TextStyle(color: Colors.white),
                                ),
                                value: checkBoxListTileModel[index].isChecked,
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                secondary: ImageIcon(
                                  checkBoxListTileModel[index].imageTest,
                                  color: Colors.white,
                                ),
                                onChanged: (bool val) {
                                  itemChange(val, index);
                                },
                              ))
                        ],
                      ),
                    ));
              },
            ),
            bottomNavigationBar: Image.asset(
            "assets/images/Dog_siluette.png",
            height: 150,
            color: Color(0x22000000)
            ),
            ));
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isChecked = val;
    });
  }
}

class CheckBoxListTileModel {
  String filtername;
  bool isChecked;
  AssetImage imageTest;

  CheckBoxListTileModel({this.filtername, this.isChecked, this.imageTest});

  static List<CheckBoxListTileModel> getFilters() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(
          filtername: 'Waste bins',
          isChecked: false,
          imageTest: AssetImage("assets/images/trashcan_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Dog parks',
          isChecked: false,
          imageTest: AssetImage("assets/images/dog_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Veterinarians',
          isChecked: false,
          imageTest: AssetImage("assets/images/veterinary_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Cafés',
          isChecked: true,
          imageTest: AssetImage("assets/images/cafe_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Restaurants',
          isChecked: false,
          imageTest: AssetImage("assets/images/restaurant_symbol.png")),
      CheckBoxListTileModel(
          filtername: 'Pet shops',
          isChecked: false,
          imageTest: AssetImage("assets/images/bone_symbol.png")),
    ];
  }
}
