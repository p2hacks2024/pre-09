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
        IconButton(
            style: buttonStyle,
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
            style: buttonStyle,
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
    );
  }
}
