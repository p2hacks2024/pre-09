import 'package:ebidence/viewmodel/ebidence_appbar.dart';

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(deviceHeight / 5),
          child: const EbidenceAppbar()),
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
