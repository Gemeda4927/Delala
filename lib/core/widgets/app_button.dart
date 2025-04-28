import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key, required this.title,  this.onClick,
  });
  final String title;
  final void Function()? onClick;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
     
      
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(title, style: TextStyle(color: Colors.white)),
    );
  }
}
