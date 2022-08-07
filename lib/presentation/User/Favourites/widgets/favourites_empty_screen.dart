import 'package:flutter/material.dart';

class EmptyFavouritesScreen extends StatelessWidget {
  const EmptyFavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            const Text(
              'Избраное',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                  color: Colors.black),
            ),
            const SizedBox(height: 134),
            Center(
              child: Column(
                children: [
                  const Text(
                    'Ничего нет',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 30),
                  Image.asset('assets/no_favourite.png'),
                  const SizedBox(height: 30),
                  const Text(
                    'Вы не добавили ни одного юриста в избранное',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
