import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:burn_ada/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';

class BurnTicker extends StatefulWidget {
  final double size;

  BurnTicker({required this.size});

  @override
  State<BurnTicker> createState() => _BurnTickerState();
}

class _BurnTickerState extends State<BurnTicker> {
  String burned = "Loading";
  String link =
      'https://cardanoscan.io/address/61cbe77f2ec54c11ea55535cbb4f0e23af8143f2d1ad01ef46b1f5e237';

  Future<String> updateTicker() async {
    // Initiate a
    var client = http.Client();

    // Basically, this is an HTTP GET operation
    final response = await client.get(
      Uri.parse(link),
    );

    // If the connection is a success, parse the HTML for the desired data and close the Client
    if (response.statusCode == 200) {
      String lovelace = parse(response.body)
          .getElementsByClassName('table')[0]
          .children[0]
          .children[0]
          .children[2]
          .children[0]
          .text;
      client.close();
      burned = (double.parse(lovelace) / 1000000).toString().substring(0, 8);
      return (burned);
    } else {
      return ("Failed to laod");
      // throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: message_burn_bg,
      highlightColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: border_thickness,
            color: message_border,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        width: widget.size,
        padding: EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 0,
                child: Text('🔥',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: kIsWeb
                            ? widget.size * 0.065
                            : widget.size * 0.075))),
            Expanded(
              flex: 3,
              child: FutureBuilder<String>(
                  future: updateTicker(),
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    List<Widget> children;
                    if (kIsWeb || snapshot.hasData) {
                      children = [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                              onTap: () async {
                                if (await canLaunch(link)) {
                                  await launch(link);
                                } else {
                                  throw 'Could not launch $link';
                                }
                              },
                              child: RichText(
                                  text: TextSpan(
                                text: kIsWeb
                                    ? 'Click to Check Amount Burned'
                                    : '${snapshot.data} Ada',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    decoration: kIsWeb
                                        ? TextDecoration.underline
                                        : null,
                                    fontSize: kIsWeb
                                        ? widget.size * 0.055
                                        : widget.size * 0.1),
                              ))),
                        )
                      ];
                    } else if (snapshot.hasError) {
                      children = [
                        RichText(
                            text: TextSpan(
                                text: 'Error: ${snapshot.error}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: widget.size * 0.1)))
                      ];
                    } else {
                      children = [
                        Text('Loading...',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: widget.size * 0.1))
                      ];
                    }
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: children,
                    );
                  }),
            ),
            Expanded(
                flex: 0,
                child: Text('🔥',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: kIsWeb
                            ? widget.size * 0.065
                            : widget.size * 0.075))),
          ],
        ),
      ),
    );
  }
}
