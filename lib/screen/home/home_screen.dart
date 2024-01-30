import 'package:bloodunity/components/drawer.dart';
import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_add_request.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_search_screen.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_user_menu_screen..dart';
import 'package:bloodunity/screen/home/main_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool isSearching = false;

  final List<String> textFieldSuggestions = [
    'Apple',
    'banana',
    'mango',
    'orange',
  ];

  int? myIndex = 0;
  String appBarTitle = 'Blood Unity'; // Default title

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(_onSearchFocusChange);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }

  void _onSearchFocusChange() {
    setState(() {
      isSearching = searchFocusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Components.drawerComponent(context),
      appBar: AppBar(
        title: isSearching
            ? _buildSearchField()
            : Text(appBarTitle, style: AppUtils.textBold()),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isSearching = true;
              });
              FocusScope.of(context).requestFocus(searchFocusNode);
            },
            icon: const Icon(Icons.search),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(7.0),
          child: SizedBox(),
        ),
      ),
      body: IndexedStack(
        index: myIndex ?? 0,
        children: const [
          Center(child: MainScreen()), //Display Carousel Slider
          Center(child: BloodSearchScreen()), //search screen
          Center(child: BloodAddRequestScreen()), //bloodRequest

          Center(child: BloodUserMenuScreen()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        selectedItemColor: Colors.white,
        onTap: (index) {
          setState(() {
            myIndex = index;
            appBarTitle = _getAppBarTitle(index);
          });
        },
        currentIndex: myIndex!,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Request',
            backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Menu',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  String _getAppBarTitle(int index) {
    switch (index) {
      case 0:
        return 'Blood Unity';
      case 1:
        return 'Search';
      case 2:
        return 'Add Request';
      case 3:
        return 'User Menu';
      default:
        return 'BLOOD UNITY';
    }
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      focusNode: searchFocusNode,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isSearching = false;
            });
          },
          icon: const Icon(Icons.close),
        ),
      ),
      onChanged: (v) {},
    );
  }
}
