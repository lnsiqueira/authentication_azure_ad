import 'package:authentication_azure_ad/authentication_azure_ad.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Azure AD authentication',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo Azure AD authentication'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String>? _future;
  @override
  void initState() {
    super.initState();
    _future = myFuture();
  }

  Future<String> myFuture() async {
    var result = await AzureADAuthentication.getToken(
        'xxx', 'xxx', ['https://graph.microsoft.com/.default']);

    debugPrint(result);

    return (result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<String>(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            final isToken = snapshot.data ?? "waiting...";
            return Text(isToken);
          }
        },
      ),
      floatingActionButton: ElevatedButton(
        child: const Text('get token'),
        onPressed: () {
          setState(() {
            _future = myFuture();
          });
        },
      ),
    );
  }
}
