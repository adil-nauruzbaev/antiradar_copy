import 'package:antiradar/data/firebase/argentina_provider.dart';
import 'package:antiradar/presentation/view_model/isar/isar_saver_provider.dart';
import 'package:antiradar/presentation/view_model/isar/isar_show_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SaveArgentinaDataPage extends ConsumerWidget {
  const SaveArgentinaDataPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isarModelsAsyncValue = ref.watch(isarArgentinaModelsProvider);
    Future<void> _refresh() async {
      // ignore: unused_result
      ref.refresh(isarArgentinaModelsProvider);
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Save Argentina Data')),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                try {
                  final models = await ref.read(argentinaModelsProvider.future);

                  await ref
                      .read(isarSaverProvider.notifier)
                      .saveArgentinaModels(models);

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Data saved to Isar')),
                  );

                  // ignore: unused_result
                  ref.refresh(isarArgentinaModelsProvider);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );
                }
              },
              child: const Text('Save Data to Isar'),
            ),
          ),
          Expanded(
            child: isarModelsAsyncValue.when(
              data: (models) {
                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    itemCount: models.length,
                    itemBuilder: (context, index) {
                      final model = models[index];
                      return ListTile(
                        title:
                            Text('Type: ${model.type}, Speed: ${model.speed}'),
                        subtitle:
                            Text('Lat: ${model.lat}, Long: ${model.long}'),
                      );
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => Center(child: Text('Error: $error')),
            ),
          ),
        ],
      ),
    );
  }
}
