import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class BurnInfo extends StatelessWidget {
  final Function(String) onBurnCopy;

  BurnInfo({required this.onBurnCopy});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.topCenter,
      child: SafeArea(
        child: Column(
          children: [
            // Logo
            Container(
              height: _size.width * 0.33,
              child: Image.asset("assets/burn_ada.gif"),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding)),

            // Message
            Container(
              decoration: BoxDecoration(
                color: message_bg,
                border: Border.all(
                  width: border_thickness,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              padding: EdgeInsets.fromLTRB(2, 5, 2, 5),
              width: _size.width * 0.6,
              child: Text(
                "Send Ada to this address if you believe in ultrasound money 🦇",
                style: TextStyle(
                  color: Colors.white,
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
                size: _size.width * 0.6,
                gapless: true,
              ),
            ),

            Padding(padding: EdgeInsets.symmetric(vertical: defaultPadding)),

            // Address Text
            Container(
              decoration: BoxDecoration(
                color: message_bg,
                border: Border.all(
                  width: border_thickness,
                  color: Colors.white,
                ),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(10),
                ),
              ),
              width: _size.width * 0.6,
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
                      width: _size.width * 0.45,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                          burn_addr,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    // Vertical Divider
                    Container(
                      color: Colors.white,
                      width: 1.5,
                      height: 40,
                    ),

                    // Clipboard Button
                    IconButton(
                      icon: Icon(Icons.copy),
                      color: Colors.white,
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
