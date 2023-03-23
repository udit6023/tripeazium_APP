import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tripeazium/views/LoginScreen.dart';
import 'package:tripeazium/services/shared_prefrences.dart';
import 'package:url_launcher/url_launcher.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  final Uri _url = Uri.parse('https://tripeaziums-web.tripeaziumoffic.repl.co/#');

  Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw 'Could not launch $_url';
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemGrey6,
      child: Drawer(
        child: ListView(
        children: [
          SizedBox(height: 20,),
          Divider(thickness: 1,color: Colors.black,),
          ListTile(
            leading: Icon(Icons.design_services_rounded),
            title: Text('Services',style: TextStyle(fontSize: 18),),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('About',style: TextStyle(fontSize: 18),),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.contact_phone),
            title: Text('Contact Us',style: TextStyle(fontSize: 18)),
            onTap: () => null,
          ),
          Divider(thickness: 1,color: Colors.black,),
          ListTile(
            leading: Icon(Icons.wordpress_outlined),
            title: Text('Our Website',style: TextStyle(fontSize: 18)),
            onTap: () => {
              _launchUrl(),
            },
          ),
           ListTile(
            leading: Icon(Icons.exit_to_app_outlined),
            title: Text('Sign out',style: TextStyle(fontSize: 18)),
            onTap: () async => {
                await SharePreference.clearSharePrefrence(),
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HOMEPAGE()),
                      ),

            },
          ),
        ],
      ),
      ),
    );

  }
}