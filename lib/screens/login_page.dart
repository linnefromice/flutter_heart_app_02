import 'package:flutter/material.dart';

class _WrapperCommonBg extends StatelessWidget {
  _WrapperCommonBg({
    Key key,
    this.child
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.red[200],
              Colors.orange[100],
              Colors.deepOrange[200]
            ],
          )
      ),
      child: child,
    );
  }
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _WrapperCommonBg(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                "Rating",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(
              "You can reflect",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Text(
              "feelings to actually evaluations...",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: RaisedButton.icon(
                icon: Icon(
                  Icons.login,
                  size: 48,
                  color: Colors.white,
                ),
                label: Text(
                  "LOGIN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                onPressed: () {},
              ),
            )
          ],
        )
      ),
    );
  }

}