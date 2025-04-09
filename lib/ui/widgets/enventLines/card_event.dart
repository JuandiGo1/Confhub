import 'package:confhub/core/colors.dart';
import 'package:flutter/material.dart';

class CardEvent extends StatelessWidget {
  final int eventAmount;
  final String title;
  final String date;
  final int color;

  const CardEvent(
      {super.key,
      required this.eventAmount,
      required this.title,
      required this.color,
      required this.date});

  Color _getColorFromCode(int code) {
    switch (code) {
      case 0:
        return const Color.fromRGBO(53, 144, 243, 1);
      case 1:
        return const Color.fromRGBO(81, 123, 97, 1);
      case 2:
        return AppColors.cardThird;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color mColor = _getColorFromCode(color);

    return Container(
      width: 140,
      height: 140,
      decoration: BoxDecoration(
        color: mColor,
        border: Border.all(
          color: Colors.black,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(title,
                      style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold)))),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: AppColors.background, // Color del borde
                  width: 1.0, // Grosor del borde
                ),
              ),
            ),
            child: Text(
              date,
              style: TextStyle(
                color: AppColors.background,
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
          Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  bottomRight: Radius.circular(12),
                ),
              ),
              child: Text(
                '$eventAmount en vivo',
                style: TextStyle(color: AppColors.textPrimary),
              ))
        ],
      ),
    );
  }
}
