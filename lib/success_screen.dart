import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'app_theme.dart';
import 'food_home_screen.dart';
import 'food_theme.dart';

class SuccessScreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    moveTo() {
      Navigator.push<dynamic>(
        context,
        MaterialPageRoute<dynamic>(
          builder: (BuildContext context) => CrousHomeScreen(),
        ),
      );
    }

    return Container(
        color: AppTheme.nearlyWhite,
        child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppTheme.nearlyWhite),
              backgroundColor: FoodAppTheme.buildLightTheme().primaryColor,
              // elevation: 20,
              centerTitle: true,
              title: Text('Crous Eat',
                  style: TextStyle(color: AppTheme.nearlyWhite)),
              actions: <Widget>[
                IconButton(
                    icon: Icon(Icons.home),
                    onPressed: () {
                      moveTo();
                    }),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 1.5,
                    child: SvgPicture.asset('assets/foods/success.svg'),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40,),
                    child: Center(
                      child: Text(
                        'Commande envoyée !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w600,
                          fontSize: 32,
                          // letterSpacing: 0.27,
                          color: FoodAppTheme.buildLightTheme().primaryColor,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 100, right: 100),
                    child: Center(
                      child: Text(
                        'Elle vous attendra à la fin de votre cours !',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: AppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 22,
                          // letterSpacing: 0.27,
                          color: AppTheme.nearlyBlack,
                        ),
                      ),
                    ),
                  ),
                   Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 60, left: 100, right: 100),
                    child: Center(
                      child: Text(
                        'Solde CROUS restant: 32€',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          // letterSpacing: 0.27,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
                ])));
  }
}
