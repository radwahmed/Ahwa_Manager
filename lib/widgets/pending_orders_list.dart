import 'package:flutter/material.dart';
import '../services/order_service.dart';

class PendingOrdersList extends StatelessWidget {
  final OrderService orderService;
  final void Function(String) onComplete;

  const PendingOrdersList({
    super.key,
    required this.orderService,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final pendingOrders = orderService.getPendingOrders();

    if (pendingOrders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.coffee, size: 64, color: Colors.brown[300]),
            const SizedBox(height: 16),
            Text(
              'No pending orders',
              style: TextStyle(
                fontSize: 18,
                color: Colors.brown[600],
              ),
            ),
            Text(
              'Order now!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.brown[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: pendingOrders.length,
      itemBuilder: (context, index) {
        final order = pendingOrders[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.brown[600],
              child: Text(
                '${index + 1}',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            title: Text(
              '${order.customerName} - ${order.drink.drinkName}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: order.instructions.isNotEmpty
                ? Text(
                    'Instructions: ${order.instructions}',
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  )
                : null,
            trailing: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () => onComplete(order.id),
              child: const Text('Complete'),
            ),
          ),
        );
      },
    );
  }
}
