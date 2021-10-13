import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xcoin/screens/xcoin_announcement_page.dart';
import 'package:xcoin/screens/xcoin_home_page.dart';
import 'package:xcoin/screens/xcoin_miner_page.dart';
import 'package:xcoin/screens/xcoin_wallet_page.dart';
import 'package:xcoin/services/theme_provider.dart';
import 'package:xcoin/widgets/xcoin_drawer.dart';

class XCoinHomePage extends StatefulWidget {
  const XCoinHomePage({Key? key}) : super(key: key);

  @override
  _XCoinHomePageState createState() => _XCoinHomePageState();
}

class _XCoinHomePageState extends State<XCoinHomePage> {
  int selectedIndex = 1;

  final _currentPage = [
    const MinerPage(),
    const HomePage(),
    const WalletPage(),
    const AnnouncementPage(),
  ];

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;

    final _theme = Provider.of<ThemeProvider>(context);
    final isXCoinDark = (_theme.getTheme() == ThemeData.dark());

    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
            centerTitle: true,
            backgroundColor:
                isXCoinDark ? const Color(0xFF10112e) : Colors.blueAccent,
            toolbarHeight: 70,
            leadingWidth: 80,
            elevation: 0.0,
            leading: GestureDetector(
              child: const Icon(Icons.menu, size: 30),
              onTap: () => scaffoldKey.currentState?.openDrawer(),
            ),
            title: SizedBox(
              width: _width * 0.301,
              child: Row(
                children: <Widget>[
                  const Text('1244',
                      style: TextStyle(
                        fontSize: 30,
                      )),
                  Column(
                    children: const <Widget>[
                      Text('.4857', style: TextStyle(fontSize: 19)),
                    ],
                  ),
                ],
              ),
            )),
        drawer: const XCoinDrawer(),
        body: _currentPage[selectedIndex],

        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.black87,
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.construction_outlined), label: 'Miners'),
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'My Mine'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_outlined), label: 'Wallet'),
            BottomNavigationBarItem(
                icon: Icon(Icons.announcement_outlined), label: 'Announcements')
          ],
        ),

        // bottomNavigationBar: Padding(
        //   padding: const EdgeInsets.fromLTRB(5, 0, 5, 5),
        //   child: DecoratedBox(
        //     decoration: BoxDecoration(
        //       color: isXCoinDark
        //           ? const Color(0xFF213694)
        //           : Colors.blueAccent.withOpacity(0.2),
        //       borderRadius: BorderRadius.circular(50),
        //     ),
        //     child: Container(
        //       child: Padding(
        //         padding: const EdgeInsets.fromLTRB(20, 20, 10, 20),
        //         child: GNav(
        //             selectedIndex: selectedIndex,
        //             onTabChange: (index) {
        //               setState(() {
        //                 selectedIndex = index;
        //               });
        //             },
        //             tabBorderRadius: 30,
        //             tabShadow: [
        //               BoxShadow(
        //                   color: isXCoinDark
        //                       ? const Color(0xFF4965e3)
        //                       : Colors.blue.withOpacity(0.3),
        //                   blurRadius: 6)
        //             ],
        //             curve: Curves.easeOutExpo,
        //             duration: const Duration(milliseconds: 10),
        //             gap: 10,
        //             activeColor: isXCoinDark ? Colors.white : Colors.black,
        //             iconSize: 30,
        //             tabBackgroundColor: Colors.blueAccent.withOpacity(0.8),
        //             padding:
        //                 const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
        //             tabs: const [
        //               GButton(
        //                 icon: Icons.construction_outlined,
        //                 text: 'Mine',
        //               ),
        //               GButton(
        //                 icon: Icons.home_outlined,
        //                 text: 'Home',
        //               ),
        //               GButton(
        //                 icon: Icons.account_balance_outlined,
        //                 text: 'Wallet',
        //               ),
        //             ]),
        //       ),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
