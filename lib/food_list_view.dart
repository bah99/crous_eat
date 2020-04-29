import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'food_info_screen.dart';
import 'food_theme.dart';
import 'model/food_list_data.dart';

class FoodListView extends StatefulWidget {
  const FoodListView(
      {Key key,
      this.foodData,
      this.animationController,
      this.animation,
      this.selectedFoods,
      this.notifyParent})
      : super(key: key);

  final Function() notifyParent;
  final FoodListData foodData;
  final AnimationController animationController;
  final Animation<dynamic> animation;
  final List<FoodListData> selectedFoods;

  @override
  _FoodListState createState() => _FoodListState();
}

class _FoodListState extends State<FoodListView> {

  _saveSelectedFoods(data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setStringList('selectedFoods', data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.5 - widget.animation.value), 0.0),
            child: Container(
              // height: 250,
              child: Padding(
                  padding: const EdgeInsets.only(
                      left: 5, right: 5, top: 5, bottom: 5),
                  child: InkWell(
                    splashColor: Colors.transparent,
                    onTap: () {
                      moveTo(widget.foodData, widget.selectedFoods);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.6),
                            offset: const Offset(6, 5),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Expanded(
                                  flex: 6,
                                  child: AspectRatio(
                                    aspectRatio: 2,
                                    child: Image.asset(
                                      widget.foodData.imagePath,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Container(
                                    // height: ,
                                    color: FoodAppTheme.buildLightTheme()
                                        .backgroundColor,
                                    child: Row(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      // crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5, top: 5, bottom: 6),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    widget.foodData.titleTxt,
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: Text(
                                                          widget.foodData
                                                              .description,
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, top: 5, bottom: 5),
                                          child: Column(
                                            // crossAxisAlignment:
                                            //     CrossAxisAlignment.end,
                                            // mainAxisAlignment:
                                            //     MainAxisAlignment.end,
                                            children: <Widget>[
                                              Text(
                                                '${widget.foodData.price}€',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  color: FoodAppTheme
                                                          .buildLightTheme()
                                                      .primaryColor,
                                                ),
                                              ),
                                              Container(
                                                // padding: const EdgeInsets.only(
                                                //     top: 8),
                                                width: 30,
                                                height: 40,
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
                                                      widget.foodData.isSelected
                                                          ? widget.selectedFoods
                                                              .add(widget
                                                                  .foodData)
                                                          : widget.selectedFoods
                                                              .remove(widget
                                                                  .foodData);
                                                      _saveSelectedFoods(
                                                          selectedItemId(widget
                                                              .selectedFoods));
                                                      widget.notifyParent();
                                                    });
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
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

  void moveTo(data, selectedFoods) {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => FoodInfoScreen(
          foodData: data,
          selectedFoods: selectedFoods,
          notify: refresh,
        ),
      ),
    );
  }

  refresh() {
    setState(() {});
    print(widget.foodData.titleTxt);
  }
}
