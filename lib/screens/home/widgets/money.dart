import 'package:car_manager_app/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _urlPhone = Uri.parse('tel://0355677825');
final f = NumberFormat("###,###.###", "tr_TR");

// ignore: must_be_immutable
class Money extends StatelessWidget {
  const Money({super.key, required this.money});

  final int money;

  void _openRecharge(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Liên hệ chủ xe",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.network(
              "https://cdn-icons-png.flaticon.com/512/3410/3410491.png",
              width: 200,
            ),
            ElevatedButtonWidget(
              isFullWidth: true,
              text: "Gọi điện liên hệ",
              onPressed: () => {
                launchUrl(_urlPhone),
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 50, 30, 30),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Số tiền còn lại:"),
              const SizedBox(
                height: 5,
              ),
              Text(
                f.format(money),
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.w900,
                    color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          OutlinedButtonWidget(
            text: "Nạp tiền",
            onPressed: () {
              _openRecharge(context);
            },
          )
        ],
      ),
    );
  }
}
