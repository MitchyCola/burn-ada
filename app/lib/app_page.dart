import 'dart:math';
import 'package:flutter/material.dart';
import 'package:burn_ada/constants.dart';
import 'package:burn_ada/widgets/burn_info.dart';
import 'package:burn_ada/widgets/donate_info.dart';
import 'package:burn_ada/widgets/socal_buttons.dart';
import 'package:swipe/swipe.dart';
import 'package:burn_ada/widgets/burn_ticker.dart';
import 'package:measured_size/measured_size.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> with SingleTickerProviderStateMixin {
  // Change to true to show Donate Page
  bool _isShowDonate = false;

  Size? mediaSize;

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
    var _safePadding = MediaQuery.of(context).padding.top;
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
                  bottom: pow(_size.height / _size.width, 3) *
                      1.0, // Turn the power from a num to a double by multiplying by 1.0.
                  right:
                      _isShowDonate ? -_size.width * 0.06 : _size.width * 0.06,
                  child: MeasuredSize(
                    onChange: (Size size) {
                      setState(() {
                        this.mediaSize = size;
                      });
                    },
                    child: Column(
                      children: [
                        BurnTicker(size: _size.width * 0.528),
                        Padding(padding: EdgeInsets.all(defaultPadding * 0.3)),
                        SocalButtons(),
                      ],
                    ),
                  ),
                ),

                // Burn Text
                AnimatedPositioned(
                  duration: defaultDuration,
                  top: _isShowDonate
                      ? _size.height / 2 + _size.width * 0.3
                      : _safePadding,
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
                  top: !_isShowDonate
                      ? _size.height / 2 + _size.width * 0.3
                      : _safePadding,
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

  // Notification Pop-Up
  SnackBar notification(String message) {
    return SnackBar(
      backgroundColor: _isShowDonate ? message_donate_bg : message_burn_bg,
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
