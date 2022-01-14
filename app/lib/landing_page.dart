import 'package:flutter/material.dart';
import 'package:burn_ada/constants.dart';
import 'package:burn_ada/widgets/burn_info.dart';
import 'package:burn_ada/widgets/donate_info.dart';
import 'package:burn_ada/widgets/socal_buttons.dart';
import 'package:burn_ada/widgets/burn_ticker.dart';
import 'package:burn_ada/widgets/store_buttons.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  // Change to true to show Donate Page
  bool _donateCopied = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Color(0xFF222222),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ConstrainedBox(
              constraints:
                  BoxConstraints(minHeight: viewportConstraints.maxHeight),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Burn Ada",
                    style: TextStyle(
                      fontSize: 75,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Padding(padding: EdgeInsets.all(defaultPadding)),

                  BurnTicker(size: 400),

                  Padding(padding: EdgeInsets.all(defaultPadding)),

                  Scrollbar(
                    isAlwaysShown: true,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Burn Info
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 400),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: burn_bg,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      width: border_thickness,
                                      color: message_border)),
                              child: Column(
                                children: [
                                  BurnInfo(
                                    onBurnCopy: (String message) {
                                      _donateCopied = false;
                                      ScaffoldMessenger.of(context)
                                        ..removeCurrentSnackBar()
                                        ..showSnackBar(
                                          notification(message),
                                        );
                                    },
                                  ),
                                  Padding(
                                      padding: EdgeInsets.all(defaultPadding))
                                ],
                              ),
                            ),
                          ),

                          Padding(padding: EdgeInsets.all(defaultPadding * 2)),

                          // Donate Info
                          ConstrainedBox(
                            constraints: BoxConstraints(maxWidth: 400),
                            child: Container(
                                decoration: BoxDecoration(
                                    color: donate_bg,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                    border: Border.all(
                                        width: border_thickness,
                                        color: message_border)),
                                child: Column(
                                  children: [
                                    DonateInfo(
                                      onDonoCopy: (String message) {
                                        _donateCopied = true;
                                        ScaffoldMessenger.of(context)
                                          ..removeCurrentSnackBar()
                                          ..showSnackBar(
                                            notification(message),
                                          );
                                      },
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(defaultPadding))
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(defaultPadding)),

                  // Media Buttons
                  Column(
                    children: [
                      Text(
                        "How it works:",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SocalButtons(),
                      Padding(padding: EdgeInsets.all(defaultPadding)),
                      StoreButtons(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Notification Pop-Up
  SnackBar notification(String message) {
    return SnackBar(
      backgroundColor: _donateCopied ? message_donate_bg : message_burn_bg,
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
