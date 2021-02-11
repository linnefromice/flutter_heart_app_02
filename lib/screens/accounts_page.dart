import 'dart:math';

import 'package:connectivity/connectivity.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/screens/account_detail_page.dart';
import 'package:linnefromice/services/account_service.dart';

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

class _AccountListTile extends StatelessWidget {
  _AccountListTile({
    Key key,
    this.name,
    this.description,
    this.rating,
    this.isFriend,
    this.avatarUrl,
  }) : super(key: key);
  final String name;
  final String description;
  final double rating;
  final bool isFriend;
  final String avatarUrl;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AccountDetailPage(
            account: Account(name: name, description: description, rating: rating, avatarUrl: avatarUrl, isFriend: isFriend)
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
          RatedHeart(rate: min(1, max(0, rating - 0)), size: 30), // origin -> Icon(Icons.favorite, size: 30, color: rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white)
          RatedHeart(rate: min(1, max(0, rating - 1)), size: 30),
          RatedHeart(rate: min(1, max(0, rating - 2)), size: 30),
          RatedHeart(rate: min(1, max(0, rating - 3)), size: 30),
          RatedHeart(rate: min(1, max(0, rating - 4)), size: 30),
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

class _AccountList extends StatelessWidget {
  _AccountList({
    Key key,
    this.hasConnectivity
  }) : super(key: key);

  final bool hasConnectivity;
  final accountService = AccountService();

  Column _buildContents(AsyncSnapshot<List<Account>> snapshot) {
    return Column(
      children: snapshot.data.map((value) => _AccountListTile( // TODO: use Account
        name: value.name,
        description: value.description,
        rating: value.rating,
        isFriend: value.isFriend,
        avatarUrl: hasConnectivity ? value.avatarUrl : null,
      )).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Account>>(
      future: accountService.findAccounts(),
      builder: (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
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

class _Contents extends HookWidget {
  Widget _buildHeader({final TextEditingController textEditingController}) {
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
                onPressed: () { },
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
    final TextEditingController textEditingController = useTextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        _buildHeader(textEditingController: textEditingController),
        Expanded(
          child: SingleChildScrollView(
            child: _AccountList(hasConnectivity: true)
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}

class AccountsPage extends HookWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final Connectivity _connectivity = Connectivity();

  @override
  Widget build(BuildContext context) {
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
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Loading ...")
                  ],
                )
              : _Contents();
          }
        )
      ),
      floatingActionButton: Builder(
          builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}