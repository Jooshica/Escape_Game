class Item {
  final String name;
  final String description;
  final String imagePath;
  bool inInventory; // Propriedade para rastrear se o item está no inventário
  final bool isVertical; // Indica se o item deve ser exibido na vertical no inventário
  final double inventoryImageSize; // Tamanho da imagem do item no inventário

  Item({
    required this.name,
    required this.description,
    required this.imagePath,
    this.inInventory = false, // Valor padrão para inInventory é false
    this.isVertical = false, // Valor padrão para isVertical é false
    this.inventoryImageSize = 50, // Valor padrão para inventoryImageSize é 50
  });

  void setInInventory(bool value) {
    inInventory = value;
  }

  @override
  String toString() {
    return '$name,$description,$imagePath,$inInventory';
  }

  static Item fromString(String itemString) {
    List<String> parts = itemString.split(',');
    return Item(
      name: parts[0],
      description: parts[1],
      imagePath: parts[2],
      inInventory: parts[3].toLowerCase() == 'true',
    );
  }
}
