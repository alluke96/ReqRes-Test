import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 400,
      child: Stack(
        children: <Widget>[

          Positioned(
            top: -40,
            height: 400,
            width: width,
            child: FadeInDown(duration: const Duration(seconds: 1), 
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.png'),
                    fit: BoxFit.fill
                  )
                ),
              )
            ),
          ),

          Positioned(
            height: 400,
            width: width,
            child: FadeInDown(duration: const Duration(milliseconds: 1000), 
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background-2.png'),
                    fit: BoxFit.fill
                  )
                ),
              )
            ),
          )

        ],
      ),
    );
  }
}