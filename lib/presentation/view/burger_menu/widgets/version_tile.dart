import 'package:antiradar/presentation/view/burger_menu/widgets/pro_free_icon.dart';
import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';





class VersionTile extends StatelessWidget {
  final bool isFree;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const VersionTile(
      {super.key,
      required this.isFree,
      required this.isSelected,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: isSelected == isFree
            ? Theme.of(context).extension<AppColorsExtension>()!.highlightedStrokeColor!
            : null,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        visualDensity: const VisualDensity(horizontal: 0, vertical: -2),
        contentPadding: const EdgeInsets.only(left: 8, right: 22),
        title: Text(
          isFree ? loc.freeVersion : loc.proVersion,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        subtitle: Text(
          isFree ? loc.limitless : loc.month,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        leading: ProFreeIcon(
          isFree: isFree,
          iconSize: 38,
        ),
        trailing: SvgPicture.asset(
          isSelected == isFree
              ? 'assets/icons/RatioDone.svg'
              : 'assets/icons/Ratio.svg',
          width: 22,
          height: 22,
        ),
      ),
    );
  }
}
