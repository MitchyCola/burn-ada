import 'package:flutter/material.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class WalletButtons extends StatelessWidget {
  const WalletButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                await LaunchApp.openApp(
                    androidPackageName: 'com.emurgo',
                    iosUrlScheme: 'yoroi://',
                    appStoreLink:
                        'https://apps.apple.com/us/app/emurgos-yoroi-cardano-wallet/id1447326389',
                    openStore: true);
              },
              icon: Image.asset(
                'assets/Yoroi.png',
              ),
              iconSize: _size.width * 0.275,
            ),
            IconButton(
              onPressed: () async {
                await LaunchApp.openApp(
                    androidPackageName: 'com.coinbase.android',
                    iosUrlScheme: 'coinbase://',
                    appStoreLink:
                        'https://apps.apple.com/us/app/coinbase-buy-bitcoin-ether/id886427730',
                    openStore: true);
              },
              icon: Image.asset(
                'assets/Coinbase-App.jpg',
              ),
              iconSize: _size.width * 0.275,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () async {
                await LaunchApp.openApp(
                    androidPackageName: 'com.kraken.invest.app',
                    iosUrlScheme: 'kraken://',
                    appStoreLink:
                        'https://apps.apple.com/us/app/kraken-buy-bitcoin-shiba/id1481947260',
                    openStore: true);
              },
              icon: Image.asset(
                'assets/kraken.jpeg',
              ),
              iconSize: _size.width * 0.275,
            ),
            IconButton(
              onPressed: () async {
                await LaunchApp.openApp(
                    androidPackageName: 'com.nexowalletnexo',
                    iosUrlScheme: 'nexo://',
                    appStoreLink:
                        'https://apps.apple.com/us/app/nexo-crypto-account/id1455341917',
                    openStore: true);
              },
              icon: Image.asset(
                'assets/nexo.png',
              ),
              iconSize: _size.width * 0.275,
            ),
          ],
        ),
      ],
    );
  }
}
