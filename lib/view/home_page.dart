import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/products_model.dart';
import 'package:stylish_flutter/models/user_model.dart';
import 'package:stylish_flutter/services/auth_services/logout_services.dart';
import 'package:stylish_flutter/view/accounts_screen.dart.dart';
import 'package:stylish_flutter/view/all_products.dart';
import 'package:stylish_flutter/view/cart_screen.dart';
import 'package:stylish_flutter/view/favorites_screen.dart';
import 'package:stylish_flutter/view/searched_page.dart';
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
    super.key,
    required this.userModel,
    required this.firebaseUser,
    required this.onThemeChanged,
    this.isDarkMode = false,
  });

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
                  shadowColor: const Color(0xffF83758),
                  shape: Border.all(),
                  child: ListTile(
                    leading: const Icon(Icons.person_2_rounded),
                    title: Text(widget.userModel?.fullname ?? "Guest"),
                    iconColor: const Color(0xffF83758),
                  ),
                ),
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
          const _buildHomeContent(),
          const AllProducts(),
          const SearchedPage(),
          const FavoritesScreen(),
          const CartScreen(),
          AccountsScreen(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.onThemeChanged,
          )
        ],
      )),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        // backgroundColor: const Color.fromARGB(255, 238, 237, 237),
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
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xffF83758),
        // unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}

// ignore: camel_case_types
class _buildHomeContent extends StatelessWidget {
  const _buildHomeContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  "All Featured",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const CategoryWdiget(),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 220,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/Group 33731.png'))),
            ),
            const SizedBox(
              height: 20,
            ),
            const DealOfTheDay(),
            const SizedBox(
              height: 20,
            ),
            const ProductsWidget(),
          ],
        ),
      ),
    );
  }
}
