import 'package:badges/badges.dart';
import 'package:crous_eat/app_theme.dart';
import 'package:crous_eat/success_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_theme.dart';
import 'main.dart';
import 'model/food_list_data.dart';
import 'shopping_cart_list_view.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({Key key, this.selectedFoods, this.callBack})
      : super(key: key);

  final Function callBack;
  final List<FoodListData> selectedFoods;
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  final formController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<FoodListData> foodList = FoodListData.foodList;

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppTheme.nearlyWhite,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              iconTheme: IconThemeData(color: AppTheme.nearlyWhite),
              backgroundColor: FoodAppTheme.buildLightTheme().primaryColor,
              // elevation: 20,
              centerTitle: true,
              title: Text('Crous Eat',
                  style: TextStyle(color: AppTheme.nearlyWhite)),
              actions: <Widget>[
                _shoppingCartBadge()
                // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              ],
            ),
            backgroundColor: Colors.transparent,
            body: Column(children: <Widget>[
              SizedBox(
                height: 8,
              ),
              // getAppBarUI(),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Flexible(
                        child: getCategoryUI(),
                      ),
                      if (widget.selectedFoods.length >
                          0) //remove the form & the button widgets if pannel is empty!
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 500),
                          opacity: 1.0,

                          child: Container(
                              // height: 100,
                              // padding: const EdgeInsets.only(
                              //     left: 16, bottom: 0, right: 16),
                              child: Column(children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.only(
                                  left: 16, top: 30, right: 16),
                              child: Text(
                                'Où veux-tu te faire livrer ? \nEn Salle de TD ? 🚀',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18,
                                  letterSpacing: 0.5,
                                  color: AppTheme.nearlyBlack,
                                ),
                              ),
                            ),
                            Form(
                                key: _formKey,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16,
                                            bottom: 10,
                                            top: 32,
                                            right: 16),
                                        child: TextFormField(
                                          // autofocus: true,
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: HexColor('#f0fffc'),
                                              // focusedBorder: OutlineInputBorder(
                                              //     borderRadius: BorderRadius.all(
                                              //         Radius.circular(5.0)),
                                              //     borderSide:
                                              //         BorderSide(color: FoodAppTheme.buildLightTheme().primaryColor)),
                                              hintText: 'Rue'),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Entrez la rue SVP!';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 16, bottom: 48, right: 16),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Flexible(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            HexColor('#f0fffc'),
                                                        hintText: 'Ville'),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Entrez votre Ville SVP!';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                            ),
                                            Flexible(
                                              child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            HexColor('#f0fffc'),
                                                        hintText:
                                                            'Code Postal'),
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Entrez votre Code Postal SVP!';
                                                      }
                                                      return null;
                                                    },
                                                  )),
                                            )
                                          ],
                                        ),
                                      )
                                    ])),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                      width: 250,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: FoodAppTheme.buildLightTheme()
                                            .primaryColor,
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color:
                                                  FoodAppTheme.buildLightTheme()
                                                      .primaryColor
                                                      .withOpacity(0.5),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: InkWell(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(16.0),
                                        ),
                                        onTap: () {
                                          if (_formKey.currentState
                                              .validate()) {
                                            widget.selectedFoods.clear(); // clear the selected foods
                                            // print(widget.selectedFoods);
                                            _removeSelectedFoods();
                                            // widget.callBack();
                                            moveTo();
                                            // _displaySnackBar(context);
                                          }
                                        },
                                        child: Center(
                                          child: Text(
                                            'Passer la commande',
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 18,
                                              letterSpacing: 0.0,
                                              color: AppTheme.nearlyWhite,
                                            ),
                                          ),
                                        ),
                                      ))
                                ]),
                          ])
                              // height: MediaQuery.of(context).size.height,
                              ), // ),
                        ),
                    ],
                  ),
                ),
              )
            ])));
  }

  // _displaySnackBar(BuildContext context) {
  //   final snackBar = SnackBar(
  //     content: Text('Commande validée!'),
  //     backgroundColor: FoodAppTheme.buildLightTheme().primaryColor,
  //     elevation: 20,
  //   );
  //   _scaffoldKey.currentState.showSnackBar(snackBar);
  // }

  _removeSelectedFoods() async {
    foodList.forEach((food) => food.isSelected = false); // unselect the selected food from FoodList
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('selectedFoods');
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => SuccessScreen(),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 18, right: 18),
          child: Text(
            'Panier',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              // letterSpacing: 0.27,
              color: AppTheme.darkerText,
            ),
          ),
        ),
        // Expanded(
        ShoppingCartListView(
          selectedFoods: widget.selectedFoods,
          callBack: refresh,
        ),
      ],
    );
  }

  Widget _shoppingCartBadge() {
    if (widget.selectedFoods.length > 0) {
      return Badge(
        position: BadgePosition.topRight(top: 1, right: 8),
        animationDuration: Duration(milliseconds: 300),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          (widget.selectedFoods.length).toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
      );
    } else {
      return IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {});
    }
  }

  refresh() {
    setState(() {});
  }
}
