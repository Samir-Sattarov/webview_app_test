import 'package:flutter/material.dart';

class PlaceholderPage extends StatelessWidget {

  static const routeName = '/placeholder';

  const PlaceholderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Placeholder'),
      ),
      body: const Center(
        child: Text('Заглушка'),
      ),
    );
  }
}
