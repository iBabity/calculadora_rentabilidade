import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/utils/responsive.dart';
import '../../../shared/constants/sizes.dart';
import '../../../shared/constants/text_sizes.dart';

import '../providers/calculator_provider.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final investimentoController = TextEditingController();
  final retornoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CalculatorProvider>();
    final r = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Calculadora de Rentabilidade",
          style: TextStyle(fontSize: r.scale(TextSizes.title)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(r.scale(AppSizes.p20)),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: investimentoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Valor investido",
                  ),
                  style: TextStyle(fontSize: r.scale(TextSizes.normal)),
                ),
                SizedBox(height: r.scale(AppSizes.p20)),

                TextField(
                  controller: retornoController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Retorno obtido",
                  ),
                  style: TextStyle(fontSize: r.scale(TextSizes.normal)),
                ),

                SizedBox(height: r.scale(AppSizes.p32)),

                SizedBox(
                  height: r.scale(48),
                  child: ElevatedButton(
                    onPressed: () {
                      final investimento =
                          double.tryParse(investimentoController.text) ?? 0;

                      final retorno =
                          double.tryParse(retornoController.text) ?? 0;

                      context
                          .read<CalculatorProvider>()
                          .calcular(investimento, retorno);
                    },
                    child: Text(
                      "Calcular",
                      style: TextStyle(fontSize: r.scale(TextSizes.large)),
                    ),
                  ),
                ),

                SizedBox(height: r.scale(AppSizes.p32)),

                if (provider.resultado != null)
                  Column(
                    children: [
                      Text(
                        "Rentabilidade:",
                        style: TextStyle(
                          fontSize: r.scale(TextSizes.large),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: r.scale(AppSizes.p12)),
                      Text(
                        "${provider.resultado!.percentual.toStringAsFixed(2)}%",
                        style: TextStyle(
                          fontSize: r.scale(32),
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
