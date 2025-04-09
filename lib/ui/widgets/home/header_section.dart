import 'package:confhub/ui/pages/event_lines.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Perfil
          Row(
            children: [
              Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/confhub.png"),
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          // Icono de notificaciones
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.event, size: 28),
                onPressed: () {
                  Get.to(() => EventLines());

                },
              ),
              IconButton(
                icon: Icon(Icons.settings, size: 28),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
