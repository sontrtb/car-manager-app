import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrSanner extends StatelessWidget {
  QrSanner({super.key, required this.onScanSuccess});

  final void Function(String code) onScanSuccess;

  bool isScannerSuccess = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Expanded(
          child: MobileScanner(
            onDetect: (capture) {
              if (isScannerSuccess) return;
              final List<Barcode> barcodes = capture.barcodes;
              for (final barcode in barcodes) {
                if (barcode.rawValue != null) {
                  onScanSuccess(barcode.rawValue!);
                  isScannerSuccess = true;
                }
              }
            },
          ),
        ),
        const Positioned(
          top: 80,
          right: 0,
          left: 0,
          child: Text(
            "Quét mã QR",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Positioned(
          top: 0,
          right: 50,
          left: 50,
          bottom: 0,
          child: Image.asset(
            "assets/images/qr_scanner.png",
          ),
        ),
        Positioned(
          bottom: 80,
          right: 0,
          left: 0,
          child: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Đóng",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
