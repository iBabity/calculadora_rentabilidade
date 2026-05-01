import 'package:flutter/material.dart';

/// Classe global para facilitar responsividade
class Responsive {
  final BuildContext context;
  Responsive(this.context);

  /// Largura total da tela
  double get width => MediaQuery.of(context).size.width;

  /// Altura total da tela
  double get height => MediaQuery.of(context).size.height;

  /// Escalonamento baseado na largura (para textos, paddings, icones)
  double scale(double value) => value * (width / 390);

  /// Escalonamento vertical (menos usado, mas bom para caixas)
  double scaleH(double value) => value * (height / 844);

  /// Breakpoints (ponto de corte entre telas menores e maiores)
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;
}
