import 'package:flutter/material.dart';

class CategoriesWidget extends StatelessWidget {
  final String image;
  final String title;

  const CategoriesWidget({
    super.key,
    required this.image,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF7FAFE),
        borderRadius: BorderRadius.circular(10),
      ),
      width: MediaQuery.of(context).size.width / 4,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            // or Image.asset if it's a local asset
            image,
            height: 50,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.error),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
