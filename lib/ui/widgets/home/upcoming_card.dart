import 'package:confhub/core/colors.dart';
import 'package:flutter/material.dart';

class UpcomingCard extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String category;
  final String speakerAvatar;

  const UpcomingCard({
    super.key,
    required this.title,
    required this.date,
    required this.time,
    required this.category,
    required this.speakerAvatar,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 100,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title,
                        style: TextStyle(
                            color: AppColors.secondary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    Icon(Icons.more_horiz, color: AppColors.secondary, size: 14)
                  ],
                ),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: AppColors.secondary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.sell_outlined, color: Colors.white, size: 16),
                          Text(category, style: TextStyle(color: Colors.white),)
                        ],
                      ) ,
                    ),
                    
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.schedule, color: AppColors.textPrimary, size: 20),
                  SizedBox(width: 4),
                  Text(
                    date,
                    style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
                  ),
                ],
              ),
              Text(time),
              ElevatedButton(
                onPressed: () {},
                child: Text("Join Now"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
