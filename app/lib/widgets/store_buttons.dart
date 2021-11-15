import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreButtons extends StatelessWidget {
  const StoreButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () => _launchURL('https://apple.com'),
            icon: Image.asset("assets/app-store-badge.png")),
        IconButton(
            onPressed: () => _launchURL('https://google.com'),
            icon: Image.asset("assets/google-play-badge.png")),
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
