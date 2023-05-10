import 'package:flutter/material.dart';

class DishListTileWidget extends StatelessWidget {
  const DishListTileWidget({
    super.key,
    required this.cardIcon,
    required this.cardTitle,
    required this.cardSubtitle,
  });

  final IconData cardIcon;
  final String cardTitle;
  final String cardSubtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      leading: Container(
        padding: const EdgeInsets.only(right: 12.0),
        decoration: const BoxDecoration(
          border: Border(
            right: BorderSide(
              width: 1.0,
              // color: Colors.white24,
            ),
          ),
        ),
        child: const Icon(
          Icons.wine_bar,
          // color: Colors.white,
        ),
      ),
      title: Text(
        cardTitle,
        style: const TextStyle(
          // color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Row(
        children: <Widget>[
          Icon(
            Icons.bakery_dining,
            // color: Colors.yellowAccent,
          ),
          Text(
            " $cardSubtitle",
            // style: TextStyle(color: Colors.white),
          )
        ],
      ),
      trailing: const Icon(
        Icons.keyboard_arrow_right,
        // color: Colors.white,
        size: 30.0,
      ),
    );
  }
}
