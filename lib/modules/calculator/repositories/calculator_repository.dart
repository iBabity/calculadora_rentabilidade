class CalculatorRepository {
  double calcularPercentual(double investimento, double retorno) {
    if (investimento == 0) return 0;
    return ((retorno - investimento) / investimento) * 100;
  }
}
