import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({
    super.key,
  });

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  //_ this variables in in
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedPage = const CategoriesScreen();
    String selectedPageTitle = 'Your Categories';

    if (_selectedPageIndex == 1) {
      selectedPage = const MealsScreen(
        meals: [],
      );
      selectedPageTitle = 'Your Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      body: selectedPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          )
        ],
      ),
    );
  }
}
