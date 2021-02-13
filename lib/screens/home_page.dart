import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/screens/evaluate_page.dart';
import 'package:linnefromice/services/account_service.dart';
import 'package:linnefromice/services/authentication_service.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final accountService = AccountService();
  final authenticationService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    print(authenticationService.currentUser.toString()); // for debug
    print(AuthenticationService.currentAccount.toString()); // for debug

    return Scaffold(
      body: WrapperCommonBackground(
        child: StreamBuilder<List<Account>>(
          stream: accountService.streamAccounts(),
          builder: (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.data == null) {
              return Center(child: Text("NO DATA"));
            }
            return _Content(
              accounts: snapshot.data,
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
    this.accounts,
  }) : super(key: key);

  final List<Account> accounts;
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
    final _name = useState(accounts[_initialPageIndex].name);
    final _rating = useState(accounts[_initialPageIndex].rating);

    return Stack(
      children: [
        PageView(
          controller: _pageController,
          children: accounts.map((Account account) => _ContentAvatar(
            account: account,
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
                  _name.value = accounts[nextPageIndex].name;
                  _rating.value = accounts[nextPageIndex].rating;
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
                  _name.value = accounts[nextPageIndex].name;
                  _rating.value = accounts[nextPageIndex].rating;
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
    this.account,
  }) : super(key: key);

  final Account account;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EvaluatePage(account: account)
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
            child: !(account.avatarUrl == null || account.avatarUrl == "") ? null : Text(account.name, style: TextStyle(color: Colors.red)),
            backgroundColor: account.avatarUrl == null || account.avatarUrl == "" ? Colors.white : null,
            backgroundImage: !(account.avatarUrl == null || account.avatarUrl == "") ? NetworkImage(account.avatarUrl) : null,
          )
        ),
      ),
    );
  }
}