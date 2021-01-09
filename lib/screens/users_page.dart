import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

final List datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
  },
  {
    "name": "Dagger",
    "rating": 4,
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
  },
  {
    "name": "Kuja",
    "rating": 5,
  },
];

class UsersPage extends HookWidget {
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: Text("Search..."),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextField(
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () {},
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white, width: 0.0),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              )
            )
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(100, (index) => Text("${(index+1).toString()} ${datas[index % 5]["name"]}"))
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        )
      ),
    );
  }
}