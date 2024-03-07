import 'package:flutter/material.dart';

class BusinessCard extends StatelessWidget {
  String name;
  String phone_number;
  String designation;
  String district;
  String state;
  String company;
  BusinessCard(
      {super.key,
      required this.name,
      required this.phone_number,
      required this.designation,
      required this.district,
      required this.state,
      required this.company});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.grey[300],
        elevation: 8.0,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          height: 220,
          width: 350,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      CircleAvatar(
                        radius: 50, //we give the image a radius of 50
                        backgroundImage: NetworkImage(
                            'https://webstockreview.net/images/male-clipart-professional-man-3.jpg'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 4),
                              Text(name),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        //CrossAxisAlignment.end ensures the components are aligned from the right to left.
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: 150,
                            color: Colors.black54,
                            height: 2,
                          ),
                          const SizedBox(height: 4),
                          Text('+91${phone_number}'),
                          Text(district),
                          Text(state),
                          const SizedBox(height: 45),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                designation,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(company),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
