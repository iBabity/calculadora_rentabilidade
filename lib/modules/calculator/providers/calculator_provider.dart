import 'package:flutter/material.dart';


import '../models/rentabilidade.dart';
import '../services/calculator_service.dart';

class CalculatorProvider with ChangeNotifier {
  final CalculatorService service;

  Rentabilidade? resultado;

  CalculatorProvider(this.service);

  void calcular(double investimento, double retorno) {
    resultado = service.calcular(investimento, retorno);
    notifyListeners();
  }
}
