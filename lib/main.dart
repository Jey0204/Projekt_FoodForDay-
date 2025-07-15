import 'package:flutter/material.dart';
import 'package:posilkiapp/View/Main/MainView.dart';
import 'package:posilkiapp/ViewModel/AddMenuViewModel.dart';
import 'package:posilkiapp/ViewModel/AddShiftViewModel.dart';
import 'package:posilkiapp/ViewModel/MainViewViewModel.dart';
import 'package:posilkiapp/ViewModel/MealsViewModel.dart';
import 'package:posilkiapp/ViewModel/OrderedMealViewModel.dart';
import 'package:posilkiapp/ViewModel/OrderedMealsViewModel.dart';
import 'package:posilkiapp/ViewModel/StatisticsViewModel.dart';
import 'package:provider/provider.dart';

void main() {
  // Enable verbose logging for debugging (remove in production)
  // OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  // // Initialize with your OneSignal App ID
  // OneSignal.initialize("YOUR_APP_ID");
  // // Use this method to prompt for push notifications.
  // // We recommend removing this method after testing and instead use In-App Messages to prompt for notification permission.
  // OneSignal.Notifications.requestPermission(false);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MealsViewModel()),
        ChangeNotifierProvider(create: (_) => Addshiftviewmodel()),
        ChangeNotifierProvider(create: (_) => Mainviewviewmodel()),
        ChangeNotifierProvider(create: (_) => AddMenuviewmodel()),
        ChangeNotifierProvider(create: (_) => Orderedmealsviewmodel()),
        ChangeNotifierProvider(create: (_) => Statisticsviewmodel()),
        ChangeNotifierProvider(create: (_) => Orderedmealviewmodel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
          //  Scrolledwindow(listaWidok: [1, 2, 3, 4, 2, 4, 0]),
          // Addingview(), // Startujesz z ekranu logowania
          // Addshift(),
          Mainview(),
      // StatisticsScreen(),
    );
  }
}
