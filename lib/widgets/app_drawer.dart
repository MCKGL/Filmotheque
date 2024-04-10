import 'package:filmotheque/screens/collection_screen.dart';
import 'package:filmotheque/screens/home_screen.dart';
import 'package:filmotheque/screens/login_screen.dart';
import 'package:filmotheque/screens/search_screen.dart';
import 'package:filmotheque/screens/to_watch_screen.dart';
import 'package:filmotheque/screens/watched_screen.dart';
import 'package:filmotheque/services/auth_service.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(
              height: 100,
              child: DrawerHeader(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeScreen()));
              },
            ),
            ListTile(
              title: const Text('To Watch'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ToWatchScreen()));
              },
            ),
            ListTile(
              title: const Text('Watched'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const WatchedScreen()));
              },
            ),
            ListTile(
              title: const Text('Collection'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CollectionScreen()));
              },
            ),
            ListTile(
              title: const Text('Search'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchScreen()));
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () async {
                final authService = AuthService();
                final localContext = context;
                bool logoutSuccess = await authService.logout();
                if (logoutSuccess) {
                  if (localContext.mounted) {
                    Navigator.pushReplacement(
                      localContext,
                      MaterialPageRoute(
                          builder: (context) => const LoginScreen()),
                    );
                  }
                } else {
                  if (localContext.mounted) {
                    ScaffoldMessenger.of(localContext).showSnackBar(
                      const SnackBar(content: Text('Logout failed')),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
