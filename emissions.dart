import 'package:flutter/material.dart';
import 'food_item.dart';

class EmissionsCalculator extends StatefulWidget {
  const EmissionsCalculator({super.key});

  @override
  _EmissionsCalculatorState createState() => _EmissionsCalculatorState();
}

class _EmissionsCalculatorState extends State<EmissionsCalculator> {
  final List<FoodItem> _foodItems = [
    FoodItem(
      name: 'Beef',
      carbonPerKg: 27.0,
      landPerKg: 164.0,
      waterPerKg: 15400.0,
      category: 'Meat',
      imagePath: 'assets/beef.png',
    ),
    FoodItem(
      name: 'Lamb',
      carbonPerKg: 39.2,
      landPerKg: 185.0,
      waterPerKg: 10400.0,
      category: 'Meat',
      imagePath: 'assets/lamb.png',
    ),
    FoodItem(
      name: 'Chicken',
      carbonPerKg: 6.9,
      landPerKg: 7.1,
      waterPerKg: 4300.0,
      category: 'Meat',
      imagePath: 'assets/chicken.png',
    ),
    FoodItem(
      name: 'Rice',
      carbonPerKg: 2.7,
      landPerKg: 2.8,
      waterPerKg: 2500.0,
      category: 'Grains',
      imagePath: 'assets/rice.png',
    ),
    FoodItem(
      name: 'Potatoes',
      carbonPerKg: 0.3,
      landPerKg: 0.4,
      waterPerKg: 287.0,
      category: 'Vegetables',
      imagePath: 'assets/potatoes.png',
    ),
    FoodItem(
      name: 'Carrot',
      carbonPerKg: 0.3,
      landPerKg: 0.4,
      waterPerKg: 287.0,
      category: 'Vegetables',
      imagePath: 'assets/potatoes.png',
    ),
    FoodItem(
      name: 'Milk',
      carbonPerKg: 1.9,
      landPerKg: 8.9,
      waterPerKg: 1020.0,
      category: 'Dairy',
      imagePath: 'assets/milk.png',
    ),
  ];

  final List<String> _categories = ['All', 'Meat', 'Dairy', 'Vegetables', 'Grains', 'Fruits'];
  String _selectedCategory = 'All';
  List<FoodItem> _filteredItems = [];
  final List<FoodItem> _selectedFoodItems = [];
  double _totalEmissions = 0.0;
  double _totalLandUse = 0.0;
  double _totalWaterUse = 0.0;
  
  final Map<String, double> _quantities = {};

  // Static comparison data for an average car
  final List<ComparisonItem> _comparisonItems = [
    ComparisonItem(
      name: 'Average Car (Annual)',
      carbonFootprint: 4600.0, // ~4.6 metric tons CO₂e per year for an average car (EPA estimate)
      description: 'Based on an average car driving 12,000 miles/year at 25 MPG',
    ),
  ];
  
    @override
  void initState() {
    super.initState();
    _filteredItems = List.from(_foodItems);
  }

  void _filterByCategory(String category) {
    setState(() {
      _selectedCategory = category;
      if (category == 'All') {
        _filteredItems = List.from(_foodItems);
      } else {
        _filteredItems = _foodItems.where((item) => item.category == category).toList();
      }
    });
  }

  void _addFoodItem(FoodItem item) {
    setState(() {
      if (!_quantities.containsKey(item.name)) {
        _quantities[item.name] = 0.1; // Default 100g
      }
      
      if (!_selectedFoodItems.contains(item)) {
        _selectedFoodItems.add(item);
      }
      
      _calculateTotals();
    });
  }

  void _removeFoodItem(FoodItem item) {
    setState(() {
      _selectedFoodItems.remove(item);
      _quantities.remove(item.name);
      _calculateTotals();
    });
  }

  void _updateQuantity(String foodName, double quantity) {
    setState(() {
      _quantities[foodName] = quantity;
      _calculateTotals();
    });
  }

  void _calculateTotals() {
    double emissions = 0.0;
    double land = 0.0;
    double water = 0.0;
    
    for (var item in _selectedFoodItems) {
      final quantity = _quantities[item.name]!;
      emissions += item.carbonPerKg * quantity;
      land += item.landPerKg * quantity;
      water += item.waterPerKg * quantity;
    }
    
    _totalEmissions = emissions;
    _totalLandUse = land;
    _totalWaterUse = water;
  }

  FoodItem? _findBetterAlternative(FoodItem item) {
    final sameCategoryItems = _foodItems.where((i) => i.category == item.category && i.name != item.name).toList();
    if (sameCategoryItems.isEmpty) return null;

    return sameCategoryItems.reduce((a, b) {
      final scoreA = a.carbonPerKg + a.landPerKg + (a.waterPerKg / 1000);
      final scoreB = b.carbonPerKg + b.landPerKg + (b.waterPerKg / 1000);
      return scoreA < scoreB ? a : b;
    });
  }
