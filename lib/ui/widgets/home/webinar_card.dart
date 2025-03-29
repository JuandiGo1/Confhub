import 'package:confhub/core/colors.dart';
import 'package:flutter/material.dart';

class Webinarcard extends StatelessWidget {
  final String title;
  final String date;
  final String category;
  final Color color;
  final int attendees; // Número de asistentes
  final String speakerAvatar; // URL o ruta del avatar del speaker

  const Webinarcard({
    super.key,
    required this.title,
    required this.date,
    required this.category,
    required this.color,
    required this.attendees,
    required this.speakerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    final colorText =
        color == AppColors.primary ? Colors.white : AppColors.secondary;
    return Container(
      width: 180,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Colors.white,
          width: 4,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category,
              style: TextStyle(color: colorText, fontWeight: FontWeight.w500)),
          SizedBox(height: 8),
          Text(title,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: colorText)),
          Spacer(),
          Text(" $date", style: TextStyle(color: colorText)),
          SizedBox(height: 8),
          // Número de asistentes
          Row(
            children: [
              Icon(Icons.people, color: colorText, size: 16),
              SizedBox(width: 4),
              Text(
                "$attendees Asistentes",
                style: TextStyle(color: colorText, fontSize: 13),
              ),
            ],
          ),
          SizedBox(height: 8), // Espaciado entre la fecha y la nueva fila
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.campaign, color: colorText, size: 16),
                  SizedBox(width: 4),
                  Text(
                    "Orador",
                    style: TextStyle(color: colorText, fontSize: 16),
                  ),
                ],
              ),
              // Avatar del speaker
              CircleAvatar(
                radius: 16,
                backgroundImage:
                    NetworkImage(speakerAvatar), // Imagen del speaker
                backgroundColor:
                    Colors.grey[200], // Color de fondo si no hay imagen
              ),
            ],
          ),
        ],
      ),
    );
  }
}
