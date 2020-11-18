import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:otplogin/components/Rounded_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otplogin/components/myContainer.dart';
class OtpScreen extends StatefulWidget {
  OtpScreen({this.phoneNumber, this.countryCode, this.verificationId});
  final String phoneNumber;
  final String countryCode;
  final String verificationId;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String endnumbers;
  FirebaseAuth _auth = FirebaseAuth.instance;
  List<TextEditingController> textEditingController = List(6);

  void puttingStars(String number) {
    endnumbers = number.substring(number.length - 3);
  }

  @override
  void initState() {
    super.initState();
    puttingStars(widget.phoneNumber);
    for (int i = 0; i < 6; i++) {
      textEditingController[i] = TextEditingController();
    }
  }
  void alert(String message){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          content: Text(message),
          actions: [
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OKAY"),
            )
          ],
        );
      },
    );
  }
  List<Widget> squareTextFields() {
    List<Widget> myWidgets=[];
    for(int i=0;i<6;i++){
      myWidgets.add( Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: TextField(
            controller: textEditingController[i],
            textAlign: TextAlign.center,
            keyboardType: TextInputType.phone,
            onChanged: (value) {
              //Do something with the user input.
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              filled: true,
              fillColor: Colors.grey,
              hintText: '-',
              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 15.0),
            ),
          ),
        ),
      ));
    }
    return myWidgets;
  }

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
            padding: const EdgeInsets.fromLTRB(20.0, 0, 20, 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.all(10.0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Verify Code",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30),
                  ),
                ),
                Flex(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  direction: Axis.horizontal,
                  children: squareTextFields(),
                ),
                Container(
                  child: Text(
                    "Submit Verification Code Sent on ${widget.countryCode}******$endnumbers",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 5),
                  child: RoundedButton(
                    title: "VERIFY",
                    onPress: () async {
                      String code = '';
                      for (int i = 0; i < 6; i++) {
                        print(textEditingController[i].text);
                        code = code + textEditingController[i].text.trim();
                      }
                      AuthCredential credential = PhoneAuthProvider.credential(
                          verificationId: widget.verificationId, smsCode: code);
                      UserCredential result;
                      User user;
                      try{
                        result = await _auth.signInWithCredential(credential);
                        user = result.user;
                      }catch(e){
                        print(e);
                      }

                      if (user != null) {
                       alert("OKAY");
                        print(user.phoneNumber);
                      } else {
                        print("WRONG OPT");
                        alert("WRONG OPT");
                      }
                    },
                    color: Colors.yellow[400],
                    textColor: Colors.black,
                    imgUrl: null,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Mycontainer(
                      alignmentGeometry: Alignment.bottomLeft,
                      title:"Didn't Receive Code",
                      size: 10,
                      textcolor: Colors.white,
                    ),
                    Mycontainer(
                      alignmentGeometry: Alignment.bottomLeft,
                      title: "Resend Code",
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
