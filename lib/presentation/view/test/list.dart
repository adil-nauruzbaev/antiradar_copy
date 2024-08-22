import 'package:antiradar/data/firebase/argentina_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ArgentinaListPage extends ConsumerWidget {
  const ArgentinaListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final argentinaModelsAsyncValue = ref.watch(argentinaModelsProvider);
    Future<void> _refresh() async {
      // ignore: unused_result
      ref.refresh(argentinaModelsProvider);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Firebase docs')),
      body: argentinaModelsAsyncValue.when(
        data: (models) {
          return RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
              itemCount: models.length,
              itemBuilder: (context, index) {
                final model = models[index];
                return ListTile(
                  title: Text('Type: ${model.type}, Speed: ${model.speed}'),
                  subtitle: Text('Lat: ${model.lat}, Long: ${model.long}'),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
