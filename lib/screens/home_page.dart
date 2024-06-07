import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stylish_flutter/models/products_model.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/screens/all_products.dart';
import 'package:stylish_flutter/screens/cart_screen.dart';
import 'package:stylish_flutter/screens/favorites_screen.dart';
import 'package:stylish_flutter/services/auth_services/logout_services.dart';
import 'package:stylish_flutter/widgets/category_widget.dart';
import 'package:stylish_flutter/widgets/deal_of_the_day.dart';
import 'package:stylish_flutter/widgets/products_card.dart';

// ignore: must_be_immutable
class HomePage extends StatefulWidget {
  final UserModel? userModel;
  final User? firebaseUser;
  ValueChanged<bool> onThemeChanged;
  bool isDarkMode;
  HomePage({
    Key? key,
    required this.userModel,
    required this.firebaseUser,
    required this.onThemeChanged,
    this.isDarkMode = false,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LogoutServices logout = LogoutServices();
  ProductsModel? productsModel;
  int _selectedIndex = 0;
  late PageController _pageController;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _buildHomeContent;
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 238, 237, 237),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  image: DecorationImage(
                      image:
                          AssetImage('assets/images/getstarted-background.png'),
                      fit: BoxFit.cover)),
              child: Text(
                'Stylish',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            Column(
              children: [
                Card(
                  elevation: 6,
                  shadowColor: Color(0xffF83758),
                  shape: Border.all(),
                  child: ListTile(
                    leading: const Icon(Icons.person_2_rounded),
                    title: Text(widget.userModel?.fullname ?? "Guest"),
                    iconColor: Color(0xffF83758),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.work_history_rounded),
                  title: const Text('Order History'),
                  onTap: () {},
                ),
                ListTile(
                  leading: const Icon(Icons.sunny),
                  title: const Text('DarkMode'),
                  onTap: () {
                    // Navigate to Settings
                  },
                  trailing: Switch(
                      value: widget.isDarkMode,
                      onChanged: (value) {
                        setState(() {
                          widget.isDarkMode = value;
                          widget.onThemeChanged(widget.isDarkMode);
                        });
                      }),
                ),
                ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Logout'),
                  onTap: () {
                    logout.logout(context);
                  },
                )
              ],
            )
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Image.asset(
          "assets/images/splash-logo.png",
          scale: 2,
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: CircleAvatar(
              backgroundColor: Color(0xffF83758),
              child: Icon(Icons.person),
            ),
          )
        ],
      ),
      body: SafeArea(
          child: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          _buildHomeContent(),
          AllProducts(),
          FavoritesScreen(),
          CartScreen(),
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xffF83758),
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

class _buildHomeContent extends StatelessWidget {
  const _buildHomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),

            //TextField
            TextField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(20),
                  fillColor: Colors.white,
                  // filled: true,
                  prefixIcon: Icon(Icons.search_rounded),
                  suffixIcon: Icon(Icons.subdirectory_arrow_right),
                  hintText: "Search any Product...",
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "All Featured",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),

            CategoryWdiget(),

            SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Group 33731.png'))),
            ),
            SizedBox(
              height: 20,
            ),
            DealOfTheDay(),
            SizedBox(
              height: 20,
            ),
            ProductsWidget(),
          ],
        ),
      ),
    );
  }
}
