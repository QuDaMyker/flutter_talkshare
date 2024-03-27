import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.red,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                color: Colors.black,
              ),
            ),
            Flexible(
              flex: 8,
              child: Container(
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
