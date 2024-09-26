import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/fonts_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';

Widget eventBottomSheet(BuildContext context, WidgetRef ref) {
  final loc = AppLocalizations.of(context)!;
  final isHorizontal =
      MediaQuery.of(context).orientation == Orientation.landscape;

  return Container(
    padding: const EdgeInsets.only(right: 16, left: 16, top: 20, bottom: 40),
    decoration: BoxDecoration(
      color: Theme.of(context).radarColors.alertColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          loc.reportEvent,
          style: Theme.of(context).appFonts.alertTextStyle2,
        ),
        const SizedBox(height: 36),
        isHorizontal
            ? SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    eventContainer(context, "assets/icons/events/cars.svg",
                        loc.trafficJams, const Color(0xFFE84852)),
                    eventContainer(context, "assets/icons/events/cap.svg",
                        loc.police, const Color(0xFF37B4EA)),
                    eventContainer(context, "assets/icons/events/car_crash.svg",
                        loc.crash, const Color(0xFF1CE4F9)),
                    eventContainer(context, "assets/icons/events/sign.svg",
                        loc.hazard, const Color(0xFFFFC801)),
                    eventContainer(context, "assets/icons/events/sign2.svg",
                        loc.roadWorks, const Color(0xFF0199C9)),
                    eventContainer(context, "assets/icons/events/geo.svg",
                        loc.cardError, const Color(0xFF06D258)),
                  ],
                ),
              )
            : Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      eventContainer(context, "assets/icons/events/cars.svg",
                          loc.trafficJams, const Color(0xFFE84852)),
                      eventContainer(context, "assets/icons/events/cap.svg",
                          loc.police, const Color(0xFF37B4EA)),
                      eventContainer(
                          context,
                          "assets/icons/events/car_crash.svg",
                          loc.crash,
                          const Color(0xFF1CE4F9)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      eventContainer(context, "assets/icons/events/sign.svg",
                          loc.hazard, const Color(0xFFFFC801)),
                      eventContainer(context, "assets/icons/events/sign2.svg",
                          loc.roadWorks, const Color(0xFF0199C9)),
                      eventContainer(context, "assets/icons/events/geo.svg",
                          loc.cardError, const Color(0xFF06D258)),
                    ],
                  ),
                ],
              ),
      ],
    ),
  );
}

Future<void> showCustomDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true, // Позволяет закрыть диалог при нажатии вне его
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Placeholder'),
        content: const Text('In testing'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Закрыть диалог
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

Widget eventContainer(
    BuildContext context, String path, String title, Color color) {
  return GestureDetector(
    onTap: () {
      showCustomDialog(context);
    },
    child: Column(
      children: [
        Container(
          constraints: const BoxConstraints(
              maxHeight: 120, maxWidth: 108, minHeight: 60, minWidth: 54),
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: AppColors.eventStrokeColor,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
              child: Container(
                  constraints: const BoxConstraints(
                    maxHeight: 60,
                    minHeight: 30,
                  ),
                  child: SvgPicture.asset(path))),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 100
          ),
          child: Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .appFonts
                  .alertTextStyle!
                  .copyWith(fontSize: 16)),
        )
      ],
    ),
  );
}
