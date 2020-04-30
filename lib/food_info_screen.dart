import 'package:badges/badges.dart';
import 'package:crous_eat/app_theme.dart';
import 'package:crous_eat/food_theme.dart';
import 'package:crous_eat/shopping_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/food_list_data.dart';

class FoodInfoScreen extends StatefulWidget {
  const FoodInfoScreen(
      {Key key, this.foodData, this.selectedFoods, this.notify})
      : super(key: key);

  final Function() notify;
  final FoodListData foodData;
  final List<FoodListData> selectedFoods;
  @override
  _FoodInfoScreenState createState() => _FoodInfoScreenState();
}

class _FoodInfoScreenState extends State<FoodInfoScreen>
    with TickerProviderStateMixin {
  final double infoHeight = 300.0;
  AnimationController animationController;
  Animation<double> animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    super.initState();
  }

  Future<void> setData() async {
    animationController.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // final double tempHeight = MediaQuery.of(context).size.height -
    //     (MediaQuery.of(context).size.width / 1.2) +
    //     24.0;
    return Container(
      color: AppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: AppTheme.nearlyWhite),
          backgroundColor: FoodAppTheme.buildLightTheme().primaryColor,
          // elevation: 20,
          centerTitle: true,
          title: Text(widget.foodData.titleTxt,
              style: TextStyle(color: AppTheme.nearlyWhite)),
          actions: <Widget>[
            _shoppingCartBadge()
            // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.2,
                  child:
                      Image.asset(widget.foodData.imagePath, fit: BoxFit.cover),
                ),
              ],
            ),
            Positioned(
              top: (MediaQuery.of(context).size.width / 1.2) - 24.0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: AppTheme.nearlyWhite,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: AppTheme.grey.withOpacity(0.2),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: SingleChildScrollView(
                    child: Container(
                      constraints: BoxConstraints(
                          minHeight: infoHeight, maxHeight: infoHeight),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 32.0, left: 18, right: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    widget.foodData.titleTxt,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: AppTheme.darkerText,
                                    ),
                                  ),
                                  Text(
                                    '${widget.foodData.price}€',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22,
                                      letterSpacing: 0.27,
                                      color: FoodAppTheme.buildLightTheme()
                                          .primaryColor,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 16, right: 16, bottom: 8, top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Flexible(
                                  child: Text(
                                    widget.foodData.description,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16,
                                      letterSpacing: 0.27,
                                      color: AppTheme.grey,
                                    ),
                                    maxLines: 5,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Checkbox(
                                  activeColor: FoodAppTheme.buildLightTheme()
                                      .primaryColor,
                                  value: widget.foodData.isSelected,
                                  onChanged: (bool value) {
                                    setState(() {
                                      widget.foodData.isSelected = value;
                                      widget.foodData.isSelected
                                          ? widget.selectedFoods
                                              .add(widget.foodData)
                                          : widget.selectedFoods
                                              .remove(widget.foodData);
                                      _saveSelectedFoods(
                                          selectedItemId(widget.selectedFoods));
                                      widget.notify();
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(
                                  top: 30.0, left: 16, right: 16),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Allergenes',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      letterSpacing: 0.27,
                                      color: AppTheme.darkerText,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.only(top: 20),
                                    itemCount:
                                        widget.foodData.allergenes.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        // padding: const EdgeInsets.only(top: 10),
                                        child: Text(
                                          '- ${widget.foodData.allergenes[index]}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 18,
                                            letterSpacing: 0.27,
                                            color: AppTheme.darkerText,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              )),
                          Expanded(
                            child: AnimatedOpacity(
                              duration: const Duration(milliseconds: 500),
                              opacity: opacity2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 8, bottom: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  selectedItemId(List<FoodListData> list) {
    List<String> idList = [];
    list.forEach((item) => idList.add(item.id.toString()));

    return idList;
  }

  _saveSelectedFoods(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('selectedFoods', data);
    });
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
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              moveTo(widget.selectedFoods);
            }),
      );
    } else {
      return IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            moveTo(widget.selectedFoods);
          });
    }
  }

  void moveTo(selectedFoods) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => ShoppingCartScreen(
          selectedFoods: selectedFoods,
          callBack: refresh,
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
  }

  Widget getBoxUI(String text1) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.nearlyWhite,
          borderRadius: const BorderRadius.all(Radius.circular(16.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: AppTheme.grey.withOpacity(0.2),
                offset: const Offset(1.1, 1.1),
                blurRadius: 8.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 10.0, right: 10.0, top: 12.0, bottom: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                text1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  letterSpacing: 0.27,
                  // color: FoodAppTheme.buildLightTheme().primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
