import 'package:flutter/material.dart';
import 'package:posilkiapp/ViewModel/MealsViewModel.dart';
import 'package:provider/provider.dart';

class Rowvaluesview extends StatefulWidget {
  final int rowCount;
  final List<String> listText;
  final List<String> gram;

  const Rowvaluesview({
    Key? key,
    this.rowCount = 8,
    required this.gram,
    required this.listText,
  }) : super(key: key);

  @override
  _RowvaluesviewState createState() => _RowvaluesviewState();
}

class _RowvaluesviewState extends State<Rowvaluesview> {
  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<MealsViewModel>(context);
    double screenWidth = MediaQuery.of(context).size.width;
    vm.initializeControllers(8);

    return SizedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(widget.rowCount, (index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start, // lub .center
            children: [
              // Tekst z opisem
              SizedBox(
                width: screenWidth / 12,
                child: Text(
                  widget.listText[index],
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
              ),

              // TextField 1
              SizedBox(
                width: screenWidth / 8,
                height: 40,
                child: TextField(
                  controller: vm.controllers1[index],
                  style: TextStyle(fontSize: 16),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              SizedBox(
                width: screenWidth / 20,
                child: Text(widget.gram[index]),
              ),
            ],
          );
        }),
      ),
    );
  }
}
