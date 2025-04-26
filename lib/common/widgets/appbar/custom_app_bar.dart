import 'package:flutter/material.dart';
import 'package:utavine/common/helpers/is_dark_mode.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.arrow_back_ios_new,
          color: context.isDarkMode ? Colors.white : Colors.black,
          size: 25,),
        )
      ),
    );
  }
}