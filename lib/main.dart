import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MeatCut {
  final String name;
  final double weight;

  MeatCut({
    required this.name,
    required this.weight,
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de Rentabilidade',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController valorPagoController = TextEditingController();
  final TextEditingController pesoTotalController = TextEditingController();
  final TextEditingController pesoPerdaController = TextEditingController();
  final TextEditingController nomeCorteController = TextEditingController();
  final TextEditingController pesoCorteController = TextEditingController();

  final List<MeatCut> cuts = [];

  double pesoAproveitado = 0;
  double custoKgReal = 0;
  double percentualPerda = 0;

  // 🔒 começa oculto
  bool mostrarValores = false;
  int contadorCliqueTitulo = 0;

  @override
  void dispose() {
    valorPagoController.dispose();
    pesoTotalController.dispose();
    pesoPerdaController.dispose();
    nomeCorteController.dispose();
    pesoCorteController.dispose();
    super.dispose();
  }

  double parseValue(String value) {
    return double.tryParse(value.replaceAll(',', '.')) ?? 0;
  }

  double get valorPago => parseValue(valorPagoController.text);
  double get pesoTotal => parseValue(pesoTotalController.text);
  double get pesoPerda => parseValue(pesoPerdaController.text);

  double get somaPesosCortes {
    return cuts.fold(0, (total, cut) => total + cut.weight);
  }

  void calcularBase() {
    final aproveitado = pesoTotal - pesoPerda;

    setState(() {
      pesoAproveitado = aproveitado > 0 ? aproveitado : 0;

      custoKgReal =
          pesoAproveitado > 0 ? valorPago / pesoAproveitado : 0;

      percentualPerda =
          pesoTotal > 0 ? (pesoPerda / pesoTotal) * 100 : 0;
    });
  }

  void adicionarCorte() {
    final nome = nomeCorteController.text.trim();
    final peso = parseValue(pesoCorteController.text);

    if (nome.isEmpty || peso <= 0) {
      _mostrarMensagem('Preencha o nome do corte e um peso válido.');
      return;
    }

    if (pesoAproveitado <= 0) {
      _mostrarMensagem('Calcule a base primeiro.');
      return;
    }

    final novaSoma = somaPesosCortes + peso;

    if (novaSoma > pesoAproveitado) {
      _mostrarMensagem(
        'Peso dos cortes ultrapassa o limite!\n'
        'Atual: ${somaPesosCortes.toStringAsFixed(2)} kg\n'
        'Máximo: ${pesoAproveitado.toStringAsFixed(2)} kg',
      );
      return;
    }

    setState(() {
      cuts.add(MeatCut(name: nome, weight: peso));
      nomeCorteController.clear();
      pesoCorteController.clear();
    });
  }

  void _mostrarMensagem(String texto) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(texto)),
    );
  }

  // 🔒 comando secreto
  void _toggleModoSecreto() {
    contadorCliqueTitulo++;

    if (contadorCliqueTitulo >= 5) {
      setState(() {
        mostrarValores = !mostrarValores;
      });

      contadorCliqueTitulo = 0;

      _mostrarMensagem(
        mostrarValores
            ? 'Valores VISÍVEIS'
            : 'Valores OCULTOS',
      );
    }
  }

  double percentualSobreAproveitado(double pesoCorte) {
    if (pesoAproveitado <= 0) return 0;
    return (pesoCorte / pesoAproveitado) * 100;
  }

  double valorDoCorte(double pesoCorte) {
    if (custoKgReal <= 0) return 0;
    return pesoCorte * custoKgReal;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: _toggleModoSecreto,
          child: const Text('Calculadora de Rentabilidade'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Dados da peça',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: valorPagoController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Valor pago (R\$)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: pesoTotalController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Peso total (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: pesoPerdaController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Perda (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  ElevatedButton(
                    onPressed: calcularBase,
                    child: const Text('Calcular base'),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Base calculada',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),

                          Text(
                              'Peso aproveitado: ${pesoAproveitado.toStringAsFixed(2)} kg'),
                          Text(
                              'Perda: ${percentualPerda.toStringAsFixed(2)}%'),
                          Text(
                              'Custo/kg: R\$ ${custoKgReal.toStringAsFixed(2)}'),
                          Text(
                              'Cortes: ${somaPesosCortes.toStringAsFixed(2)} kg'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Adicionar cortes',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: nomeCorteController,
                    decoration: const InputDecoration(
                      labelText: 'Nome do corte',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  TextField(
                    controller: pesoCorteController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Peso (kg)',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 12),

                  ElevatedButton(
                    onPressed: adicionarCorte,
                    child: const Text('Adicionar corte'),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Cortes lançados',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 12),

                  if (cuts.isEmpty)
                    const Text('Nenhum corte adicionado.')
                  else
                    ...cuts.asMap().entries.map((entry) {
                      final index = entry.key;
                      final cut = entry.value;

                      final perc =
                          percentualSobreAproveitado(cut.weight);
                      final valor = valorDoCorte(cut.weight);

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(
                                cut.name,
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  'Peso: ${cut.weight.toStringAsFixed(2)} kg'),
                              Text(
                                  'Percentual: ${perc.toStringAsFixed(2)}%'),

                              // 🔒 NÃO mostra nada quando oculto
                              if (mostrarValores)
                                Text(
                                    'Valor: R\$ ${valor.toStringAsFixed(2)}'),

                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      cuts.removeAt(index);
                                    });
                                  },
                                  child: const Text('Remover'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),

                  const SizedBox(height: 20),

                  const Center(
                    child: Text(
                      '© Eder Cipriano',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}