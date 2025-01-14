import 'package:flutter/cupertino.dart';
import 'package:instagram_clone/provider/user_provider.dart';
import 'package:provider/provider.dart';

import '../utils/global_varibal.dart';

class ResponsiveLayout extends StatefulWidget{

  final Widget  webScreenLayout;
  final Widget  mobileScreenLayout;

   const ResponsiveLayout({super.key ,
     required this.webScreenLayout ,
     required this.mobileScreenLayout});

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {

  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async{
    UserProvider userProvider  = Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }
   @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context , constraints){
          if(constraints.minWidth > webScreenSize){
            return widget.webScreenLayout;
          }
          return widget.mobileScreenLayout;
        }
    );
  }
}