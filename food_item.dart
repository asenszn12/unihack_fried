class FoodItem {
  final String name;
  final double carbonPerKg;  // kg CO₂e/kg
  final double landPerKg;    // m²/kg
  final double waterPerKg;   // L/kg
  final String category;
  final String imagePath;

  FoodItem({
    required this.name,
    required this.carbonPerKg,
    required this.landPerKg,
    required this.waterPerKg,
    required this.category,
    required this.imagePath,
  });
}

class ComparisonItem {
  final String name;
  final double carbonFootprint; // kg CO₂e
  final String description;

  ComparisonItem({
    required this.name,
    required this.carbonFootprint,
    required this.description,
  });
}
