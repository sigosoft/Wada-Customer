import 'package:flutter/material.dart';

class PaymentMethods extends StatefulWidget {
  @override
  _PaymentMethodsState createState() => _PaymentMethodsState();
}

class _PaymentMethodsState extends State<PaymentMethods> {
  int selectedPaymentIndex = -1;

  final List<Map<String, String>> paymentMethods = [
    {"title": "Online Payment"},
    {"title": "Wada Pay"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Methods")),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: List.generate(paymentMethods.length, (index) {
            final method = paymentMethods[index];
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedPaymentIndex = index;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAEFFA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Text(
                      method["title"]!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const Spacer(),
                    Radio<int>(
                      activeColor: Colors.blue,
                      value: index,
                      groupValue: selectedPaymentIndex,
                      onChanged: (value) {
                        setState(() {
                          selectedPaymentIndex = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}