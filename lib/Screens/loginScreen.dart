import 'package:flutter/material.dart';
import 'package:otplogin/Screens/RegistrationScreen.dart';
import 'package:otplogin/components/Rounded_Button.dart';
import 'package:otplogin/components/myContainer.dart';
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0,0,20,30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Mycontainer(
                  alignmentGeometry:Alignment.bottomLeft,
                  edgeInsetsGeometry:EdgeInsets.all(10.0) ,
                  title: "Let's Get Connected!",
                  size: 30,
                  textcolor: Colors.white,
                ),
                Mycontainer(
                  alignmentGeometry:Alignment.bottomLeft,
                  edgeInsetsGeometry:EdgeInsets.all(10.0) ,
                  title: "Continue With",
                  size: 15,
                  textcolor: Colors.white,
                ),
                RoundedButton(
                  title: "Phone Number",
                  color: Colors.red[300],
                  onPress: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context){
                      return RegistrationScreen();
                    }));
                  },
                  textColor: Colors.white,
                  imgUrl: 'images/icons8-iphone-x-100.png',
                ),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        title: "Google",
                        color: Colors.blue[800],
                        onPress: () {},
                        textColor: Colors.white,
                        imgUrl: 'images/google_logo.png',
                      ),
                    ),
                    Expanded(
                      child: RoundedButton(
                        title: "Facebook",
                        color: Colors.blue[800],
                        onPress: () {},
                        textColor: Colors.white,
                        imgUrl: 'images/facebook.png',
                      ),
                    ),
                  ],
                ),
                RoundedButton(
                  title: "Email",
                  color: Colors.grey,
                  onPress: () {},
                  textColor: Colors.white,
                  imgUrl: 'images/mail.png',
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mycontainer(
                      alignmentGeometry:Alignment.bottomLeft,
                      title: "Already Have account?",
                      size: 10,
                      textcolor: Colors.white,
                    ),
                    Mycontainer(
                      alignmentGeometry:Alignment.bottomLeft,
                      title: "Sign In",
                      size: 10,
                      textcolor: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
