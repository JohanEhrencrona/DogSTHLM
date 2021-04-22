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
    return Scaffold(
        appBar: AppBar(
          title: Text('Filter'),
        ),
        body: ListView.builder(
          itemCount: checkBoxListTileModel.length,
          itemBuilder: (BuildContext context, int index) {
            return new Card(
                child: new Container(
              padding: new EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  new CheckboxListTile(
                    activeColor: Colors.red,
                    dense: true,
                    title: Text(checkBoxListTileModel[index].filtername),
                    value: checkBoxListTileModel[index].isChecked,
                    secondary: Container(
                      height: 50,
                      width: 50,
                    ),
                    onChanged: (bool val) {
                      itemChange(val, index);
                    },
                  )
                ],
              ),
            ));
          },
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

  CheckBoxListTileModel({this.filtername, this.isChecked});

  static List<CheckBoxListTileModel> getFilters() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(filtername: 'Skräpkorgar', isChecked: true),
      CheckBoxListTileModel(filtername: 'Hundparker', isChecked: false),
      CheckBoxListTileModel(filtername: 'Placeholder', isChecked: false),
      CheckBoxListTileModel(filtername: 'Placeholder', isChecked: false),
      CheckBoxListTileModel(filtername: 'Placeholder', isChecked: false),
      CheckBoxListTileModel(filtername: 'Placeholder', isChecked: false),
      CheckBoxListTileModel(filtername: 'Placeholder', isChecked: false),
    ];
  }
}
