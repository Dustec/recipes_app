import 'package:flutter/material.dart';
import 'package:recipes_app/core/domain/facades/http_facade.dart';
import 'package:recipes_app/core/presentation/ui/app_colors.dart';
import 'package:recipes_app/di/injector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HttpFacade httpFacade = injector.get();

  @override
  void initState() {
    super.initState();
    httpFacade.get('https://www.themealdb.com/api/json/v1/1/search.php?f=b');
    // httpFacade.get(
    // 'https://www.themealdb.com/api/json/v1/1/lookup.php?i=52772',
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Center(child: Text('Home Page')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          httpFacade.get(
            'https://www.themealdb.com/api/json/v1/1/search.php?f=b',
          );
        },
      ),
    );
  }
}
