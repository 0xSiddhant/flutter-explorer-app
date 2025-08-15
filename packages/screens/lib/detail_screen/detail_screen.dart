import 'package:flutter/material.dart';
import 'package:common/common.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          color: Colors.redAccent,
          child: Center(
            child: Text(AppLocalizations.getString('detail', 'en')),
          ),
        ),
      ),
    );
  }
}
