import 'package:flutter/material.dart';
import 'package:news_app/src/pages/tab1_page.dart';
import 'package:news_app/src/pages/tab2_page.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _NavigationModel(),
      child: Scaffold(
        body: _Pages(),
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    final newsService = Provider.of<NewsService>(context);


    return BottomNavigationBar(
      currentIndex: navigationModel._paginaActual,
      onTap: (value) => navigationModel.paginaActual = value,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'NOW'),
        BottomNavigationBarItem(icon: Icon(Icons.currency_bitcoin_sharp), label: 'For You'),
      ],
    );
  }
}

class _Pages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pageController = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: pageController.navigationController,
      //physics: BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      children: [
        
        Tab1Page(),

        Tab2Page(),
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _paginaActual = 0;

  PageController _navigationController = PageController();

  int get paginaActual => this._paginaActual;

  set paginaActual(int value) {
    this._paginaActual = value;

    _navigationController.animateToPage(value,
        duration: const Duration(milliseconds: 400), curve: Curves.decelerate);

    notifyListeners();
  }

  get navigationController => this._navigationController;
}
