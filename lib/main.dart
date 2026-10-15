import 'dart:math';
import 'package:flutter/material.dart';
import 'fool_detail_page.dart';

void main() => runApp(const JapaneseTarotApp());

const ink = Color(0xFF100D14);
const gold = Color(0xFFE6C587);
const crimson = Color(0xFF8C2537);

class JapaneseTarotApp extends StatelessWidget {
  const JapaneseTarotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Японское Таро',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: ink,
        colorScheme: ColorScheme.fromSeed(
          seedColor: crimson,
          brightness: Brightness.dark,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: ink,
          foregroundColor: gold,
          centerTitle: true,
        ),
      ),
      home: const TarotHomePage(),
    );
  }
}

class TarotHomePage extends StatelessWidget {
  const TarotHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Японское Таро')),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.nights_stay, size: 76, color: gold),
                  const SizedBox(height: 24),
                  const Text(
                    'Путь 78 арканов',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, color: gold),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Авторская колода в японском стиле',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 44),
                  _menuButton(context, 'Карта дня', () => _showCards(context, 1)),
                  _menuButton(context, 'Расклад на три карты', () => _showCards(context, 3)),
                  _menuButton(context, 'Моя колода', () {
                    Navigator.push(context, MaterialPageRoute<void>(
                      builder: (_) => const GalleryPage(),
                    ));
                  }),
                  const SizedBox(height: 22),
                  const Text(
                    'Демонстрационный прототип: изображения и значения будут добавлены позже.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.white54),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _menuButton(BuildContext context, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: SizedBox(
        width: double.infinity,
        child: FilledButton(
          onPressed: onTap,
          style: FilledButton.styleFrom(
            backgroundColor: crimson,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
          ),
          child: Text(label, style: const TextStyle(fontSize: 17)),
        ),
      ),
    );
  }

  void _showCards(BuildContext context, int count) {
    final random = Random.secure();
    final indices = List<int>.generate(78, (index) => index)..shuffle(random);
    final selected = indices.take(count).map((index) => index + 1).toList();
    Navigator.push(context, MaterialPageRoute<void>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(count == 1 ? 'Карта дня' : 'Три карты')),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(24),
            children: [
              for (var i = 0; i < selected.length; i++)
                Card(
                  color: const Color(0xFF251722),
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(children: [
                      const Icon(Icons.auto_awesome, color: gold, size: 42),
                      const SizedBox(height: 10),
                      Text('Аркан №${selected[i]}',
                        style: const TextStyle(color: gold, fontSize: 23)),
                      if (count == 3)
                        Text(['Прошлое', 'Настоящее', 'Будущее'][i]),
                    ]),
                  ),
                ),
            ],
          ),
        ),
      ),
    ));
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Моя колода')),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.68,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: 78,
    itemBuilder: (context, index) => GestureDetector(
        onTap: () {
            if (index == 0) {
                  Navigator.push(
                          context,
                                  MaterialPageRoute(
                                            builder: (context) => const FoolDetailPage(),
                                                    ),
                                                          );
                                                              }
                                                                },
                                                                  child: Card(
          color: const Color(0xFF251722),
child: index == 0
    ? Image.asset('assets/cards/00_fool.png', fit: BoxFit.cover)
        : Center(child: Text(
            'Аркан\n${index + 1}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: gold),
          )),
        ),
      ),
      ),
    );
  }
  }
  

