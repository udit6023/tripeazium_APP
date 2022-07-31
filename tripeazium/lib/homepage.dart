import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HOMEPAGE extends StatefulWidget {
  const HOMEPAGE({Key? key}) : super(key: key);

  @override
  State<HOMEPAGE> createState() => _HOMEPAGEState();
}

class _HOMEPAGEState extends State<HOMEPAGE> {
   TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;

  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CupertinoColors.systemBlue,
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone number"),
              keyboardType: TextInputType.phone,
            ),

            Visibility(child: TextField(
              controller: otpController,
              decoration: InputDecoration(),
              keyboardType: TextInputType.number,
            ),visible: otpVisibility,),

            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  if(otpVisibility){
                    verifyOTP();
                  }
                  else {
                    loginWithPhone();
                  }
                },
                child: Text(otpVisibility ? "Verify" : "Login")),
          ],
        ),
      ),
    );
  }

   void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+91"+phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value){
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {

      },
    );
  }

  void verifyOTP() async {

    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then((value){
      print("You are logged in successfully"); 
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }
}