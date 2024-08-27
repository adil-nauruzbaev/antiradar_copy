import 'package:antiradar/presentation/view/burger_menu/widgets/version_tile.dart';
import 'package:antiradar/presentation/view_model/settings/version_card_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class VersionSelection extends StatelessWidget {
  final bool isFree;
  final bool isVisible;

  const VersionSelection(
      {super.key,
      required this.isFree,
      required this.isVisible});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 225,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: Theme.of(context).extension<VersionCardExtension>()!.strokeColor!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 20, bottom: 18),
              child: Text(
                loc.versionSelection,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            VersionTile(
              isFree: false,
              isSelected: isFree,
              //onTap: (){},
            ),
            const SizedBox(
              height: 14,
            ),
            VersionTile(
              isFree: true,
              isSelected: isFree,
              //onTap: (){},
            ),
          ],
        ),
      ),
    );
  }
}
