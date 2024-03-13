import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Social Scence'),
      ),
      body: const Center(
        child: Text(
          'Welcome to Social Science',
        ),
      ),
    );
  }
}
