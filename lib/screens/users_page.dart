import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/screens/user_detail_page.dart';
import 'package:linnefromice/services/user_service.dart';

final List datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/1/11/Zidane_Tribal_character.png/revision/latest/scale-to-width-down/84?cb=20120811142151"
  },
  {
    "name": "Dagger",
    "rating": 4,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/e/e8/Garnet_Til_Alexandros_XVII_character.jpg/revision/latest/scale-to-width-down/55?cb=20130321045317"
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/b/b5/Vivi_Ornitier_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/94?cb=20200516160037"
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/3/3f/Adelbert_Steiner_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/104?cb=20200523163741"
  },
  {
    "name": "Amarant Coral",
    "rating": 4,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/8/80/Amarant_Coral_character.jpg/revision/latest/scale-to-width-down/85?cb=20130321014600"
  },
  {
    "name": "Freya Crescent",
    "rating": 3,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/5/5c/Freya_Crescent_character.jpg/revision/latest/scale-to-width-down/170?cb=20130321024835"
  },
  {
    "name": "Quina Quen",
    "rating": 3,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/d/df/Quina_Quen_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/144?cb=20200521042616"
  },
  {
    "name": "Eiko Carol",
    "rating": 5,
    "isFriend": true,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/f/fc/Eiko_Carol_character.jpg/revision/latest/scale-to-width-down/82?cb=20130321013026"
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
    this.avatarUrl,
  }) : super(key: key);
  final String name;
  final int rating;
  final bool isFriend;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => UserDetailPage(
            user: User(name: name, rating: rating, avatarUrl: avatarUrl, isFriend: isFriend)
          )
        )
      ),
      leading: CircleAvatar(
        child: avatarUrl == null || avatarUrl == "" ? Text(
          name.characters.first,
          style: TextStyle(color: Colors.white),
        ) : null,
        backgroundColor: avatarUrl == null || avatarUrl == "" ? Colors.grey : null,
        backgroundImage: !(avatarUrl == null || avatarUrl == "") ? NetworkImage(avatarUrl) : null,
      ),
      title: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Row(
        children: [
          RatedHeart(rate: min(1, max(0, rating.toDouble() - 0)), size: 30), // origin -> Icon(Icons.favorite, size: 30, color: rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white)
          RatedHeart(rate: min(1, max(0, rating.toDouble() - 1)), size: 30),
          RatedHeart(rate: min(1, max(0, rating.toDouble() - 2)), size: 30),
          RatedHeart(rate: min(1, max(0, rating.toDouble() - 3)), size: 30),
          RatedHeart(rate: min(1, max(0, rating.toDouble() - 4)), size: 30),
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

class _UserList extends StatelessWidget {
  _UserList({
    Key key,
    this.hasConnectivity
  }) : super(key: key);

  final bool hasConnectivity;
  final userService = UserService();

  Column _buildContents(AsyncSnapshot<List<User>> snapshot) {
    return Column(
      children: snapshot.data.map((value) => _UserListTile(
        name: value.name,
        rating: value.rating,
        isFriend: value.isFriend,
        avatarUrl: hasConnectivity ? value.avatarUrl : null,
      )).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: userService.findUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.data == null) {
          return Center(child: Text("NO DATA"));
        }
        return _buildContents(snapshot);
      },
    );
  }
}

class UsersPage extends HookWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final Connectivity _connectivity = Connectivity();

  Widget _buildHeader({final ValueNotifier valueNotifier, final TextEditingController textEditingController}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: () { // does not work...
                  print(textEditingController.text);
                  final text = textEditingController.text;
                  final results = List();
                  valueNotifier.value((v) {
                    if (v["name"].contains(text)) results.add(v);
                  });
                  valueNotifier.value = results;
                  print(results);
                },
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
    final ValueNotifier _datas = useState(datas);
    final TextEditingController textEditingController = useTextEditingController();
    final hasConnectivityController = useStreamController<bool>(keys: ["hasConnectivity"]);

    useEffect(
      () {
        _connectivity.checkConnectivity().then((result) async {
          switch (result) {
            case ConnectivityResult.wifi:
            case ConnectivityResult.mobile:
              hasConnectivityController.add(true);
              break;
            case ConnectivityResult.none:
              hasConnectivityController.add(false);
              break;
          }
        }).catchError((e) => hasConnectivityController.addError(e));
        return null;
      }, [hasConnectivityController, ["hasConnectivity"]]
    );

    return Scaffold(
      body: WrapperCommonBackground(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            _buildHeader(
              valueNotifier: _datas,
              textEditingController: textEditingController
            ),
            Expanded(
              child: SingleChildScrollView(
                child: HookBuilder(
                  builder: (context) {
                    // final AsyncSnapshot<bool> hasConnectivity = useStream(hasConnectivityController.stream); // if use useEffect & useStreamController
                    final AsyncSnapshot<bool> hasConnectivity = useFuture(_connectivity.checkConnectivity().then((value) {
                      switch (value) {
                        case ConnectivityResult.wifi:
                        case ConnectivityResult.mobile:
                          return true;
                        case ConnectivityResult.none:
                        default:
                          return false;
                      }
                    }));
                    return !hasConnectivity.hasData
                        ? CircularProgressIndicator()
                        : _UserList(hasConnectivity: hasConnectivity.data);
                  }
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