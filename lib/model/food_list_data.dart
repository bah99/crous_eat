class FoodListData {
  FoodListData({
    this.id,
    this.imagePath = '',
    this.titleTxt = '',
    this.description = '',
    this.allergenes,
    this.price = 180,
    this.isSelected = false,
  });

  int id;
  String imagePath;
  String titleTxt;
  String description;
  List<dynamic> allergenes = [];
  int price;
  bool isSelected;

  static List<FoodListData> foodList = <FoodListData>[
    FoodListData(
      id: 1,
      imagePath: 'assets/foods/pizza.png',
      titleTxt: 'Pizza',
      description: 'Pizza au thon et fromage',
      allergenes: ['allergene1', 'allergene2', 'allergene3', 'allergene4'],
      price: 8,
      isSelected: false,
    ),
    FoodListData(
      id: 2,
      imagePath: 'assets/foods/burger.png',
      titleTxt: 'Burger',
      description: 'Triple Cheese Burger Burger King',
      allergenes: ['allergene1', 'allergene2', 'allergene3', 'allergene4'],
      price: 7,
      isSelected: false,
    ),
    FoodListData(
      id: 3,
      imagePath: 'assets/foods/tacos.png',
      titleTxt: 'Tacos',
      description:
          'Tacos',
      allergenes: ['allergene1', 'allergene2', 'allergene3', 'allergene4'],
      price: 6,
      isSelected: false,
    ),
    FoodListData(
      id: 4,
      imagePath: 'assets/foods/brochette.png',
      titleTxt: 'Brochettes',
      description: 'Brochettes d\'agneau',
      allergenes: ['allergene1', 'allergene2', 'allergene3', 'allergene4'],
      price: 18,
      isSelected: false,
    ),
    FoodListData(
      id: 5,
      imagePath: 'assets/foods/kebab.png',
      titleTxt: 'Kebab',
      description: 'Kebab au boeuf',
      allergenes: ['allergene1', 'allergene2', 'allergene3', 'allergene4'],
      price: 6,
      isSelected: false,
    ),
  ];
}
