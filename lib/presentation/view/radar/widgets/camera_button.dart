import 'package:antiradar/presentation/view/radar/widgets/radar_bottom_sheet.dart';
import 'package:antiradar/presentation/view_model/settings/app_colors_extension.dart';
import 'package:antiradar/presentation/view_model/settings/fonts_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraButton extends StatelessWidget {
  const CameraButton({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SizedBox(
      width: 70,
      height: 70,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: AppColors.gradientColor5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Theme.of(context)
                    .radarColors
                    .alertColor, // Dark background for the dialog
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                content: SizedBox(
                  width: 300,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 12),
                      SvgPicture.asset(
                        'assets/icons/location.svg',
                        colorFilter: ColorFilter.mode(
                            Theme.of(context).radarColors.volumeIconsColor,
                            BlendMode.srcIn),
                      ),
                      const SizedBox(height: 14),
                      Text(loc.alertText,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).appFonts.alertTextStyle),
                    ],
                  ),
                ),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 52,
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(
                                false); // Return false when 'No' is pressed
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                AppColors.whiteColor, // Gray for 'No' button
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  color: Theme.of(context).radarColors.staticChamberStrokeColor,
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            loc.no,
                            style: AppFonts.sfProSemibold.copyWith(
                                color: AppColors.gradientColor5, fontSize: 17),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        height: 52,
                        width: 100,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            showModalBottomSheet(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width
                              ),
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return Consumer(
                                  builder: (context, ref, child) {
                                    return buildBottomSheet(context, ref);
                                  },
                                );
                              },
                            ); // Return true when 'Yes' is pressed
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors
                                .gradientColor5, // Blue for 'Yes' button
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Text(
                            loc.yes,
                            style: AppFonts.sfProSemibold.copyWith(
                                color: AppColors.whiteColor, fontSize: 17),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          );
        },
        child: SvgPicture.asset('assets/icons/camera2.svg'),
      ),
    );
  }
}

