import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';

final List datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/1/11/Zidane_Tribal_character.png/revision/latest/scale-to-width-down/84?cb=20120811142151"
  },
  {
    "name": "Dagger",
    "rating": 4,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/e/e8/Garnet_Til_Alexandros_XVII_character.jpg/revision/latest/scale-to-width-down/55?cb=20130321045317"
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/b/b5/Vivi_Ornitier_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/94?cb=20200516160037"
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/3/3f/Adelbert_Steiner_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/104?cb=20200523163741"
  },
  {
    "name": "Amarant Coral",
    "rating": 4,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/8/80/Amarant_Coral_character.jpg/revision/latest/scale-to-width-down/85?cb=20130321014600"
  },
  {
    "name": "Freya Crescent",
    "rating": 3,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/5/5c/Freya_Crescent_character.jpg/revision/latest/scale-to-width-down/170?cb=20130321024835"
  },
  {
    "name": "Quina Quen",
    "rating": 3,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/d/df/Quina_Quen_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/144?cb=20200521042616"
  },
  {
    "name": "Eiko Carol",
    "rating": 5,
    "isFriend": true,
    "image": "https://static.wikia.nocookie.net/finalfantasy/images/f/fc/Eiko_Carol_character.jpg/revision/latest/scale-to-width-down/82?cb=20130321013026"
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
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

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
      floatingActionButton: Builder(
          builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}