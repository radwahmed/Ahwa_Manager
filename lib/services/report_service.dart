import 'order_service.dart';

abstract class ReportService {
  Map<String, int> getTopSellingDrinks();
  int getTotalOrdersServed();
}

class Report implements ReportService {
  final OrderService _orderService;

  Report(this._orderService);

  @override
  Map<String, int> getTopSellingDrinks() {
    final completedOrders =
        _orderService.getAllOrders().where((order) => order.isCompleted);
    final drinkCounts = <String, int>{};

    for (final order in completedOrders) {
      drinkCounts.update(order.drink.drinkName, (value) => value + 1,
          ifAbsent: () => 1);
    }

    final sortedDrinks = Map.fromEntries(
      drinkCounts.entries.toList()..sort((a, b) => b.value.compareTo(a.value)),
    );
    return sortedDrinks;
  }

  @override
  int getTotalOrdersServed() {
    return _orderService
        .getAllOrders()
        .where((order) => order.isCompleted)
        .length;
  }
}
