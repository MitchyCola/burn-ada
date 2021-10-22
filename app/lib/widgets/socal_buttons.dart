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
            onPressed: () => _launchURL('https://github.com'),
            icon: Image.asset("assets/github.png")),
        IconButton(
            onPressed: () => _launchURL('https://medium.com'),
            icon: Image.asset("assets/medium.png")),
        IconButton(
            onPressed: () => _launchURL('https://youtube.com'),
            icon: Image.asset("assets/youtube.png")),
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
