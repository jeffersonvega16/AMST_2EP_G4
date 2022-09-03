import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget{

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin{

  late AnimationController animationController;
  late Animation degOneTranslationAnimation;

  double getRadiansFromDegree(double degree){
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    super.initState();
    animationController.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 30,
                bottom: 30,
                child: Stack(
              children: <Widget>[
                Transform.translate(
                offset: Offset.fromDirection(getRadiansFromDegree(270),degOneTranslationAnimation.value * 100),
                child: CircularButton(
                  color: Colors.blue,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  onClick: (){

                  },
                ),
                ),
        Transform.translate(
            offset: Offset.fromDirection(getRadiansFromDegree(225),degOneTranslationAnimation.value * 100),
                child: CircularButton(
                  color: Colors.black,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.output,
                    color: Colors.white,
                  ),
                  onClick: (){

                  },
                ),
        ),
                Transform.translate(
                  offset: Offset.fromDirection(getRadiansFromDegree(180),degOneTranslationAnimation.value * 100),

                child: CircularButton(
                  color: Colors.orange,
                  width: 50,
                  height: 50,
                  icon: Icon(
                    Icons.message,
                    color: Colors.white,
                  ),
                  onClick: (){

                  },
                ),
                ),
              CircularButton(
                color: Colors.red,
                width: 60,
                height: 60,
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onClick: (){
                  if(animationController.isCompleted){
                    animationController.reverse();
                  }else{
                    animationController.forward();
                  }
                },
              )]
            ))
          ],
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget{
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final void Function() onClick;

  CircularButton({required this.color, required this.width, required this.height, required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}