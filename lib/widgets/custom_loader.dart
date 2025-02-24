import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  static const id = 'CustomLoader';

  final Color? color;
  final double radius;
  final double padding;

  const CustomLoader({
    Key? key,
    this.color,
    this.radius = 15,
    this.padding = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
      decoration: const BoxDecoration(
      image: DecorationImage(
    image: AssetImage('assets/images/bg.png'),
    fit: BoxFit.fill,
    colorFilter: ColorFilter.mode(Colors.white70, BlendMode.lighten),
    )
    ),
    child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child:Image.asset('assets/images/logo.png',width: 200,height: 200,)
            ),
            SizedBox(
              height: radius * 2,
              width: radius * 2,
              child: CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(
                  color ?? Colors.black,
                ),
              ),
            ),

          ],
        ),
      ),
      ),
    );
  }
}
