import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';

class ModalPrice extends StatefulWidget {
  const ModalPrice({super.key});

  @override
  State<ModalPrice> createState() => _ModalPriceState();
}

class _ModalPriceState extends State<ModalPrice> {
  void _handleSave() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Text(
                "Giá tiền một giờ: ",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextFormField(
                initialValue: '40.000',
              )
            ],
          ),
          ElevatedButtonWidget(
            isFullWidth: true,
            text: "Lưu",
            onPressed: _handleSave,
          ),
        ],
      ),
    );
  }
}
