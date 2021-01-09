import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

final List datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
    "isFriend": true,
  },
  {
    "name": "Dagger",
    "rating": 4,
    "isFriend": true,
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
    "isFriend": true,
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
    "isFriend": true,
  },
  {
    "name": "Amarant Coral",
    "rating": 4,
    "isFriend": true,
  },
  {
    "name": "Freya Crescent",
    "rating": 3,
    "isFriend": true,
  },
  {
    "name": "Quina Quen",
    "rating": 3,
    "isFriend": true,
  },
  {
    "name": "Eiko Carol",
    "rating": 5,
    "isFriend": true,
  },
  {
    "name": "Kuja",
    "rating": 5,
    "isFriend": false,
  },
  {
    "name": "Queen Brahne",
    "rating": 4,
    "isFriend": false,
  },
  {
    "name": "Zorn and Thorn",
    "rating": 5,
    "isFriend": false,
  },
  {
    "name": "Garland",
    "rating": 3,
    "isFriend": false,
  },
  {
    "name": "Necron",
    "rating": 3,
    "isFriend": false,
  },
];

class _UserListTile extends StatelessWidget {
  _UserListTile({
    Key key,
    this.name,
    this.rating,
    this.isFriend,
  }) : super(key: key);
  final String name;
  final int rating;
  final bool isFriend;

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
      trailing: isFriend ? RaisedButton(
        child: Text(
          "Friend",
          style: TextStyle(color: Colors.orange),
        ),
        shape: StadiumBorder(),
        color: Colors.white,
        onPressed: () => {},
      ) : OutlineButton(
        child: Text(
          "+ Friend",
          style: TextStyle(color: Colors.white),
        ),
        shape: StadiumBorder(),
        onPressed: () {},
      )
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
                  children: List.generate(datas.length, (index) => _UserListTile(
                    name: datas[index]["name"],
                    rating: datas[index]["rating"],
                    isFriend: datas[index]["isFriend"],
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