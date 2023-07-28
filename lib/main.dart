import 'package:dinamik_not_ortalama/constants/app_constants.dart';
import 'package:dinamik_not_ortalama/widgets/ortalama_hesapla_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dinamik Not Hesapla',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Sabitler.anaRenk,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      home: OrtalamaHesaplaPage(
      ),
    );
  }
}