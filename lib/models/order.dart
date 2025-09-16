import 'drink.dart';

class Order {
  final String id;
  final String customerName;
  final Drink drink;
  final String instructions;
  bool isCompleted;

  Order({
    required this.id,
    required this.customerName,
    required this.drink,
    this.instructions = '',
    this.isCompleted = false,
  });

  void completeOrder() {
    isCompleted = true;
  }
}
