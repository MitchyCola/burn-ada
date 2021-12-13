import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class BurnInfo extends StatelessWidget {
  final Function(String) onBurnCopy;

  BurnInfo({required this.onBurnCopy});

  @override
  Widget build(BuildContext context) {
    var _size;

    if (kIsWeb) {
      _size = 400.0;
    } else {
      _size = MediaQuery.of(context).size.width;
    }

    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Column(
          children: [
            // Logo
            Container(
              height: _size * 0.33,
              child: Image.asset("assets/burn_ada.gif"),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding)),

            // Message
            Container(
              decoration: BoxDecoration(
                color: message_burn_bg,
                border: Border.all(
                  width: border_thickness,
                  color: message_border,
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
              width: _size * 0.6,
              child: Text(
                "Send Ada to this address if you believe in ultra-sound money 🦇",
                style: TextStyle(
                  color: message_text,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding)),

            // QR Code
            Container(
              color: Colors.white,
              child: QrImage(
                data: burn_addr,
                version: QrVersions.auto,
                size: _size * 0.6,
                gapless: true,
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding)),

            // Address Text
            Container(
              decoration: BoxDecoration(
                color: message_burn_bg,
                border: Border.all(
                  width: border_thickness,
                  color: message_border,
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              width: _size * 0.6,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    // Text
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      color: Color(0x00000000),
                      constraints: BoxConstraints(maxHeight: 45),
                      width: _size * 0.45,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          burn_addr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: message_text,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Vertical Divider
                    Container(
                      color: message_text,
                      width: 1.5,
                      height: 40,
                    ),

                    // Clipboard Button
                    IconButton(
                      icon: Icon(Icons.copy),
                      color: message_text,
                      iconSize: 25,
                      onPressed: () {
                        onBurnCopy("Copied Burn Address");
                        Clipboard.setData(ClipboardData(text: burn_addr));
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
