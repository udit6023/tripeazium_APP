import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tripeazium/CONFIG.dart/CONFIG.dart';
import 'package:tripeazium/views/HomeScreen.dart';
import 'package:tripeazium/services/shared_prefrences.dart';

class HOMEPAGE extends StatefulWidget {
  const HOMEPAGE({Key? key}) : super(key: key);

  @override
  State<HOMEPAGE> createState() => _HOMEPAGEState();
}

class _HOMEPAGEState extends State<HOMEPAGE> {
  final _formKey = GlobalKey<FormState>();
   final _formKey1 = GlobalKey<FormState>();
   String currentText = "";
   TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;
  bool phnVisibilty = true;
  bool textVisibility = true;
  bool text1Visibility=false;

  String verificationID = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(114, 111, 174, 165),
                Color.fromARGB(167, 70, 113, 177),
              ],
            )
          ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 5,
              color: CupertinoColors.systemGrey6,
               shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              child: Container(
                height: MediaQuery.of(context).size.height/2.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  "Verification",
                                  style: TextStyle(
                                      color: CupertinoColors.black,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                      SizedBox(height: 20.0,),
                      Visibility(
                        visible:textVisibility,
                        child: Container(
                                  alignment: Alignment.centerRight,
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: Text(
                                    "Please enter your mobile number to get OTP",
                                    style: TextStyle(
                                        color: CupertinoColors.systemGrey,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50),
                                  ),
                                ),
                      ),
                      Visibility(
                        visible:text1Visibility,
                        child: Container(
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width/1.5,
                                  child: Text(
                                    "Please enter your OTP",
                                    style: TextStyle(
                                        color: CupertinoColors.systemGrey,
                                        fontSize:
                                            MediaQuery.of(context).size.height /
                                                50),
                                  ),
                                ),
                      ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height / 30,
                              ),
                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 25, right: 25),
                                      child: Visibility(
                                        visible: phnVisibilty,
                                        child: Form(
                                          key: _formKey,
                                          child: TextFormField(
                                            validator: (value) {
                                              if (value!.length != 10 || value.isEmpty) {
                                                return 'Enter 10-digit phone number ';
                                              }
                                              return null;
                                            },
                                            autofocus: false,
                                            controller: phoneController,
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: CupertinoColors.systemGrey6,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(30)),
                                                hintText: 'Enter phone number',
                                                contentPadding: EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 10),
                                                prefix: Padding(
                                                  padding: EdgeInsets.all(4),
                                                  child: Text("+91"),
                                                )),
                                            maxLength: 10,
                                            keyboardType: TextInputType.phone,
                                          ),
                                        ),
                                      ),
                                    ),
                  
                    Visibility(
                      child: Form(
                                key: _formKey1,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 30),
                                    child: PinCodeTextField(
                                      appContext: context,
                                      pastedTextStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      length: 6,
                                      pinTheme: PinTheme(
                                          shape: PinCodeFieldShape.box,
                                          borderRadius: BorderRadius.circular(5),
                                          fieldHeight: 50,
                                          fieldWidth: 40,
                                          activeFillColor: Colors.white,
                                          disabledColor: Colors.white,
                                          selectedColor:
                                              CupertinoColors.systemGrey4,
                                          activeColor:
                                              CupertinoColors.systemGrey4,
                                          inactiveColor:
                                              CupertinoColors.systemGrey4,
                                          errorBorderColor: Colors.black,
                                          inactiveFillColor:
                                              CupertinoColors.white,
                                          selectedFillColor: Colors.white),
                                      cursorColor: CupertinoColors.black,
                                      enableActiveFill: true,
                                      controller: otpController,
                                      keyboardType: TextInputType.number,
                                      boxShadows: const [],
                                      onChanged: (value) {
                                        setState(() {
                                          currentText = value;
                                        });
                                      },
                                    )),
                              ),
                    //   child: TextField(
                    //   controller: otpController,
                    //   decoration: InputDecoration(),
                    //   keyboardType: TextInputType.number,
                    // )
                    visible: otpVisibility,),
                  
                    SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(18.0),
                                              side:
                                                  BorderSide(color: Colors.black))),
                                      backgroundColor: MaterialStateProperty.all(
                                          CupertinoColors.black)),
                                  onPressed: (() async {
                                    setState(() {
                                      
                                    });
                                          // setState(() {
                                          //   loginWithPhone();
                                          //   phnVisibilty=false;
                                            
                                          //   otpVisibility=false;
                                          // });
                                       if(otpVisibility){
                                        
                                            verifyOTP();
                                          }
                                          else{
                                             
                                            loginWithPhone();
                                            
                                          }
                                          
                                    
                                  }),
                                  child: Text(otpVisibility ? "Verify" : "Login",style:TextStyle(fontSize: 20),),)
                  ],
                ),
              ),
            ),
          ),
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
        phnVisibilty=false;
        textVisibility=false;
        text1Visibility=true;
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

    await auth.signInWithCredential(credential).then((value) async{
      print("You are logged in successfully"); 
      await SharePreference.setBooleanValue(CONFIG.IS_LOGIN,true);
      await SharePreference.setStringValue(CONFIG.USER_PHONENUMBER, phoneController.text.toString());
      await SharePreference.setStringValue(CONFIG.USER_TYPE, phoneController.text.toString());
      print("LoginScreen: "+await SharePreference.getStringValue(CONFIG.USER_TYPE)); 
       Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => HOMESCREEN()),
  );
      Fluttertoast.showToast(
          msg: "You are logged in successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0
      );
        
    });
  }
}