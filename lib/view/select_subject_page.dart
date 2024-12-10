import 'package:flutter/material.dart';

import 'package:ebidence/constant/app_color.dart';

class SelectSubjectPage extends StatefulWidget {
  const SelectSubjectPage({super.key});

  @override
  State<SelectSubjectPage> createState() => _SelectSubjectPageState();
}

class _SelectSubjectPageState extends State<SelectSubjectPage> {
  @override
  Widget build(BuildContext context) {
    final double deviceHeight = MediaQuery.of(context).size.height;
    final double deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
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
        leading: IconButton(
            style: IconButton.styleFrom(
                foregroundColor: AppColor.brand.secondary,
                backgroundColor: AppColor.brand.primary,
                iconSize: deviceWidth / 20,
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
            icon: const Icon(Icons.arrow_back_rounded)),
        actions: [
          IconButton(
              style: IconButton.styleFrom(
                  foregroundColor: AppColor.brand.secondary,
                  backgroundColor: AppColor.brand.primary,
                  iconSize: deviceWidth / 20,
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
              icon: const Icon(Icons.volume_up_rounded)),
          Padding(padding: EdgeInsets.only(left: deviceWidth / 90)),
          IconButton(
              style: IconButton.styleFrom(
                  foregroundColor: AppColor.brand.secondary,
                  backgroundColor: AppColor.brand.primary,
                  iconSize: deviceWidth / 20,
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
              icon: const Icon(Icons.help_outline_rounded)),
          Padding(padding: EdgeInsets.all(deviceWidth / 150)),
        ],
      ),
      backgroundColor: AppColor.brand.primary,
      body: Stack(
        children: [
          Container(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const AlertDialog();
                  },
                );
              },
              child: Image.asset(
                'assets/images/shrimp.png',
                width: deviceWidth / 5.5,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog();
                      },
                    );
                  },
                  child: const Text("英語", style: TextStyle(fontSize: 45)),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog();
                      },
                    );
                  },
                  child: const Text("漢字", style: TextStyle(fontSize: 45)),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    side: const BorderSide(
                      color: Colors.black,
                      width: 3,
                    ),
                    minimumSize: Size(deviceWidth / 2, deviceHeight / 6),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog();
                      },
                    );
                  },
                  child: const Text("ドイツ語", style: TextStyle(fontSize: 45)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
