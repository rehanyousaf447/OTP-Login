import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:otplogin/Screens/otpScreen.dart';
import 'package:otplogin/components/Rounded_Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:otplogin/components/myContainer.dart';
class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.verifyPhoneNumber(
      phoneNumber: this.countryCode + phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();
        UserCredential result = await _auth.signInWithCredential(credential);
        User user = result.user;
        if (user != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      OtpScreen(phoneNumber:this.phoneNumber, countryCode:this.countryCode)));
          print(user.phoneNumber);
        } else {
          print("Error");
        }
        //This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (FirebaseAuthException exception) {
        print("ERROR");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(".CAN BE TOO MANY REQUEST TRY LATER\n.UN-REGISTERED NUMBER"),
              //content: Text(exception.toString()),
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
        print(exception);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OtpScreen(
                    phoneNumber: this.phoneNumber,
                    countryCode: this.countryCode,
                    verificationId: verificationId)));
      },
      codeAutoRetrievalTimeout: (value) {},
    );
  }

  String phoneNumber = '0';
  String countryCode = '+39';
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
              children: [
                Mycontainer(
                  alignmentGeometry:Alignment.bottomLeft,
                  edgeInsetsGeometry:EdgeInsets.all(10.0) ,
                  title: "Enter Phone Number",
                  size: 30,
                  textcolor: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CountryCodePicker(
                        onChanged: (countryCode) {
                          print("New Country selected: " +
                              countryCode.toString());
                          setState(() {
                            this.countryCode = countryCode.toString();
                          });
                        },
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        initialSelection: 'IT',
                        favorite: ['+39', 'FR'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        showOnlyCountryWhenClosed: true,
                        // optional. aligns the flag and the Text left
                        alignLeft: false,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: RoundedButton(
                          fontsize: 12,
                          title: countryCode,
                          onPress: () {},
                          color: Colors.grey,
                          textColor: Colors.grey[400],
                          imgUrl: null,
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) {
                            //Do something with the user input.
                            this.phoneNumber = value;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey,
                            hintText: 'Phone Number',
                            hintStyle: TextStyle(
                                color: Colors.grey[400], fontSize: 15.0),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 5.0,
                              horizontal: 20.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Mycontainer(
                  title: "We'll send you a code by SMS to confirm your phone number",
                  size: 10,
                  textcolor: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 30, 40, 5),
                  child: RoundedButton(
                    title: "Next",
                    onPress: () {
                      loginUser(this.phoneNumber, context);
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
                      title:  "Sign in With ",
                      size: 10,
                      textcolor: Colors.white,
                    ),
                    Mycontainer(
                      alignmentGeometry: Alignment.bottomLeft,
                      title:"e-mail & password",
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
