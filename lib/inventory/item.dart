class Item {
  final String name;
  final String imagePath; // Caminho da imagem do item, se aplicável

  Item({
    required this.name,
    this.imagePath = '', // Por padrão, não há imagem
  });
}
