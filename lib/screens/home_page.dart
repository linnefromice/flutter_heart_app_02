import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
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

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<HomePage> {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  PageController _pageController;
  String _name;
  int _rating;
  final int _initialPageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(
      initialPage: _initialPageIndex,
      viewportFraction: 0.5,
    );
    _name = datas[_initialPageIndex]["name"];
    _rating = datas[_initialPageIndex]["rating"];
  }

  Widget _buildPageWidget({final String name}) {
    return Container(
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
              child: Text(name, style: TextStyle(color: Colors.red)),
              backgroundColor: Colors.white,
            )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: List.generate(datas.length, (index) {
                final user = datas[index];
                return _buildPageWidget(name: user["name"]);
              }),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.55,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    child: RaisedButton(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      onPressed: () {
                        final int nextPageIndex = _pageController.page.toInt() - 1;
                        _pageController.animateToPage(
                          nextPageIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(() {
                          _name = datas[nextPageIndex]["name"];
                          _rating = datas[nextPageIndex]["rating"];
                        });
                      }
                    ),
                  ),
                  SizedBox(width: 200),
                  ButtonTheme(
                    minWidth: 50,
                    height: 50,
                    child: RaisedButton(
                      child: Icon(Icons.arrow_forward, color: Colors.white,),
                      color: Colors.transparent,
                      shape: CircleBorder(),
                      onPressed: () {
                        final int nextPageIndex = _pageController.page.toInt() + 1;
                        _pageController.animateToPage(
                          nextPageIndex,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                        setState(() {
                          _name = datas[nextPageIndex]["name"];
                          _rating = datas[nextPageIndex]["rating"];
                        });
                      }
                    ),
                  )
                ],
              )
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: Center(
                child: Text(_name, style: TextStyle(color: Colors.red)),
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
                    Icon(Icons.favorite, size: 50, color: _rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating >= 2 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating >= 3 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating >= 4 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating >= 5 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  ],
                )
              )
            )
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => _FabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}

class _FabCircularMenu extends StatelessWidget {
  _FabCircularMenu({
    Key key,
    this.fabKey,
  }) : super(key: key);

  final GlobalKey<FabCircularMenuState> fabKey;

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomCenter,
      ringColor: Colors.red.withOpacity(0.5),
      fabColor: Colors.red.withOpacity(0.5),
      fabOpenIcon: Icon(Icons.menu, color: Colors.white),
      fabCloseIcon: Icon(Icons.close, color: Colors.white),
      children: <Widget>[
        RawMaterialButton(
          onPressed: () => print("You pressed 1"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.home, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => print("You pressed 2"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.supervisor_account, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => print("You pressed 3"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.save, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () => print("You pressed 4. This one closes the menu on tap"),
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.settings, color: Colors.white),
        ),
        RawMaterialButton(
          onPressed: () {
            print("You pressed 5. This one closes the menu on tap");
            fabKey.currentState.close();
          },
          shape: CircleBorder(),
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.close, color: Colors.white),
        )
      ],
    );
  }
}
