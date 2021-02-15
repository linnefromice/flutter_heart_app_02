import 'dart:math';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:linnefromice/components/avatar_area.dart';
import 'package:linnefromice/components/common_snack_bars.dart';
import 'package:linnefromice/components/rated_heart.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/components/wrapper_fab_circle_menu.dart';
import 'package:linnefromice/models/account.dart';
import 'package:linnefromice/services/authentication_service.dart';
import 'package:linnefromice/services/evaluation_service.dart';

class EvaluatePage extends HookWidget {
  EvaluatePage({
    Key key,
    @required this.account
  }) : super(key: key);

  final Account account;
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();
  final EvaluationService evaluationService = EvaluationService();

  AvatarArea _buildAvatarArea({final double diameter}) {
    return AvatarArea(
      diameter: diameter,
      image: !(account.avatarUrl == null || account.avatarUrl == "") ? NetworkImage(account.avatarUrl) : null,
      child: account.avatarUrl == null || account.avatarUrl == "" ? Text("NO IMAGE", style: TextStyle(color: Colors.black)) : null,
    );
  }

  Text _buildNameArea() => Text(
    account.name,
    textAlign: TextAlign.center,
    style: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 30.0,
      color: Colors.white
    ),
  );

  Row _buildRatingArea(final double _rating) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      RatedHeart(rate: min(1, max(0, _rating - 0)), size: 50), // origin -> Icon(Icons.favorite, size: 50, color: user.rating >= 1 ? Colors.pink.withOpacity(0.5) : Colors.white),
      RatedHeart(rate: min(1, max(0, _rating - 1)), size: 50),
      RatedHeart(rate: min(1, max(0, _rating - 2)), size: 50),
      RatedHeart(rate: min(1, max(0, _rating - 3)), size: 50),
      RatedHeart(rate: min(1, max(0, _rating - 4)), size: 50),
    ],
  );

  // provide gesture area for rating & start animation (override heart widgets)
  Widget _buildGestureDetectorWidgetOnHearts(final double wrappedWidgetWidth, final ValueNotifier<double> ratingState) {
    return GestureDetector(
      onVerticalDragEnd: (details) async {
        // TODO: exec evaluation
      },
      onHorizontalDragUpdate: (details) {
        double sumRating = details.localPosition.dx/wrappedWidgetWidth * 5;
        if (sumRating > 5) sumRating = 5;
        if (sumRating < 0) sumRating = 0;
        ratingState.value = sumRating;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ratingState = useState(account.rating);

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
              child: _buildRatingArea(ratingState.value),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.75,
              left: MediaQuery.of(context).size.width * 0.20,
              width: MediaQuery.of(context).size.width * 0.60,
              height: MediaQuery.of(context).size.height * 0.05,
              child: _buildGestureDetectorWidgetOnHearts(
                MediaQuery.of(context).size.width * 0.60,
                ratingState
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    icon: Icon(Icons.refresh),
                    label: Text("RESET"),
                    onPressed: () => ratingState.value = account.rating,
                  ),
                  ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.transparent)
                    ),
                    icon: Icon(Icons.favorite),
                    label: Text("SEND"),
                    onPressed: () {
                      final _roundedRating = double.parse(ratingState.value.toStringAsFixed(2));
                      if (_roundedRating < 0 || _roundedRating > 5) {
                        ScaffoldMessenger.of(context).showSnackBar(failureSnackBar());
                        return;
                      }
                      evaluationService.createEvaluation(
                        fromUserId: AuthenticationService.currentAccount.id,
                        toUserId: account.id,
                        rating: _roundedRating,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(successSnackBar());
                      Navigator.of(context).pop();
                    }
                  )
                ],
              ),
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
