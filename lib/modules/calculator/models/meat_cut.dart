class MeatCut {
  final String name;
  final double weight;
  final double pricePerKg;

  MeatCut({
    required this.name,
    required this.weight,
    required this.pricePerKg,
  });

  double get totalSaleValue => weight * pricePerKg;
}