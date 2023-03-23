import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tripeazium/views/NavBar.dart';
import 'package:tripeazium/views/NavBar.dart';
import 'package:http/http.dart' as http;
import 'package:tripeazium/models/hotelsAPIModel.dart';
import 'package:tripeazium/views/widget_card.dart';
import 'package:location/location.dart';


class HOMESCREEN extends StatefulWidget {
  const HOMESCREEN({Key? key}) : super(key: key);

  @override
  State<HOMESCREEN> createState() => _HOMESCREENState();
}

class _HOMESCREENState extends State<HOMESCREEN> {

late List<HotelApiModel> _hotels;
bool _isLoading=true;

Future<List<HotelApiModel>> loadData()async{
   Map<String, String> _header = <String, String>{
      "X-RapidAPI-Key": "20a3f73b67mshb94e52c1915ec01p198a60jsn79cc3f4654ec", 
      "X-RapidAPI-Host": "hotels4.p.rapidapi.com",
      "useQueryString": "true"
  };
  final url = "https://hotels4.p.rapidapi.com/locations/v2/search?query=new delhi";
final response = await http.get(Uri.parse(url),headers: _header,);
final catalogJson = response.body;
Map data = jsonDecode(catalogJson)['suggestions'][1];

List _temp=[];

for(var i in data['entities']){
  _temp.add(i);
}

return HotelApiModel.apiFromSnapshot(_temp);
}

  @override
  initState(){
    // TODO: implement initState
    super.initState();
   // getHotels();
   
  }

  Future<void> getHotels() async {
    _hotels=await loadData();
    setState(() {
      _isLoading=false;
    });
    print(_hotels);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:NavBar(),
      appBar: AppBar(
        backgroundColor: CupertinoColors.systemGrey6,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 5,
        title:  Padding(
          padding:EdgeInsets.only(right: MediaQuery.of(context).size.width/175),
          child: IconButton(
          icon: Image.asset('assests/logo_trpeazium.png'),
          iconSize: 120,
          onPressed: (){},
      ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children:[
                
                Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color.fromARGB(180, 12, 82, 139), Color.fromARGB(255, 28, 211, 235)]),
                    borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                height: MediaQuery.of(context).size.height/4,
                width:  MediaQuery.of(context).size.width,
              ),
              Padding(
                padding:  EdgeInsets.only(top:MediaQuery.of(context).size.height/12,left:30,right:30),
                child: Card(
                  elevation: 5,
                  child: TextField(
                decoration: new InputDecoration(
                     prefixIcon: Icon(Icons.search),
                     hintText: "Search for lounges,cafes and many more",
                     enabledBorder: const OutlineInputBorder(
                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                     borderSide: const BorderSide(
                       color: Colors.transparent,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                   ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top:MediaQuery.of(context).size.height/5),
                child: Container(
                  child: Row(
                    children: [
                      
                      InkWell(
                        onTap: () => {
                          Fluttertoast.showToast(  
              msg: 'Not Supported Yet',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: InkWell(
                          onTap: () => {
                            getHotels(),
        // Fluttertoast.showToast(  
        //       msg: 'Not Supported',  
        //       toastLength: Toast.LENGTH_SHORT,  
        //       gravity: ToastGravity.BOTTOM,  
        //       timeInSecForIosWeb: 1,  
        //       backgroundColor: Colors.red,  
        //       textColor: Colors.yellow  
        //       )  
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top:10,bottom: 10,right:20),
                            child: Column(
                              children: [
                                Icon(Icons.hotel),
                                Text("Hotels",style: TextStyle(fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left:15,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.local_cafe_sharp),
                              Text("Cafes",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              ) 
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.restaurant_menu),
                              Text("Restaurants",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => {
        Fluttertoast.showToast(  
              msg: 'Not Supported',  
              toastLength: Toast.LENGTH_SHORT,  
              gravity: ToastGravity.BOTTOM,  
              timeInSecForIosWeb: 1,  
              backgroundColor: Colors.red,  
              textColor: Colors.yellow  
              )
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,top:10,bottom: 10),
                          child: Column(
                            children: [
                              Icon(Icons.person_pin_circle_outlined),
                              Text("Fun Activities",style: TextStyle(fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                      ),
                     
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: CupertinoColors.systemGrey6,
                     borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  ),
                  height: MediaQuery.of(context).size.height/8.5,
                  width: MediaQuery.of(context).size.width,
                  
                ),
              )
              ]
            ),
        
        
             _isLoading?Center(child: CircularProgressIndicator(),):Stack(
               children:[ ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                 scrollDirection: Axis.vertical,
                 shrinkWrap: true,
               
                      itemBuilder: (context, index) {
                        final item = _hotels[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              // selectedIndex = index;
                              // _selected[index] = !_selected[index];
                            });
                            // Navigator.push(
                            //     context,
                                // MaterialPageRoute(
                                //     builder: (context) =>
                                //         StaffServiceListScreen(
                                //             catalog: item.project_id.toString())));
                          
                          },
                          child: RecipeCard(title: item.name, cookTime: item.type, rating: "4.3", thumbnailUrl: 'https://digital.ihg.com/is/image/ihg/staybridge-suites-irvine-6723805112-4x3')
                        );
                      },
                      itemCount: _hotels.length,
                    ),
               ],
             ),
          ],
        ),
      ),
    );
  }
}