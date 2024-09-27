import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int total = 0;
  final List<GlobalKey<_ShoppingItemState>> _shoppingItemKeys = [
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
    GlobalKey<_ShoppingItemState>(),
  ];

  void incrementNumber(int count, int price) {
    setState(() {
      total += count * price;
      if (total < 0) total = 0;
    });
  }

  void clearAll() {
    setState(() {
      total = 0;
      for (var key in _shoppingItemKeys) {
        key.currentState?.resetCount();
      }
    });
  }

  String formatCurrency(int amount) {
    final formatter = NumberFormat('#,###');
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("SHOP APPLE"),
          backgroundColor: Color.fromARGB(255, 114, 114, 114),
          foregroundColor: Colors.white,
        ),
        body: Column(children: [
          Expanded(
            child: ListView(
              children: [
                ShoppingItem(
                  key: _shoppingItemKeys[0],
                  title: "iPad",
                  price: 19000,
                  onIncrement: (int count, int price) {
                    incrementNumber(count, price);
                  },
                ),
                ShoppingItem(
                  key: _shoppingItemKeys[1],
                  title: "iPad mini",
                  price: 23000,
                  onIncrement: (int count, int price) {
                    incrementNumber(count, price);
                  },
                ),
                ShoppingItem(
                  key: _shoppingItemKeys[2],
                  title: "iPad Air",
                  price: 29000,
                  onIncrement: (int count, int price) {
                    incrementNumber(count, price);
                  },
                ),
                ShoppingItem(
                  key: _shoppingItemKeys[3],
                  title: "iPad Pro",
                  price: 39000,
                  onIncrement: (int count, int price) {
                    incrementNumber(count, price);
                  },
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Total",
                style: TextStyle(fontSize: 30),
              ),
              Text(
                formatCurrency(total),
                style: const TextStyle(fontSize: 30),
              ),
              const Text(
                "Bath",
                style: TextStyle(fontSize: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: clearAll,
                style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color.fromARGB(255, 114, 114, 114)),
                child: const Text("Clear"),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ]),
      ),
    );
  }
}

class ShoppingItem extends StatefulWidget {
  final String title;
  final int price;
  final Function(int count, int price) onIncrement;

  ShoppingItem({
    required Key key,
    required this.title,
    required this.price,
    required this.onIncrement,
  }) : super(key: key);

  @override
  State<ShoppingItem> createState() => _ShoppingItemState();
}

class _ShoppingItemState extends State<ShoppingItem> {
  int count = 0;

  void resetCount() {
    setState(() {
      count = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 28),
              ),
              Text("${widget.price}฿")
            ],
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (count > 0) {
                    count--;
                    widget.onIncrement(-1, widget.price);
                  }
                });
              },
              icon: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 28),
            ),
            const SizedBox(
              width: 10,
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  count++;
                  widget.onIncrement(1, widget.price);
                });
              },
              icon: const Icon(Icons.add),
            )
          ],
        )
      ],
    );
  }
}
