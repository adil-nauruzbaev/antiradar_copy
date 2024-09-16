import 'package:antiradar/data/source/database/country_pod.dart';
import 'package:antiradar/presentation/view/on_boarding/start_screen.dart';
import 'package:antiradar/presentation/view/radar/widgets/camera_button.dart';
import 'package:antiradar/presentation/view/radar/widgets/radar_image.dart';
import 'package:antiradar/presentation/view/radar/widgets/top_status_indicator.dart';
import 'package:antiradar/presentation/view/radar/widgets/speed_indicator.dart';
import 'package:antiradar/presentation/view/radar/widgets/stop_button.dart';
import 'package:antiradar/presentation/view/radar/widgets/volume_buttons.dart';
import 'package:antiradar/presentation/view_model/settings/gradient_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final GlobalKey keyStopButton = GlobalKey();
final GlobalKey keyStaticChamber = GlobalKey();
final GlobalKey keySpeed = GlobalKey();
final GlobalKey keyAddButton = GlobalKey();
final GlobalKey keyVolumeButton = GlobalKey();
final GlobalKey keyCameraButton = GlobalKey();

class RadarScreen extends ConsumerStatefulWidget {
  const RadarScreen({super.key});

  @override
  ConsumerState<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends ConsumerState<RadarScreen> {
  @override
  Widget build(BuildContext context) {
    //final loc = AppLocalizations.of(context)!;
    final countryNotifier = ref.watch(countryNotifierProvider('argentina'));
    final bool isHorizontal = MediaQuery.of(context).orientation == Orientation.landscape;

    final double topLevel = isHorizontal ? 40 : 68;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        var tutorial = keyTutorial.currentState!.tutorial;
        if (tutorial.isShowing && tutorial.currentIndex == 2) {
          tutorial.tutorialCoachMark.goTo(1);
          context.pop();
        } else if (tutorial.isShowing && tutorial.currentIndex != 0) {
          tutorial.tutorialCoachMark.previous();
          tutorial.currentIndex -= 1;
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        floatingActionButton: StopButton(buttonKey: keyStopButton, isHorizontal: isHorizontal,),
        floatingActionButtonLocation: isHorizontal ? FloatingActionButtonLocation.endDocked : FloatingActionButtonLocation.centerDocked,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: Theme.of(context).gradients.radarGradient,
          ),
          child: Stack(
            children: [
              const RadarImage(),
              Positioned(
                left: 16,
                bottom: isHorizontal ? 26 : 240,
                child: CameraButton(
                  key: keyCameraButton,
                ),
              ),
              Positioned(
                  right: 16,
                  bottom: isHorizontal ? null : 180,
                  top: isHorizontal ? 140 : null,
                  child:
                      VolumeButtons(key1: keyAddButton, key2: keyVolumeButton)),
              Positioned(
                  left: 16,
                  top: topLevel,
                  child: TopStatusIndicator(
                    key: keyStaticChamber,
                    meters: 200,
                    text: 'Static \nchamber',
                    iconPath: 'assets/icons/camera.svg',
                  )),
              Positioned(
                  right: 16,
                  top: topLevel,
                  child: SpeedIndicator(
                    key: keySpeed,
                  )),
            ],
          ),
        ),
      ),
    );
  }

// ??
/*Widget buildRadioOption(String option) {
    String _selectedOption = 'Automatically';
    return RadioListTile<String>(
      activeColor: Colors.blue,
      title: Text(
        option,
        style: const TextStyle(color: Colors.white),
      ),
      value: option,
      groupValue: _selectedOption,
      onChanged: (value) {
        setState(() {
          _selectedOption = value!;
        });
      },
    );
  }*/
}
