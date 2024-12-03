import 'package:flutter/material.dart';
import 'package:news_app/core/utils/route/app_routes.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: DrawerHeader(
              decoration: const BoxDecoration(
                color: AppColors.primary,
              ),
              child: Text(
                'News App',
                style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.favorite_rounded),
            title: Text(
              'Favorites',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.favorites);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(
              'Profile',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            onTap: () {},
          ),
          const Divider(),
        ],
      ),
    );
  }
}
