import 'package:flutter/material.dart';
import 'package:linnefromice/components/wrapper_common_background.dart';

const datas = [
  {
    "name": "Zidane Tribal",
    "rating": 4,
    "newRating": 3.5,
  },
  {
    "name": "Dagger",
    "rating": 4,
    "newRating": 5
  },
  {
    "name": "Vivi Orunitia",
    "rating": 3,
    "newRating": 4.25,
  },
  {
    "name": "Adelbert Steiner",
    "rating": 2,
    "newRating": 2.75
  },
  {
    "name": "Kuja",
    "rating": 5,
    "newRating": 5
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WrapperCommonBackground(
        child: ListView.builder(
          itemCount: datas.length,
          itemBuilder: (context, index) {
            final data = datas[index];
            return Card(
              child: ListTile(
                title: Text(
                  data["name"],
                  style: TextStyle(fontSize: 12.0),
                ),
                subtitle: Text(
                  "${data["rating"]} -> ${data["newRating"]}",
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}