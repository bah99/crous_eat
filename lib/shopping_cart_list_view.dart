import 'package:crous_eat/app_theme.dart';
import 'package:crous_eat/food_theme.dart';
import 'package:crous_eat/model/food_list_data.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'main.dart';

class ShoppingCartListView extends StatefulWidget {
  const ShoppingCartListView({Key key, this.selectedFoods, this.callBack})
      : super(key: key);

  final Function callBack;
  final List<FoodListData> selectedFoods;
  @override
  _ShoppingCartListViewState createState() => _ShoppingCartListViewState();
}

class _ShoppingCartListViewState extends State<ShoppingCartListView>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        fit: FlexFit.tight,
        child: Column(
          children: <Widget>[
            Flexible(
                // flex: 10,
                // fit: FlexFit.tight,
                child: widget.selectedFoods.length > 0
                    ? Scrollbar(
                      child: ListView.builder(
                        padding: const EdgeInsets.only(
                            top: 0, bottom: 0, right: 16, left: 16),
                        itemCount: widget.selectedFoods.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          final int count = widget.selectedFoods.length > 10
                              ? 10
                              : widget.selectedFoods.length;
                          final Animation<double> animation =
                              Tween<double>(begin: 0.0, end: 1.0).animate(
                                  CurvedAnimation(
                                      parent: animationController,
                                      curve: Interval((1 / count) * index, 1.0,
                                          curve: Curves.fastOutSlowIn)));
                          animationController.forward();
                          return Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                  child: CardView(
                                foodData: widget.selectedFoods[index],
                                animation: animation,
                                selectedFoods: widget.selectedFoods,
                                animationController: animationController,
                                callback: widget.callBack,
                              )));
                        },
                      ))
                    : Center(
                        child: Text(
                          'Le Panier est vide !',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            // letterSpacing: 0.27,
                            color: FoodAppTheme.buildLightTheme().errorColor,
                          ),
                        ),
                      )),
            Container(
                // fit: FlexFit.tight,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16.0, right: 16),
                  child: Text(
                    _getTotalPrice() > 0 ? 'Total: ${_getTotalPrice()}€' : '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      // letterSpacing: 0.27,
                      color: FoodAppTheme.buildLightTheme().primaryColor,
                    ),
                  ),
                )),
          ],
        ));
  }

  _getTotalPrice() {
    int price = 0;
    for (var item in widget.selectedFoods) {
      price += item.price;
    }

    return price;
  }

  refresh() {
    setState(() {});
  }
}

class CardView extends StatefulWidget {
  const CardView(
      {Key key,
      this.foodData,
      this.selectedFoods,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final FoodListData foodData;
  final List<FoodListData> selectedFoods;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CardView> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                100 * (1.0 - widget.animation.value), 0.0, 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                widget.callback();
              },
              child: SizedBox(
                // width: 250,
                height: 120,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: <Widget>[
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#f0fffc'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                              ),
                              child: Row(
                                children: <Widget>[
                                  const SizedBox(
                                    width: 80 + 24.0,
                                  ),
                                  Expanded(
                                    child: Container(
                                      // height: 140,
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0,
                                                  left: 16,
                                                  right: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Flexible(
                                                    child: Text(
                                                      widget.foodData.titleTxt,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 13,
                                                        letterSpacing: 0.27,
                                                        color:
                                                            AppTheme.darkerText,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${widget.foodData.price}€',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                      letterSpacing: 0.27,
                                                      color: FoodAppTheme
                                                              .buildLightTheme()
                                                          .primaryColor,
                                                    ),
                                                  ),
                                                ],
                                              )),
                                          // const Expanded(
                                          //   child: SizedBox(),
                                          // ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0,
                                                left: 18,
                                                right: 5,
                                                bottom: 0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    '${widget.foodData.description}',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w200,
                                                      fontSize: 12,
                                                      letterSpacing: 0.27,
                                                      color: AppTheme.grey,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 0, bottom: 8),
                                                  child: Checkbox(
                                                    activeColor: FoodAppTheme
                                                            .buildLightTheme()
                                                        .primaryColor,
                                                    value: widget
                                                        .foodData.isSelected,
                                                    onChanged: (bool value) {
                                                      setState(() {
                                                        widget.foodData
                                                            .isSelected = value;
                                                        widget.foodData
                                                                .isSelected
                                                            ? widget
                                                                .selectedFoods
                                                                .add(widget
                                                                    .foodData)
                                                            : widget
                                                                .selectedFoods
                                                                .remove(widget
                                                                    .foodData);
                                                        _saveSelectedFoods(
                                                            selectedItemId(widget
                                                                .selectedFoods));
                                                        widget.callback();
                                                      });
                                                    },
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, bottom: 24, left: 0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: 140,
                                // height: 200,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16.0)),
                                  child: AspectRatio(
                                      aspectRatio: 1.2,
                                      child: Image.asset(
                                          widget.foodData.imagePath)),
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
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
}
