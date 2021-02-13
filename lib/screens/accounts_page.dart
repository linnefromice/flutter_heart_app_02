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

class _AccountListTile extends StatelessWidget {
  _AccountListTile({
    Key key,
    this.account,
  }) : super(key: key);

  final Account account;

  Widget _buildCircleAvatar(final Account account) {
    if (account.avatarUrl == null || account.avatarUrl == "") {
      return CircleAvatar(
        child: Text(
          account.name.characters.first,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey
      );
    } else {
      return CircleAvatar(
        backgroundImage: NetworkImage(account.avatarUrl),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AccountDetailPage(
            account: account
          )
        )
      ),
      leading: _buildCircleAvatar(account),
      title: Text(
        account.name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Row(
        children: List.generate(5, (index) => RatedHeart(
          rate: min(1, max(0, account.rating - index)), size: 30)
        ),
      ),
      trailing: account.isFriend ? RaisedButton(
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

class _Contents extends HookWidget {
  final accountService = AccountService();

  Widget _buildHeader({final TextEditingController textEditingController}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextField(
            controller: textEditingController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Search...",
              hintStyle: TextStyle(color: Colors.white),
              prefixIcon: IconButton(
                icon: Icon(Icons.clear, color: Colors.white),
                onPressed: () => textEditingController.clear(),
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

  Widget _buildContents(final String searchText) {
    return FutureBuilder<List<Account>>(
      future: accountService.findAccounts(),
      builder: (BuildContext context, AsyncSnapshot<List<Account>> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        if (snapshot.data == null) {
          return Center(child: Text("NO DATA"));
        }
        return _buildAccountList(searchText, snapshot.data);
      },
    );
  }

  Widget _buildAccountList(final String searchText, final List<Account> list) {
    final List<_AccountListTile> children = [];
    if (searchText == null || searchText == "") { // 全検索
      list.forEach((element) => children.add(_AccountListTile(account: element)));
    } else {
      list.forEach((element) {
        if (element.name.contains(searchText)) children.add(_AccountListTile(account: element));
      });
    }

    return Column(
      children: children
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
            child: _buildContents(textEditingController.text)
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