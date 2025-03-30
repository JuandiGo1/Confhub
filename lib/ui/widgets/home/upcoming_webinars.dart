import 'package:confhub/core/colors.dart';
import 'package:flutter/material.dart';

class UpcomingWebinars extends StatelessWidget {
  const UpcomingWebinars({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(230, 243, 243, 243),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Próximos Webinars",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: AppColors.title,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      // Acción para el botón "Ver más"
                    },
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.all(5), 
                    ),
                    child: Row(
                      children: [
                        Text(
                          "Ver más",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(width: 5), // Espaciado entre el texto y el ícono
                        Icon(Icons.east, color: AppColors.primary),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  //  tarjetas de webinars
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
