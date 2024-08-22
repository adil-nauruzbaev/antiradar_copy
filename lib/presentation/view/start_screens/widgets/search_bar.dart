import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:antiradar/utils/app_colors.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class TopSearchBar extends ConsumerWidget {
  const TopSearchBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
      height: 60,
      child: Row(children: [
        Text(
          loc.selectLanguage,
          style: AppFonts.h1Style,
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            height: 36,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.whiteColor),
            child: Row(
              children: [
                const _SearchIcon(),
                Expanded(
                    child: TextField(
                  cursorColor: AppColors.lclSecondary,
                  style: AppFonts.searchStyle,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(bottom: 10),
                      border: InputBorder.none,
                      hintText: loc.search,
                      hintStyle: AppFonts.searchStyle),
                )),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class _SearchIcon extends StatelessWidget {
  const _SearchIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
      child: SvgPicture.asset(
        'assets/icons/search.svg',
        width: 28,
        height: 28,
      ),
    );
  }
}

