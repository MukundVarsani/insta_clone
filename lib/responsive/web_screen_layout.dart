import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:instagram_clone/utils/global_varibal.dart';

import '../utils/colors.dart';

class WebScreenLayout extends StatefulWidget{
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
  int _page = 0;

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void navigationTapped(int page) {
    if (pageController.hasClients){
    pageController.jumpToPage(page);

    }

    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page){
    setState(() {
      _page = page;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: SvgPicture.asset(
          'assets/images/instagram.svg',
          color: primaryColor,
          height: 32,
        ),
        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => navigationTapped(0),
                icon:  Icon(Icons.home,
                color: _page==0 ? primaryColor : secondaryColor,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => navigationTapped(1),
                icon:  Icon(Icons.search,
                  color: _page==1 ? primaryColor : secondaryColor,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => navigationTapped(2),
                icon:  Icon(Icons.add_circle,
                  color: _page==2 ? primaryColor : secondaryColor,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => navigationTapped(3),
                icon:  Icon(Icons.favorite,
                  color: _page==3 ? primaryColor : secondaryColor,)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () => navigationTapped(4),
                icon:  Icon(Icons.person,
                  color: _page==4 ? primaryColor : secondaryColor,)),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        children: homeScreenItem,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      )
    );
  }
}