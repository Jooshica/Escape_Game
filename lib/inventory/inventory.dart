import 'dart:convert';

import 'item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Inventory {
  List<Item> items;

  Inventory({required this.items}) {
    loadInventory();
  }

  // Adiciona um item ao inventário
  void addItem(Item item) async {
    items.add(item);
    item.inInventory = true;
    await saveInventory();
  }

  // Remove um item do inventário
  void removeItem(Item item) async {
    items.remove(item);
    item.inInventory = false;
    await saveInventory();
  }

  // Verifica se o item está no inventário pelo nome
  bool containsItem(String itemName) {
    return items.any((item) => item.name == itemName);
  }

  Future<void> saveInventory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> itemsJson = items.map((item) => itemToJson(item)).toList();
    await prefs.setStringList('inventory', itemsJson);
  }

  String itemToJson(Item item) {
    Map<String, dynamic> json = {
      'name': item.name,
      'description': item.description,
      'imagePath': item.imagePath,
      'inInventory': item.inInventory,
    };
    return jsonEncode(json);
  }

  Future<void> loadInventory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? itemsJson = prefs.getStringList('inventory');
    if (itemsJson != null) {
      items = itemsJson.map((itemJson) => itemFromJson(itemJson)).toList();
    }
  }

  Item itemFromJson(String itemJson) {
    Map<String, dynamic> json = jsonDecode(itemJson);
    return Item(
      name: json['name'],
      description: json['description'],
      imagePath: json['imagePath'],
      inInventory: json['inInventory'],
    );
  }
}
