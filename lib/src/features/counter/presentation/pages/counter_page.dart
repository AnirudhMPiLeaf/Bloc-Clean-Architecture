import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teach_savvy/src/core/routes/pages.gr.dart';

@RoutePage()
class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.navigateTo(const ResultsPage()),
          child: const Text('Results'),
        ),
      ),
    );
  }
}
