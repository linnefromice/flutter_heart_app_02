import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/screens/evaluate_page.dart';
import 'package:linnefromice/services/user_service.dart';

final List datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/1/11/Zidane_Tribal_character.png/revision/latest/scale-to-width-down/84?cb=20120811142151"
  },
  {
    "name": "Dagger",
    "rating": 4,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/e/e8/Garnet_Til_Alexandros_XVII_character.jpg/revision/latest/scale-to-width-down/55?cb=20130321045317"
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/b/b5/Vivi_Ornitier_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/94?cb=20200516160037"
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
    "avatarUrl": "https://static.wikia.nocookie.net/finalfantasy/images/3/3f/Adelbert_Steiner_from_Final_Fantasy_IX_render.png/revision/latest/scale-to-width-down/104?cb=20200523163741"
  },
  {
    "name": "Kuja",
    "rating": 5,
  },
];

class HomePage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: StreamBuilder<List<User>>(
          stream: userService.streamUsers(),
          builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.data == null) {
              return Center(child: Text("NO DATA"));
            }
            return _Content(
              users: snapshot.data,
            );
          },
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}

class _Content extends HookWidget {
  _Content({
    Key key,
    this.users,
  }) : super(key: key);

  final List<User> users;
  final int _initialPageIndex = 0;

  Widget _buildPagingButton({final double minWidth, final double height, final IconData iconData, final Function onPressed}) {
    return ButtonTheme(
      minWidth: minWidth,
      height: height,
      child: RaisedButton(
        child: Icon(
          iconData,
          color: Colors.white,
        ),
        color: Colors.transparent,
        shape: CircleBorder(),
        onPressed: onPressed
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = usePageController(
      initialPage: _initialPageIndex,
      viewportFraction: 0.5,
    );
    final _name = useState(users[_initialPageIndex].name);
    final _rating = useState(users[_initialPageIndex].rating);

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: users.map((User user) => _ContentAvatar(
            user: user,
          )).toList(),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.55,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPagingButton(
                minWidth: 50,
                height: 50,
                iconData: Icons.arrow_back,
                onPressed: () {
                  final int nextPageIndex = _pageController.page.toInt() - 1;
                  _pageController.animateToPage(
                    nextPageIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  _name.value = users[nextPageIndex].name;
                  _rating.value = users[nextPageIndex].rating;
                }
              ),
              SizedBox(width: 200),
              _buildPagingButton(
                minWidth: 50,
                height: 50,
                iconData: Icons.arrow_forward,
                onPressed: () {
                  final int nextPageIndex = _pageController.page.toInt() + 1;
                  _pageController.animateToPage(
                    nextPageIndex,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                  _name.value = users[nextPageIndex].name;
                  _rating.value = users[nextPageIndex].rating;
                }
              ),
            ],
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.65,
          left: 0,
          right: 0,
          child: Center(
            child: Text(_name.value, style: TextStyle(color: Colors.red)),
          )
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.70,
          left: 0,
          right: 0,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatedHeart(rate: min(1, max(0, _rating.value.toDouble() - 0)), size: 30), // origin -> Icon(Icons.favorite, size: 50, color: _rating.value >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white)
                RatedHeart(rate: min(1, max(0, _rating.value.toDouble() - 1)), size: 30),
                RatedHeart(rate: min(1, max(0, _rating.value.toDouble() - 2)), size: 30),
                RatedHeart(rate: min(1, max(0, _rating.value.toDouble() - 3)), size: 30),
                RatedHeart(rate: min(1, max(0, _rating.value.toDouble() - 4)), size: 30),
              ],
            )
          )
        )
      ],
    );
  }
}

class _ContentAvatar extends StatelessWidget {
  _ContentAvatar({
    Key key,
    this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EvaluatePage(user: user)
        )
      ),
      child: Container(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[100],
              Colors.deepOrange[100],
            ],
          ),
        ),
        child: FractionallySizedBox(
          alignment: Alignment.topCenter,
          widthFactor: 0.7,
          child: CircleAvatar(
            maxRadius: 30,
            child: !(user.avatarUrl == null || user.avatarUrl == "") ? null : Text(user.name, style: TextStyle(color: Colors.red)),
            backgroundColor: user.avatarUrl == null || user.avatarUrl == "" ? Colors.white : null,
            backgroundImage: !(user.avatarUrl == null || user.avatarUrl == "") ? NetworkImage(user.avatarUrl) : null,
          )
        ),
      ),
    );
  }
}