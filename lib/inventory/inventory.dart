// inventory.dart
import 'item.dart';

class Inventory {
  List<Item> items;

  Inventory({required this.items});

  // Adiciona um item ao inventário
  void addItem(Item item) {
    items.add(item);
  }

  // Remove um item do inventário
  void removeItem(Item item) {
    items.remove(item);
  }
}
