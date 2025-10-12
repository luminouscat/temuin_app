import 'package:flutter/material.dart';

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  List<String> examples = ['Mario', 'Luigi', 'Princess Peach', 'Tired'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Company Home")),
      body: SafeArea(child: Text("Company")),
    );
  }
}

// bottom navigator (with riverpod)
