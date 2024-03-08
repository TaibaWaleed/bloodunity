import 'package:bloodunity/components/drawer_components.dart';
import 'package:bloodunity/contants/contants.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_add_request.dart';
import 'package:bloodunity/screen/blood_user_screen/blood_user_menu_screen..dart';
import 'package:bloodunity/screen/home/main_screen.dart';
import 'package:bloodunity/screen/profile/blood_group_tips/blood_group_tips.dart';
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
  List<String> searchResults = [];

  ///textfieldresult
  final List<String> textFieldSuggestions = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
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
      appBar: AppBar(
        title: isSearching
            ? _buildSearchField()
            : Text(appBarTitle, style: AppUtils.textBold()),
        actions: [
          IconButton(
            onPressed: () {
              navigateTo(context, BloodTipScreen());
            },
            icon: Center(child: const Icon(Icons.tips_and_updates, size: 25)),
          ),
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
      drawer: drawerComponent(context),
      body: isSearching ? _buildSearchResults() : _buildIndexedStack(),
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
          ///home
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red,
          ),

          ///add Request
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Add Request',
            backgroundColor: Colors.red,
          ),

          ///User Menu
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User Menu',
            backgroundColor: Colors.red,
          ),
        ],
      ),
    );
  }

  ///apptitle
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

  Widget _buildIndexedStack() {
    return IndexedStack(
      index: myIndex ?? 0,
      children: const [
        Center(
            child: MainScreen(
          searchQuery: '',
        )), // Display Carousel Slider
        Center(child: BloodAddRequestScreen()), // Blood Request
        Center(child: BloodUserMenuScreen()),
      ],
    );
  }

  /// search feild
  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      focusNode: searchFocusNode,
      decoration: InputDecoration(
        hintText: 'Search...',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
        filled: true,
        fillColor: Colors.white,
        focusColor: Colors.white,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isSearching = false;
              searchController.clear();
              searchResults.clear();
            });
          },
          icon: const Icon(Icons.close),
        ),
      ),
      onChanged: _performSearch,
    );
  }

  ///search request
  Widget _buildSearchResults() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            'Search Results',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return ListTile(
                title:
                    Text(searchResults.isNotEmpty ? searchResults[index] : ''),

                // Customize the appearance of search results
              );
            },
          ),
        ),
      ],
    );
  }

  void _performSearch(String query) {
    setState(() {
      searchResults = textFieldSuggestions
          .where(
              (element) => element.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
