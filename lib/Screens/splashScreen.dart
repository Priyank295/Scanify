import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffEBF9FF),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    child: SvgPicture.asset("assets/splash_curve.svg"))),
            Container(
                margin: EdgeInsets.only(top: 50),
                padding: EdgeInsets.all(20),
                child: SvgPicture.asset("assets/bike.svg")),
            Container(
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome 👋",
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(0, 178, 255, 0.6),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          "Lorem Ipsum has been the industry's standard dummy text ever",
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
