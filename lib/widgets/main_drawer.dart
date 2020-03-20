import 'package:flutter/material.dart';
import '../navigator/route_name.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildDrawerItem(
      BuildContext context, String label, IconData icon, Function onTap) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Icon(
            icon,
            size: 26,
          ),
          title: Text(
            label,
            style: TextStyle(
              fontFamily: 'RobotoCondensed',
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              width: 100,
              height: 100,
              margin: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    'https://pbs.twimg.com/profile_images/952545910990495744/b59hSXUd_400x400.jpg',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Dawid Urbaniak',
                      style: Theme.of(context).textTheme.title),
                  Text('@trensik', style: Theme.of(context).textTheme.caption),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _buildDrawerItem(
              context,
              'Meals',
              Icons.restaurant,
              () {
                Navigator.of(context).pushReplacementNamed(RouteName.bottomBar);
              },
            ),
            _buildDrawerItem(
              context,
              'Filters',
              Icons.settings,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteName.filtersPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
