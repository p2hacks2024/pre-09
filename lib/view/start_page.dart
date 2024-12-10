import 'package:flutter/material.dart';

import 'package:ebidence/constant/app_color.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.brand.secondary,
      body: Padding(
        padding: EdgeInsets.only(
          top: deviceHeight / 13,
          right: deviceWidth / 6,
          left: deviceWidth / 6,
        ),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(150),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 1.0,
                          color: Colors.black38,
                          spreadRadius: 1.0,
                          offset: Offset(10, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(150),
                      child: Image.asset(
                        'assets/images/logo.png',
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(
                        'assets/images/shrimp.png',
                        width: deviceWidth / 7,
                      ),
                      Image.asset(
                        'assets/images/shrimp.png',
                        width: deviceWidth / 7,
                      ),
                      Image.asset(
                        'assets/images/shrimp.png',
                        width: deviceWidth / 7,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        style: IconButton.styleFrom(
                            foregroundColor: AppColor.brand.logo,
                            backgroundColor: AppColor.brand.primary,
                            iconSize: deviceWidth / 18,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog();
                            },
                          );
                        },
                        icon: const Icon(Icons.volume_up_rounded),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          fixedSize: Size(deviceWidth / 5, deviceHeight / 9),
                          foregroundColor: AppColor.brand.logo,
                          backgroundColor: AppColor.brand.primary,
                          textStyle: TextStyle(
                            fontSize: deviceWidth / 23,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog();
                            },
                          );
                        },
                        child: const Text("START"),
                      ),
                      IconButton(
                        style: IconButton.styleFrom(
                            foregroundColor: AppColor.brand.logo,
                            backgroundColor: AppColor.brand.primary,
                            iconSize: deviceWidth / 18,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const AlertDialog();
                            },
                          );
                        },
                        icon: const Icon(Icons.exit_to_app_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            TextButton(
              style: TextButton.styleFrom(
                fixedSize: Size(deviceWidth / 5, deviceHeight / 9),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog();
                  },
                );
              },
              child: Text(
                "＠ガリバタコーン",
                style: TextStyle(
                    color: Colors.white54, fontSize: deviceWidth / 70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
