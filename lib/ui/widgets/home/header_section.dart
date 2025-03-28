import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Perfil
        Row(
          children: [
             Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/confhub_logo.png"),
                  fit: BoxFit.cover
                  ),
              ),
             ),
             
          ],
        ),
        // Icono de notificaciones
        IconButton(
          icon:  Icon(Icons.settings , size: 28),
          onPressed: () {},
        ),
      ],
    );
  }
}