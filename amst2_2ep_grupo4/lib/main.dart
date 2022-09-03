import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main(){
  runApp(const MaterialApp(
    home: Home(),
  ));

}

final GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email'
  ],
);

class Home extends StatefulWidget{

  const Home({Key? key}) : super(key : key);


  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin{

  GoogleSignInAccount? _currentUser;
  @override
  void initState(){
    _googleSignIn.onCurrentUserChanged.listen((account) {
      setState(() {
        _currentUser = account;
      });
    });
    _googleSignIn.signInSilently();
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = Tween(begin: 0.0, end: 1.0).animate(animationController);
    animationController.addListener(() {
      setState(() {

      });
    });
  }

  late AnimationController animationController;
  late Animation degOneTranslationAnimation;

  double getRadiansFromDegree(double degree){
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Google Sign In"),

      ),
      body: Container(
        alignment: Alignment.center,
        child: _buildWidget(),

    ),
    );
  }

  Widget _buildWidget(){

    GoogleSignInAccount? user = _currentUser;

    if(user != null){
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            ListTile(
              leading: GoogleUserCircleAvatar(identity: user),
              title: Text(user.displayName ?? ''),
              subtitle: Text(user.email),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Signed Succesfully, Welcome',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
           /* ElevatedButton(
                onPressed: signOut,
                child: const Text('Sign out')
            ),*/
            Container(
              height: 200,
                 child: _menucirculo(),
                 ),

          ],
        ),


      );

    }else{
      return Padding(
        padding: const EdgeInsets.all(12.0),

        child: Column(
          children: [
            const SizedBox(height: 20,),
            const Text(
              'You are not signed in',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10,),
            ElevatedButton(
                onPressed: signIn
                , child: const Text('Sign in')
            ),

          ],
        ),
      );


    }



  }

  Widget _menucirculo(){
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
                          onClick: signOut,
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



  void signOut(){
    _googleSignIn.disconnect();

  }

  Future<void> signIn() async{
    try{
      await _googleSignIn.signIn();
    }catch(e){
      print('Error signing in $e');
    }
  }

}

class CircularButton extends StatelessWidget{
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function() onClick;

  CircularButton({required this.color, required this.width, required this.height, required this.icon, required this.onClick});

  @override
  Widget build(BuildContext context){
    //Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}