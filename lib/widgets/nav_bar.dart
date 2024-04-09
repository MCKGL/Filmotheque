import 'package:filmotheque/screens/login_screen.dart';
import 'package:filmotheque/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:filmotheque/screens/home_screen.dart';
import 'package:filmotheque/screens/to_watch_screen.dart';
import 'package:filmotheque/screens/watched_screen.dart';
import 'package:filmotheque/screens/search_screen.dart';
import 'package:filmotheque/screens/collection_screen.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int currentPageIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const ToWatchScreen(),
    const WatchedScreen(),
    const CollectionScreen(),
    const SearchScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmotheque'),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                setState(() {
                  currentPageIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('To Watch'),
              onTap: () {
                setState(() {
                  currentPageIndex = 1;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Watched'),
              onTap: () {
                setState(() {
                  currentPageIndex = 2;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Collection'),
              onTap: () {
                setState(() {
                  currentPageIndex = 3;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Search'),
              onTap: () {
                setState(() {
                  currentPageIndex = 4;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                AuthService().logout().then((success) {
                  if (success) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to logout')),
                    );
                  }
                });
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _widgetOptions.elementAt(currentPageIndex),
      ),
    );
  }
}
