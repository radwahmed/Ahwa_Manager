import 'package:flutter/material.dart';
import '../models/drink.dart';
import '../models/order.dart';
import '../services/order_service.dart';
import '../services/report_service.dart';
import '../widgets/pending_orders_list.dart';

class AhwaHomePage extends StatefulWidget {
  const AhwaHomePage({super.key});

  @override
  State<AhwaHomePage> createState() => _AhwaHomePageState();
}

class _AhwaHomePageState extends State<AhwaHomePage> {
  late final OrderService _orderService;
  late final Report _reportService;

  final List<Drink> _availableDrinks = [
    Tea(),
    MintTea(),
    Turkish(),
    Hibiscus(),
  ];

  @override
  void initState() {
    super.initState();
    _orderService = Orders();
    _reportService = Report(_orderService);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F0),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4E342E),
        elevation: 0,
        title: const Text(
          'Ahwa Manager',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _showReportsDialog,
            icon: const Icon(Icons.analytics, color: Colors.white),
          ),
          const SizedBox(width: 8)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 24, 20, 8),
            child: Text(
              "Choose your favorite drink ☕",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4E342E),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: _availableDrinks.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .75,
              ),
              itemBuilder: (context, index) {
                final drink = _availableDrinks[index];
                return _buildDrinkCard(drink);
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF4E342E),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(24)),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.shade200,
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                )
              ],
            ),
            child: Row(
              children: [
                const Icon(Icons.list_alt, color: Colors.white),
                const SizedBox(width: 8),
                const Text(
                  "Pending Orders",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (context) => SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: PendingOrdersList(
                            orderService: _orderService,
                            onComplete: _completeOrder,
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text(
                    "View",
                    style: TextStyle(color: Colors.orangeAccent),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrinkCard(Drink drink) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.shade100,
            blurRadius: 8,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // صورة رمزية للمشروب (ممكن تستبدلها بصورة حقيقية)
          Container(
            height: 110,
            decoration: BoxDecoration(
              color: Colors.brown.shade200,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: const Center(
              child: Icon(Icons.local_cafe, color: Colors.white, size: 40),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  drink.drinkName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4E342E),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "EGP 25",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.brown.shade400,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 8),
                    ),
                    onPressed: () => _showAddOrderDialog(drink),
                    child: const Text("Add to Cart"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddOrderDialog(Drink drink) {
    final customerNameController = TextEditingController();
    final instructionsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add ${drink.drinkName} Order'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: customerNameController,
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: instructionsController,
                decoration: const InputDecoration(
                  labelText: 'Special Instructions',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (customerNameController.text.isNotEmpty) {
                  _addOrder(
                    customerNameController.text,
                    drink,
                    instructionsController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            )
          ],
        );
      },
    );
  }

  void _addOrder(String customerName, Drink drink, String instructions) {
    final order = Order(
      id: '',
      customerName: customerName,
      drink: drink,
      instructions: instructions,
    );
    _orderService.addOrder(order);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${drink.drinkName} added for $customerName'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _completeOrder(String orderId) {
    _orderService.markOrderCompleted(orderId);
    setState(() {});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Order $orderId completed!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showReportsDialog() {
    final totalOrders = _reportService.getTotalOrdersServed();
    final topDrinks = _reportService.getTopSellingDrinks();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Daily Sales Report'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total Orders Served: $totalOrders'),
              const SizedBox(height: 8),
              const Text('Top Selling Drinks:'),
              ...topDrinks.entries.map((e) => Text('${e.key}: ${e.value}')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            )
          ],
        );
      },
    );
  }
}
