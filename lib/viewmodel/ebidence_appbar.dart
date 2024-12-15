import 'package:ebidence/constant/app_color.dart';
import 'package:flutter/material.dart';

class EbidenceAppbar extends StatelessWidget {
  const EbidenceAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;
    final buttonStyle = IconButton.styleFrom(
        foregroundColor: AppColor.brand.secondary,
        backgroundColor: AppColor.brand.primary,
        iconSize: deviceWidth / 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));
    final buttonStyle2 = IconButton.styleFrom(
        foregroundColor: AppColor.brand.primary,
        backgroundColor: AppColor.brand.secondary,
        iconSize: deviceWidth / 20,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ));
    return AppBar(
      backgroundColor: AppColor.brand.secondary,
      centerTitle: true,
      automaticallyImplyLeading: false,
      toolbarHeight: deviceHeight / 5,
      leadingWidth: deviceWidth / 9,
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(150),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              spreadRadius: 1.0,
              blurRadius: 1.0,
              offset: Offset(3, 5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(150),
          child: Image.asset(
            'assets/images/logo.png',
            height: deviceHeight / 6.5,
          ),
        ),
      ),
      actions: [
        Padding(padding: EdgeInsets.only(left: deviceWidth / 90)),
        IconButton(
            style: buttonStyle,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Stack(children: [
                    Align(
                        alignment: const Alignment(0.9, 1),
                        child: Image.asset(
                          'images/evi_cam.png',
                          width: 325,
                          height: 325,
                        )),
                    Center(
                        child: Image.asset(
                      'images/hukidashi_big.png',
                      width: 900,
                      height: 700,
                      fit: BoxFit.contain,
                    )),
                    Align(
                      alignment: const Alignment(0.3, 100),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            '説明',
                            style: TextStyle(fontSize: 40),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('images/shoukai.png'),
                              const Column(
                                children: [
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Text('問題が全部で5問\n出題されるでんす。',
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    'わかったら\n回答を入力するでんす。',
                                    style: TextStyle(fontSize: 30),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('入力が終わったら\n回答ボタンを押すでんす。',
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.left),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Text('全問正解できるように\n頑張るでんす。',
                                      style: TextStyle(fontSize: 30),
                                      textAlign: TextAlign.left),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment(0.45, -0.83),
                      child: IconButton(
                          style: buttonStyle2,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.clear)),
                    ),
                  ]);
                },
              );
            },
            icon: const Icon(Icons.help_outline_rounded)),
        Padding(padding: EdgeInsets.all(deviceWidth / 150)),
      ],
    );
  }
}
