abstract class Drink {
  String get drinkName;
}

class Tea extends Drink {
  @override
  String get drinkName => 'shai';
}

class MintTea extends Drink {
  @override
  String get drinkName => 'mint shai';
}

class Turkish extends Drink {
  @override
  String get drinkName => 'Turkish coffee';
}

class Hibiscus extends Drink {
  @override
  String get drinkName => ' hibiscus tea';
}
