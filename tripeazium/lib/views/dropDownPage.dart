import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tripeazium/views/home_screen.dart';
import 'package:tripeazium/views/map.dart';

class dropDown extends StatefulWidget {
  const dropDown({super.key});


  @override
  State<dropDown> createState() => _dropDownState();
}
class User {
  const User(this.clgName,this.latitude,this.longitude);

  final String clgName;
  final double latitude;
  final double longitude;
}
class _dropDownState extends State<dropDown> {
   late User selectedUser;
  List<User> users = <User>[ 
    User('Please Select Your College', 00.720198242008856, 00.14140550247147),
    User('Maharaja Surajmal Institute of Technology, Janakpuri', 28.620911611309268, 77.09324843130545),
    User('BPIT, Rohini, Sector-17', 28.73674982409112, 77.11295999133753),
    User('BVCOE, Paschim Vihar',28.67615176356619, 77.11384592496472),
    User('Gitarattan Institute of Advanced Studies, Rohini',28.71205328570887, 77.11951232017336),
    User('Keshav MahaVidyalya, PitamPura',28.687770182396093,77.12017259554796)

    ];
  var _chosenValue;
bool _isVisible=false;
  void showToast() {
      setState(() {
        _isVisible = !_isVisible;
      });
    }

     @override
  void initState() {
    selectedUser=users[0];
    print(selectedUser);
  }
  @override
  Widget build(BuildContext context) {
  double height=MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: CupertinoColors.systemGrey6,
      appBar: AppBar(
        backgroundColor:CupertinoColors.systemGrey2,
        title: Text('Tripeazium'),
        
      ),
      body: Column(
        children: [
          SizedBox(height: height/6,),
          Container(
            padding: EdgeInsets.all(25.0),
            child:Text("Please Select Your College From the DropDown Below",style: TextStyle(fontSize: 25,color: Colors.black),)
          ),
          SizedBox(height:height/7,),
          Center(
            child: Container(
              child:  new DropdownButton<User>(
                isExpanded: true,
                value: selectedUser,
                onChanged: (newValue) {
                  setState(() {
                    selectedUser = newValue!;
                    _isVisible=true;
                  });
                },
                items: users.map((User user) {
                  return new DropdownMenuItem<User>(
                    value: user,
                    child: new Text(
                      user.clgName,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(height: height/9,),
           Visibility(
            visible: _isVisible,
            child:TextButton(
              
                  onPressed: () {
                    Navigator.push<void>(
    context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => HomeScreen(latitude: selectedUser.latitude, longitude: selectedUser.longitude, name: selectedUser.clgName.toString(),),
    ),
  );
                  },
                  child: Container(
                    color: CupertinoColors.systemGrey,
                    padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(color: Colors.white, fontSize:17.0),
                    ),
                  ),
                ),
           )
        ],
      ),
    );
  }
}