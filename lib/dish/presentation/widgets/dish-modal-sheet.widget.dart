import 'package:flutter/material.dart';

import '../../../core/utils/asset.util.dart';

showMenu(context, dishName) {
  showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0),
                topRight: Radius.circular(16.0),
              ),
            ),
          ),
          Positioned(
            top: -45,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 50,
              child: AssetUtil.getImage('meal.png'),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Text(dishName),
              const SizedBox(
                height: 10.0,
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  // width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book_outlined),
                    label: const Text(
                      'View Recipe',
                      style: TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black87,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                  ),
                  child: ElevatedButton.icon(
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                    label: const Text(
                      'Delete',
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.red,
                      ),
                    ),
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        width: 1.0,
                        color: Colors.red,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ],
      );
    },
  );
}
