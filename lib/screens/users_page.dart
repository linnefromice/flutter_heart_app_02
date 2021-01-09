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
    "name": "Amarant Coral",
    "rating": 4,
  },
  {
    "name": "Freya Crescent",
    "rating": 3,
  },
  {
    "name": "Quina Quen",
    "rating": 3,
  },
  {
    "name": "Eiko Carol",
    "rating": 5,
  },
  {
    "name": "Kuja",
    "rating": 5,
  },
  {
    "name": "Queen Brahne",
    "rating": 4,
  },
  {
    "name": "Zorn and Thorn",
    "rating": 5,
  },
  {
    "name": "Garland",
    "rating": 3,
  },
  {
    "name": "Necron",
    "rating": 3,
  },
];

class _UserListTile extends StatelessWidget {
  _UserListTile({
    Key key,
    this.idx,
    this.name,
    this.rating,
  }) : super(key: key);
  final int idx;
  final String name;
  final int rating;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          name.characters.first,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey,
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Row(
        children: [
          Icon(Icons.favorite, size: 30, color: rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
          Icon(Icons.favorite, size: 30, color: rating >= 2 ? Colors.pink.withOpacity(0.5) : Colors.white),
          Icon(Icons.favorite, size: 30, color: rating >= 3 ? Colors.pink.withOpacity(0.5) : Colors.white),
          Icon(Icons.favorite, size: 30, color: rating >= 4 ? Colors.pink.withOpacity(0.5) : Colors.white),
          Icon(Icons.favorite, size: 30, color: rating >= 5 ? Colors.pink.withOpacity(0.5) : Colors.white),
        ],
      ),
      trailing: RaisedButton(
        child: Text("Friend"),
      ) ,
    );
  }
}

class UsersPage extends HookWidget {
  Widget _buildHeader() {
    return Column(
      children: [
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
                  children: List.generate(100, (index) => _UserListTile(
                    idx: index,
                    name: datas[index % 5]["name"],
                    rating: datas[index % 5]["rating"],
                  ))
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