import 'package:flutter/material.dart';

class Page404View extends StatelessWidget {
  const Page404View({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Page 404'),centerTitle: true,),
      body: Container(
        color: Colors.red,
        child: const Center(
          child: Text(
            'Página não encontrada',textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 40,letterSpacing: 2),
          ),
        ),
      ),
    );
  }
}
