import 'package:antiradar/presentation/view_model/settings/light_theme.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view_model/settings/dark_theme.dart';
import '../../view_model/settings/theme_provider.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeNotifierProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: !(theme == AppTheme.light)
                ? lightTheme.extension<GradientExtension>()?.gradient
                : darkTheme.extension<GradientExtension>()?.gradient,
          ),
          child: Column(
            children: [
              Row(children: [
                Text("jhjhj"),
                SizedBox(
                  width: 100,
                  child: TextField(),
                ),
              ]),
              // Дополнительные виджеты...
            ],
          ),
        ),
      ),
    );
  }
}
