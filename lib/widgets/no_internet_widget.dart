import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: 20,
      ),
      decoration: const BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: const ListTile(
        leading:  Icon(
          Icons.wifi_off_rounded,
          color: Colors.white,
        ),
        title:  Text(
          'No Internet Connection',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle:  Text(
          'Please check your internet connection.',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
