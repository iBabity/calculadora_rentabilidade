import '../models/rentabilidade.dart';
import '../repositories/calculator_repository.dart';

class CalculatorService {
  final CalculatorRepository repository;

  CalculatorService(this.repository);

  Rentabilidade calcular(double investimento, double retorno) {
    final percentual = repository.calcularPercentual(investimento, retorno);

    return Rentabilidade(
      investimento: investimento,
      retorno: retorno,
      percentual: percentual,
    );
  }
}

