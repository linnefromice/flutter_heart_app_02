import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';
import 'package:linnefromice/models/evaluation.dart';
import 'package:linnefromice/models/user.dart';
import 'package:linnefromice/services/evaluation_service.dart';
import 'package:linnefromice/services/user_service.dart';

const datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4.0,
    "newRating": 3.5,
  },
  {
    "name": "Dagger",
    "rating": 4.0,
    "newRating": 5.0
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3.0,
    "newRating": 4.25,
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2.0,
    "newRating": 2.75
  },
  {
    "name": "Kuja",
    "rating": 5.0,
    "newRating": 5.0
  },
];

class _RatingInformation {
  _RatingInformation({
    @required this.name,
    @required this.rating,
    @required this.newRating
  });

  final String name;
  final double rating;
  final double newRating;
}

class RecalculateRatingPage extends StatelessWidget {
  final userService = UserService();
  final evaluationService = EvaluationService();

  Future<List<_RatingInformation>> _getNewRatingList() async {
    final List<User> users = await userService.findUsers();
    final List<Evaluation> evaluations = await evaluationService.findEvaluations();
    final List<_RatingInformation> results = users.map((user) {
      final List<Evaluation> selectedEvaluations = evaluations.where((el) => el.userId == user.id).toList();
      if (selectedEvaluations.isNotEmpty) {
        final List<double> values = selectedEvaluations.map((element) => element.rating).toList();
        return _RatingInformation(
          name: user.name,
          rating: user.rating,
          newRating: values.reduce((curr, next) => curr + next) / values.length
        );
      }
    }).toList();
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: FutureBuilder<List<_RatingInformation>>(
          future: _getNewRatingList(),
          builder: (BuildContext context, AsyncSnapshot<List<_RatingInformation>> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            }
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  final _RatingInformation data = snapshot.data[index];
                  return Card(
                    child: ListTile(
                      title: Text(data.name, style: TextStyle(fontSize: 12.0)),
                      subtitle: Text("${data.rating} -> ${data.newRating}", style: TextStyle(fontSize: 18.0)),
                    ),
                  );
                },
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  Text("Loading ...")
                ],
              ),
            );
          },
        ),
      )
    );
  }
}