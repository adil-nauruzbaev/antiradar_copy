import 'package:antiradar/presentation/view/burger_menu/widgets/pro_free_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../utils/app_colors.dart';

class TopBarVersion extends StatelessWidget {
  final bool isFree;
  final bool isLightTheme;
  final bool isTapped;
  const TopBarVersion({super.key, required this.isFree, required this.isLightTheme, required this.isTapped});

  @override
  Widget build(BuildContext context) {
    Color color;

    if (isTapped){
      color = AppColors.gradientColor5.withOpacity(0.4);
    } else if (isLightTheme){
      color = AppColors.lightStrokeVersionContainerColor;
    } else {
      color = AppColors.darkStrokeVersionContainerColor;
    }

    final loc = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.only(left: 8, right: 14),
      height: 64,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2,
          color: color
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ProFreeIcon(
            isFree: isFree,
            iconSize: 44,
          ),
          const SizedBox(
            width: 12,
          ),
          Text(
            isFree ? loc.freeVersion : loc.proVersion,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const Expanded(child: SizedBox()),
          SvgPicture.asset(
            'assets/icons/arrows_up_down.svg',
            width: 16,
            height: 32,
            colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurface, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
