import 'package:antiradar/utils/app_colors.dart';
import 'package:antiradar/utils/app_fonts.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioChannelDialog extends StatefulWidget {
  @override
  _AudioChannelDialogState createState() => _AudioChannelDialogState();
}

class _AudioChannelDialogState extends State<AudioChannelDialog> {
  String _selectedOption = 'Automatically';
  final MethodChannel _channel =
      const MethodChannel('com.example/antiradar/audio_channel');
  final AssetsAudioPlayer _assetsAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    _loadAudioChannelSetting();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _assetsAudioPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.darkAlertColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      title: Text(
        "Audio channel (In testing)",
        style: AppFonts.h3Style.copyWith(
            fontWeight: FontWeight.w500, color: AppColors.lightTextColor2),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildRadioOption('Automatically'),
            const Divider(color: AppColors.greyColor),
            buildRadioOption('Bluetooth'),
            const Divider(color: AppColors.greyColor),
            buildRadioOption('Speaker'),
            const Divider(color: AppColors.greyColor),
            buildRadioOption('Headphones'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Cancel",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () {
            _saveAudioChannelSetting(_selectedOption);
            _applyAudioChannelSetting();
            Navigator.of(context).pop();
          },
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget buildRadioOption(String option) {
    return SizedBox(
      height: 42,
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: Radio<String>(
          value: option,
          groupValue: _selectedOption,
          onChanged: (String? value) {
            setState(() {
              _selectedOption = value!;
            });
          },
          activeColor: Colors.blue, // Цвет выбранной кнопки
        ),
        title: Text(
          option,
          style: AppFonts.speedStyle
              .copyWith(fontSize: 16, color: AppColors.whiteColor),
        ),
        onTap: () {
          setState(() {
            _selectedOption = option;
          });
        },
      ),
    );
  }

  Future<void> _saveAudioChannelSetting(String setting) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('audio_channel', setting);
  }

  Future<void> _loadAudioChannelSetting() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      _selectedOption = prefs.getString('audio_channel') ?? 'Automatically';
    });
    await _assetsAudioPlayer.open(
        Audio(
          "assets/audio/russian_voice/300m40.mp3",
        ),
        autoStart: true,
        loopMode: LoopMode.single);
    await _assetsAudioPlayer.setLoopMode(LoopMode.single);
  }

  Future<void> _applyAudioChannelSetting() async {
    try {
      await _channel
          .invokeMethod('setAudioOutput', {'output': _selectedOption});
          print(_selectedOption);
    } on PlatformException catch (e) {
      print("Failed to set audio output: '${e.message}'.");
    }
  }
}
