import 'package:antiradar/data/firebase/argentina_provider.dart';
import 'package:antiradar/data/source/database/country_pod.dart';
import 'package:antiradar/presentation/view_model/auth/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum CountryEnum { argentina, brazil, venezuela }

class SaveArgentinaDataPage extends ConsumerStatefulWidget {
  const SaveArgentinaDataPage({super.key});

  @override
  ConsumerState<SaveArgentinaDataPage> createState() =>
      _SaveArgentinaDataPageState();
}

class _SaveArgentinaDataPageState extends ConsumerState<SaveArgentinaDataPage> {
  final downloadPod = StateProvider((ref) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Save Argentina Data')),
      body: ref.watch(authServiceProvider).when(
            data: (user) {
              return Column(
                children: [
                  Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          ref
                              .read(downloadPod.notifier)
                              .update((state) => true);
                          final country = CountryEnum.argentina.name;
                          if (country != null) {
                            final models = await ref
                                .read(firebaseModelsProvider(country).future);
                            await ref
                                .read(countryNotifierProvider(country).notifier)
                                .saveAll(models)
                                .whenComplete(() {
                              ref
                                  .read(downloadPod.notifier)
                                  .update((state) => false);
                            });
                          } else {}

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Data saved to Isar')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
                      },
                      child: const Text('Save Data to Isar'),
                    ),
                  ),
                ],
              );
            },
            error: (error, stack) => Center(
              child: Text('Error: $error'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
