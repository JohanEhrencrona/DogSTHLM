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
                    title: Text(checkBoxListTileModel[index].filter),
                    value: checkBoxListTileModel[index].isChecked,
                    secondary: Container(
                      height: 50,
                      width: 50,
                    ),
                    onChanged: (bool val) {
                      //itemChange(val, index);
                    },
                  )
                ],
              ),
            ));
          },
        ));
  }
}

class CheckBoxListTileModel {
  String filter;
  bool isChecked;

  CheckBoxListTileModel({this.filter, this.isChecked});

  static List<CheckBoxListTileModel> getFilters() {
    return <CheckBoxListTileModel>[
      CheckBoxListTileModel(filter: 'Skräpkorgar', isChecked: true),
      CheckBoxListTileModel(filter: 'Hundparker', isChecked: false),
    ];
  }
}
