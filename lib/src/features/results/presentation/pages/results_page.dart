import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:teach_savvy/src/core/config/config.dart';
import 'package:teach_savvy/src/core/constants/storage.dart';
import 'package:teach_savvy/src/core/data/storage_abstracts.dart';

@RoutePage()
class ResultsPage extends StatelessWidget {
  const ResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results Page'),
      ),
      body: ElevatedButton(
        onPressed: () {
          getIt<IKeyValueSecureDataSource>().removeValue(StorageKeys.token);
        },
        child: const Text('Logout'),
      ),
    );
  }
}
