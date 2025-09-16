import '../models/order.dart';

abstract class OrderService {
  void addOrder(Order order);
  List<Order> getPendingOrders();
  void markOrderCompleted(String orderId);
  List<Order> getAllOrders();
}

class Orders implements OrderService {
  final List<Order> _orders = [];
  int _nextOrderId = 1;

  @override
  void addOrder(Order order) {
    if (order.id.isEmpty) {
      order = Order(
        id: (_nextOrderId++).toString(),
        customerName: order.customerName,
        drink: order.drink,
        instructions: order.instructions,
        isCompleted: order.isCompleted,
      );
    }
    _orders.add(order);
  }

  @override
  List<Order> getPendingOrders() {
    return _orders.where((order) => !order.isCompleted).toList();
  }

  @override
  void markOrderCompleted(String orderId) {
    final orderIndex = _orders.indexWhere((order) => order.id == orderId);
    if (orderIndex != -1) {
      _orders[orderIndex].completeOrder();
    }
  }

  @override
  List<Order> getAllOrders() {
    return List.unmodifiable(_orders);
  }
}
