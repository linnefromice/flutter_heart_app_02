import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/avatar_area.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/evaluation_service.dart';

class EvaluatePage extends HookWidget {
  EvaluatePage({
    Key key,
    @required this.user
  }) : super(key: key);

  final User user;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final EvaluationService evaluationService = EvaluationService();

  AvatarArea _buildAvatarArea({final double diameter}) {
    return AvatarArea(
      diameter: diameter,
      image: !(user.avatarUrl == null || user.avatarUrl == "") ? NetworkImage(user.avatarUrl) : null,
      child: user.avatarUrl == null || user.avatarUrl == "" ? Text("NO IMAGE", style: TextStyle(color: Colors.black)) : null,
    );
  }

  Text _buildNameArea() => Text(
    user.name,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 30.0,
        color: Colors.white
    ),
  );

  Row _buildRatingArea() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      RatedHeart(rate: min(1, max(0, user.rating - 0)), size: 50), // origin -> Icon(Icons.favorite, size: 50, color: user.rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
      RatedHeart(rate: min(1, max(0, user.rating - 1)), size: 50),
      RatedHeart(rate: min(1, max(0, user.rating - 2)), size: 50),
      RatedHeart(rate: min(1, max(0, user.rating - 3)), size: 50),
      RatedHeart(rate: min(1, max(0, user.rating - 4)), size: 50),
    ],
  );

  SnackBar _successSnackBar() => SnackBar(
    content: Text("Success!!"),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.green[200],
  );

  SnackBar _failureSnackBar() => SnackBar(
    content: Text("Failure..."),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red[200],
  );

  Row _buildRatingPickerField(BuildContext context, ValueNotifier<int> integerState, ValueNotifier<int> decimalState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("for DEBUG"),
        SizedBox(width: 5),
        DropdownButton<int>(
          value: integerState.value,
          onChanged: (int value) {
            integerState.value = value;
            if (value == 5) decimalState.value = 0;
          },
          items: <int>[0, 1, 2, 3, 4, 5]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
        Text("."),
        DropdownButton<int>(
          value: decimalState.value,
          onChanged: integerState.value == 5 ? null : (int value) => decimalState.value = value,
          items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
              .map<DropdownMenuItem<int>>((int value) {
            return DropdownMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
        ElevatedButton.icon(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.grey)
          ),
          icon: Icon(Icons.favorite),
          label: Text("Thank you"),
          onPressed: () {
            final double value = integerState.value.toDouble() + decimalState.value.toDouble() * 0.1;
            final DateTime now = DateTime.now();
            if (value < 0 || value > 5) {
              ScaffoldMessenger.of(context).showSnackBar(_failureSnackBar());
              return;
            }
            evaluationService.createEvaluation(Evaluation(
              userId: user.id,
              rating: value,
              createdDate: now.year.toString().padLeft(4,"0") + now.month.toString().padLeft(2,"0") + now.day.toString().padLeft(2,"0"),
              createdAt: now
            ));
            ScaffoldMessenger.of(context).showSnackBar(_successSnackBar());
          }
        )
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    final integerState = useState(0);
    final decimalState = useState(0);

    return Scaffold(
      body: WrapperCommonBackground(
        child: Stack(
          children: [
            Positioned(
              top: MediaQuery.of(context).size.height * 0.25,
              left: 0,
              right: 0,
              child: _buildAvatarArea(
                  diameter: MediaQuery.of(context).size.width * 0.8
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.65,
              left: 0,
              right: 0,
              child: _buildNameArea(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.70,
              left: MediaQuery.of(context).size.width * 0.1,
              right: MediaQuery.of(context).size.width * 0.1,
              child: Divider(height: 40, thickness: 2, color: Colors.white),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: 0,
              right: 0,
              child: _buildRatingArea(),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.80,
              left: 0,
              right: 0,
              child: _buildRatingPickerField(context, integerState, decimalState),
            )
          ],
        )
      ),
      floatingActionButton: Builder(
        builder: (context) => WrapperFabCircularMenu(fabKey: fabKey)
      ),
    );
  }
}