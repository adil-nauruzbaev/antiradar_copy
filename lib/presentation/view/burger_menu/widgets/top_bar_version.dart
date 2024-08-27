import 'package:antiradar/presentation/view/burger_menu/widgets/pro_free_icon.dart';
import 'package:antiradar/presentation/view_model/settings/version_card_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TopBarVersion extends StatelessWidget {
  final bool isFree;
  final bool isTapped;

  const TopBarVersion(
      {super.key, required this.isFree, required this.isTapped});

  @override
  Widget build(BuildContext context) {
    var themeExt = Theme.of(context).extension<VersionCardExtension>()!;

    final loc = AppLocalizations.of(context)!;
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.only(left: 8, right: 14),
        height: 64,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: isTapped
                ? themeExt.highlightedStrokeColor!
                : themeExt.strokeColor!,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: ListTile(
            dense: true,
            horizontalTitleGap: 12,
            contentPadding: EdgeInsets.zero,
            title: Text(
              isFree ? loc.freeVersion : loc.proVersion,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            leading: ProFreeIcon(
              isFree: isFree,
              iconSize: 44,
            ),
            trailing: SvgPicture.asset(
              'assets/icons/arrows_up_down.svg',
              width: 16,
              height: 32,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
            ),
          ),
        ));
  }
}
