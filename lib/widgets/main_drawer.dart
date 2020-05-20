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
              'Home',
              Icons.home,
              () {
                Navigator.of(context).pushReplacementNamed(RouteName.homePage);
              },
            ),
            _buildDrawerItem(
              context,
              'Manage',
              Icons.work,
              () {
                Navigator.of(context)
                    .pushReplacementNamed(RouteName.manageProducts);
              },
            ),
            _buildDrawerItem(
              context,
              'Orders',
              Icons.shop,
              () {
                Navigator.of(context).pushNamed(RouteName.ordersPage);
              },
            ),
            _buildDrawerItem(
              context,
              'Products',
              Icons.settings_input_component,
              () {
                Navigator.of(context).pushNamed(RouteName.productsPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
