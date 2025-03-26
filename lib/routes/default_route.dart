import 'package:flutter/material.dart';

class DefaultRoute extends StatelessWidget {
  const DefaultRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ERROR',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Text(
          'WRONG ROUTING DECLARE',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}
