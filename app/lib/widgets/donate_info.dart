import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/services.dart';

class DonateInfo extends StatelessWidget {
  final Function(String) onDonoCopy;

  DonateInfo({required this.onDonoCopy});

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
              child: Image.asset("assets/dono_ada.png"),
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
                "Send Ada to this address to support the developers 🤓",
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
                data: dono_addr,
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
                          dono_addr,
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
                      width: border_thickness,
                      height: 40,
                    ),

                    // Clipboard Button
                    IconButton(
                      icon: Icon(Icons.copy),
                      color: Colors.white,
                      iconSize: 25,
                      onPressed: () {
                        onDonoCopy("Copied Donation Address");
                        Clipboard.setData(ClipboardData(text: dono_addr));
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
