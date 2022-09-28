import 'package:flutter/material.dart';

class Showsnackbar extends StatelessWidget {
  const Showsnackbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
  static showsnack(BuildContext context,String text){
   ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.cyan,
      content:
     Text(text),
     )
   );
  }
}