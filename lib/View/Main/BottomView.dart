import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Meal/AddingView.dart';

class Bottomview extends StatelessWidget {
  const Bottomview({super.key});

  @override
  Widget build(BuildContext context) {
    // final vm = Provider.of<MealsViewModel>(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end, // cała linia do prawej
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: [
                Icon(Icons.person, color: Colors.grey),
                SizedBox(width: 4),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) => Addingview()),
                //     );
                //   },
                //   child: Text("data"),
                // ),
                Text("Jan Kowalski"),
              ],
            ),
            SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
