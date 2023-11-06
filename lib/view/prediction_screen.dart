import 'package:country_picker/country_picker.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openai_app/provider/prediction_provider.dart';
import 'package:provider/provider.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController regionController = TextEditingController();
  final TextEditingController currencyController = TextEditingController();
  final CurrencyTextInputFormatter currencyFormatter =
      CurrencyTextInputFormatter(
    locale: 'id_ID',
    decimalDigits: 0,
    symbol: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recommend Me A Car!"),
      ),
      body: Form(
        key: formkey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: <Widget>[
            /// Title
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
                bottom: 20,
              ),
              child: Center(
                child: Text(
                  'Car Recommendation by OPEN AI',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),

            /// Region TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: regionController,
                readOnly: true,
                validator: (value) => value!.isEmpty ? 'Required' : null,
                onTap: () => showCountryPicker(
                  context: context,
                  showPhoneCode: false,
                  onSelect: (value) => regionController.text = value.name,
                ),
                decoration: InputDecoration(
                  label: const Text('Region'),
                  hintText: 'Select Region',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => regionController.clear(),
                    icon: const Icon(CupertinoIcons.clear_circled),
                  ),
                ),
              ),
            ),

            /// Currency TextField
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextFormField(
                controller: currencyController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  currencyFormatter,
                ],
                validator: (value) => value!.isEmpty ? 'Required' : null,
                decoration: InputDecoration(
                  label: const Text('Budget'),
                  hintText: 'Enter Your Budget (in IDR)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => currencyController.clear(),
                    icon: const Icon(CupertinoIcons.clear_circled),
                  ),
                ),
              ),
            ),

            

            /// Recommendation button
            Padding(
              padding: const EdgeInsets.only(bottom: 60),
              child: ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    context.read<PredictionProvider>().getRecommendations(
                          budget:
                              currencyFormatter.getUnformattedValue().toInt(),
                          manufacturerRegion: regionController.text,
                        );
                  }
                },
                child: const Text('GET RECOMMENDATION'),
              ),
            ),

            /// Result
            Consumer<PredictionProvider>(
              builder: (context, provider, _) {
                if (provider.openAiResponse != null) {
                  return Text(
                    provider.openAiResponse?.choices[0].text ?? '',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 18,
                        ),
                  );
                } else {
                  return const Icon(Icons.flutter_dash);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
