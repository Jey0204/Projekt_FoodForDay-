import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Meal/AddingView.dart';

class Squarebutton {
  Widget buildSquareButton(
    IconData icon,
    String label,
    double screenHeight,
    BuildContext context,
    VoidCallback? onPressed,
  ) {
    return SizedBox(
      width: screenHeight * 3 / 16,
      height: screenHeight * 3 / 16,
      child: ElevatedButton(
        onPressed:
            onPressed ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addingview()),
              );
            },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.grey[200],
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: screenHeight / 10, color: Colors.blue),
            SizedBox(height: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: screenHeight / 50,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSquareButtonText(
    String label,
    double screenHeight,
    double screenWidth,
    double fontSize,
    BuildContext context,
    VoidCallback? onPressed,
  ) {
    return SizedBox(
      width: screenWidth * 3 / 30,
      height: screenHeight * 3 / 16,
      child: ElevatedButton(
        onPressed:
            onPressed ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addingview()),
              );
            },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: fontSize, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTransparentArrowButton(
    double screenHeight,
    double screenWidth,
    BuildContext context,
    VoidCallback? onPressed,
    IconData icon,
  ) {
    return SizedBox(
      width: screenWidth / 12,
      height: screenHeight / 35,
      child: IconButton(
        onPressed:
            onPressed ??
            () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Addingview()),
              );
            },
        icon: Icon(icon, size: screenHeight / 60, color: Colors.black),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          overlayColor: MaterialStateProperty.all(Colors.transparent),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
        ),
      ),
    );
  }
}
