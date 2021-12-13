import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bordered_text/bordered_text.dart';

class StoreButtons extends StatelessWidget {
  const StoreButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => null, //_launchURL('https://apple.com'),
                child: Image.asset(
                  "assets/app-store-badge.png",
                  width: 175,
                ),
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => null, //_launchURL('https://google.com'),
                child: Image.asset(
                  "assets/google-play-badge.png",
                  width: 150,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: SizedBox(
            width: 350,
            height: 57,
            child: DecoratedBox(
              child: Center(
                child: BorderedText(
                  strokeWidth: 3,
                  strokeColor: Colors.white,
                  child: Text(
                    "Coming Soon",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Color(0x8036393F),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
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
