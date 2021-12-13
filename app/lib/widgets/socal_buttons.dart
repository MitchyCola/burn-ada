import 'package:burn_ada/widgets/so_cal_logos_icons.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SocalButtons extends StatelessWidget {
  const SocalButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () =>
                _launchURL('https://github.com/MitchyCola/burn-ada'),
            icon: Icon(
              SoCalLogos.github,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () => _launchURL(
                'https://mitchycola.medium.com/proof-of-burn-challenge-c8b18b7ca3f0'),
            icon: Icon(
              SoCalLogos.medium,
              color: Colors.white,
            )),
        IconButton(
            onPressed: () => _launchURL('https://youtu.be/zqDCiWGIyik'),
            icon: Icon(
              SoCalLogos.youtube,
              color: Colors.white,
            )),
      ],
    );
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
