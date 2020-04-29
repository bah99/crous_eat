import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:crous_eat/shopping_cart_screen.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_list_view.dart';
import 'food_theme.dart';
import 'model/food_list_data.dart';

class CrousHomeScreen extends StatefulWidget {
  @override
  _CrousHomeScreenState createState() => _CrousHomeScreenState();
}

class _CrousHomeScreenState extends State<CrousHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<FoodListData> foodList = FoodListData.foodList;
  List<FoodListData> selectedFoods = []; // list of the selected items
  List<String> idList = []; // list of the selected items

  @override
  void initState() {
    _loadSelectedFoods(); // load selected food from the disk storage
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    super.initState();
  }

  _loadSelectedFoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    idList = (prefs.getStringList('selectedFoods') ?? []);

    // print(idList);
    foodList.forEach((food) => {
          if (idList.contains(food.id.toString()))
            {food.isSelected = true, selectedFoods.add(food)}
        });
    refresh();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: FoodAppTheme.buildLightTheme(),
      child: Container(
        child: Scaffold(
            appBar: AppBar(
              elevation: 20,
              centerTitle: true,
              title: Text("Crous Eat"),
              actions: <Widget>[
                _shoppingCartBadge()
                // IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {}),
              ],
            ),
            body: GridView.count(
                padding: const EdgeInsets.only(
                    left: 8, bottom: 10, top: 20, right: 8),
                crossAxisCount: 2,
                children: List.generate(foodList.length, (index) {
                  final int count = foodList.length > 10 ? 10 : foodList.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / count) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController.forward();
                  return FoodListView(
                    notifyParent: refresh,
                    foodData: foodList[index],
                    selectedFoods: selectedFoods,
                    animation: animation,
                    animationController: animationController,
                  );
                }))),
      ),
    );
  }

  refresh() {
    setState(() {});
    // print(this.selectedFoods.length);
  }

  Widget _shoppingCartBadge() {
    if (selectedFoods.length > 0) {
      return Badge(
        position: BadgePosition.topRight(top: 1, right: 3),
        animationDuration: Duration(milliseconds: 100),
        animationType: BadgeAnimationType.slide,
        badgeContent: Text(
          (selectedFoods.length).toString(),
          style: TextStyle(color: Colors.white),
        ),
        child: IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              moveTo(selectedFoods);
            }),
      );
    } else {
      return IconButton(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            moveTo(selectedFoods);
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

  Widget getListUI() {
    return Container(
      decoration: BoxDecoration(
        color: FoodAppTheme.buildLightTheme().backgroundColor,
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              offset: const Offset(0, -2),
              blurRadius: 8.0),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height - 156 - 50,
            child: FutureBuilder<bool>(
              // future: getData(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox();
                } else {
                  return ListView.builder(
                    itemCount: foodList.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final int count =
                          foodList.length > 10 ? 10 : foodList.length;
                      final Animation<double> animation =
                          Tween<double>(begin: 0.0, end: 1.0).animate(
                              CurvedAnimation(
                                  parent: animationController,
                                  curve: Interval((1 / count) * index, 1.0,
                                      curve: Curves.fastOutSlowIn)));
                      animationController.forward();

                      return FoodListView(
                        notifyParent: refresh,
                        foodData: foodList[index],
                        animation: animation,
                        animationController: animationController,
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getFoodViewList() {
    final List<Widget> foodListViews = <Widget>[];
    for (int i = 0; i < foodList.length; i++) {
      final int count = foodList.length;
      final Animation<double> animation =
          Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      foodListViews.add(
        FoodListView(
          notifyParent: refresh,
          foodData: foodList[i],
          animation: animation,
          animationController: animationController,
        ),
      );
    }
    animationController.forward();
    return Column(
      children: foodListViews,
    );
  }
}
