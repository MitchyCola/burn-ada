import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:burn_ada/constants.dart';
import 'package:burn_ada/widgets/burn_info.dart';
import 'package:burn_ada/widgets/donate_info.dart';
import 'package:burn_ada/widgets/socal_buttons.dart';
import 'package:swipe/swipe.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  // Change to true to show Donate Page
  bool _isShowDonate = false;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: defaultDuration);

    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowDonate = !_isShowDonate;
    });
    _isShowDonate
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    setUpAnimation();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // It provides us screen height and width
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Swipe(
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // Burn Info
                AnimatedPositioned(
                  duration: defaultDuration,
                  // Use 88% width for landing page
                  width: _size.width * 0.88,
                  height: _size.height,
                  left: _isShowDonate ? -_size.width * 0.76 : 0,
                  child: Container(
                    color: burn_bg,
                    child: BurnInfo(
                      onBurnCopy: (String message) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            notification(message),
                          );
                      },
                    ),
                  ),
                ),

                // Donate Info
                AnimatedPositioned(
                  duration: defaultDuration,
                  height: _size.height,
                  width: _size.width * 0.88,
                  left: _isShowDonate ? _size.width * 0.12 : _size.width * 0.88,
                  child: Container(
                    color: donate_bg,
                    child: DonateInfo(
                      onDonoCopy: (String message) {
                        ScaffoldMessenger.of(context)
                          ..removeCurrentSnackBar()
                          ..showSnackBar(
                            notification(message),
                          );
                      },
                    ),
                  ),
                ),

                // Media Buttons
                AnimatedPositioned(
                  duration: defaultDuration,
                  width: _size.width,
                  bottom: defaultPadding * 10, // 10%
                  right:
                      _isShowDonate ? -_size.width * 0.06 : _size.width * 0.06,
                  child: Column(
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
                    ],
                  ),
                ),

                // Burn Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: _isShowDonate
                      ? _size.height / 2 - _size.width * 0.3
                      : 17 * defaultPadding,
                  // when our Burn Info shows, we want our Donate text to right center
                  left: _isShowDonate
                      ? _size.width * 0.025
                      : _size.width * 0.44 - _size.width * 0.3,
                  // width of our text container is 160, so 160/2 = 80
                  // width of login is 88%, so 0.88/2 = 0.44
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: _isShowDonate
                          ? _size.height * 0.03
                          : _size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: Transform.rotate(
                      angle: -_animationTextRotate.value * pi / 180,
                      alignment: Alignment.topLeft,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.75),
                        width: _size.width * 0.6,
                        child: Text(
                          "Burn".toUpperCase(),
                        ),
                      ),
                    ),
                  ),
                ),

                // Donate Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  bottom: !_isShowDonate
                      ? _size.height / 2 - _size.width * 0.3
                      : 17 * defaultPadding,
                  // when our Donate shows we want our burn text to left center
                  right: _isShowDonate
                      ? _size.width * 0.44 - _size.width * 0.3
                      : _size.width * 0.025,
                  // width of our text container is 160, so 160/2 = 80
                  // width of login is 88%, so 0.88/2 = 0.44
                  child: AnimatedDefaultTextStyle(
                    duration: defaultDuration,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: !_isShowDonate
                          ? _size.height * 0.03
                          : _size.height * 0.04,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    child: Transform.rotate(
                      angle: (90 - _animationTextRotate.value) * pi / 180,
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding * 0.75),
                        width: _size.width * 0.6,
                        child: Text(
                          "Donate".toUpperCase(),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),

        // Update Page on swipe
        onSwipeLeft: () {
          if (_isShowDonate) {
            // Do nothing if already on Donate Page
          } else
            updateView();
        },
        onSwipeRight: () {
          if (_isShowDonate) {
            updateView();
          } else {
            // Do nothing if already on Burn Page
          }
        },
      ),
    );
  }

  SnackBar notification(String message) {
    return SnackBar(
      backgroundColor: Color(0xFF03433A),
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
