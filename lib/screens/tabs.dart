import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

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
  Map<Filter, bool> _filters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false
  };
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {
            ScaffoldMessenger.of(context).clearSnackBars();
          },
        ),
      ),
    );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isFavorite = _favoriteMeals.contains(meal);

    if (isFavorite) {
      _favoriteMeals.remove(meal);
      _showInfoMessage('Meal is no longer a favorite');
    } else {
      _favoriteMeals.add(meal);
      _showInfoMessage('Mark as favorite');
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    if (identifier == 'filters') {
      Navigator.of(context).pop();

      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _filters,
          ),
        ),
      );
      setState(() {
        _filters = result ?? {};
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget selectedPage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      filters: _filters,
    );
    String selectedPageTitle = 'Your Categories';
    final availableMeals = dummyMeals.where(
      (element) {
        if (_filters[Filter.glutenFree]! && !element.isGlutenFree) {
          return false;
        }
        if (_filters[Filter.lactoseFree]! && !element.isLactoseFree) {
          return false;
        }
        return false;
      },
    ).toList();

    if (_selectedPageIndex == 1) {
      selectedPage = MealsScreen(
        meals: _favoriteMeals,
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      selectedPageTitle = 'Your Favorite';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPageTitle),
      ),
      drawer: MainDrawer(
        onSelectString: _setScreen,
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
