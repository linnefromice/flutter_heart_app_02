import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
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

class HomePage extends HookWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final int _initialPageIndex = 0;

  Widget _buildPageWidget({final BuildContext context, final String name}) {
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
    final PageController _pageController = usePageController(
      initialPage: _initialPageIndex,
      viewportFraction: 0.5,
    );
    final _name = useState(datas[_initialPageIndex]["name"]);
    final _rating = useState(datas[_initialPageIndex]["rating"]);

    return Scaffold(
      body: WrapperCommonBackground(
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: List.generate(datas.length, (index) {
                final user = datas[index];
                return _buildPageWidget(
                  context: context,
                  name: user["name"]
                );
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
                        _name.value = datas[nextPageIndex]["name"];
                        _rating.value = datas[nextPageIndex]["rating"];
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
                        _name.value = datas[nextPageIndex]["name"];
                        _rating.value = datas[nextPageIndex]["rating"];
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
                    Icon(Icons.favorite, size: 50, color: _rating.value >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating.value >= 2 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating.value >= 3 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating.value >= 4 ? Colors.pink.withOpacity(0.5) : Colors.white),
                    Icon(Icons.favorite, size: 50, color: _rating.value >= 5 ? Colors.pink.withOpacity(0.5) : Colors.white),
                  ],
                )
              )
            )
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}
