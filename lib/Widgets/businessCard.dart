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
        color: Colors.transparent,
        elevation: 8.0,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white, width: 3)),
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
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: const CircleAvatar(
                          radius: 50, //we give the image a radius of 50
                          backgroundImage: NetworkImage(
                              'https://webstockreview.net/images/male-clipart-professional-man-3.jpg'),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                name,
                                style: TextStyle(color: Colors.white),
                              ),
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
                            color: Colors.white,
                            height: 2,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '+91$phone_number',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            district,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(state, style: TextStyle(color: Colors.white)),
                          const SizedBox(height: 52),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                designation,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                company,
                                style: const TextStyle(color: Colors.white),
                              ),
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
