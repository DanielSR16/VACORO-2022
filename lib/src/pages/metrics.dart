import 'package:flutter/material.dart';

class metrics extends StatefulWidget {
  metrics({Key? key}) : super(key: key);

  @override
  State<metrics> createState() => _metricsState();
}

class _metricsState extends State<metrics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("data")
            ],
          ),
        ),
      )
    );
  }
}