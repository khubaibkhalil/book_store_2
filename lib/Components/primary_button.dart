import 'package:book_store/Config/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String btnName;
  final String imgPath;
  final VoidCallback ontap;
  const PrimaryButton(
      {super.key,
      required this.btnName,
      required this.ontap,
      required this.imgPath});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 55,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: backgroudColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(imgPath),
            ),
            const SizedBox(width: 10),
            Text(
              btnName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.background,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
