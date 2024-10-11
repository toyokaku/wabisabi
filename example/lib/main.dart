import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:songkoro/flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    if (isIos()) {
      return CupertinoApp(
        theme: SkrTheme.cupertinoTheme(lightTheme: true),
        home: MyHomePage(
          title: 'Cupertino Preview',
        ),
      );
    }
    return MaterialApp(
      theme: SkrTheme.materialTheme(
        primaryColor: Colors.blueGrey[700],
        secondaryColor: Colors.blueAccent[100],
      ),
      home: MyHomePage(title: 'Material Preview'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    var theme = Theme.of(context);

    return SkrScaffold(
      appBar: SkrAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        action: new SkrIconButton(
          label: Text('Appbar Action'),
          icon: Icon(Icons.auto_stories),
          callback: () => print('appbar callback'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Headline4',
                style: theme.textTheme.headlineMedium,
              ),
              SKR_SIZED_BOX_20,
              Text(
                'Headline6',
                style: theme.textTheme.titleLarge,
              ),
              SKR_SIZED_BOX_20,
              Text(
                'Headline1',
                style: theme.textTheme.displayLarge,
              ),
              SkrDivider(),
              Text(
                'You have pushed the button this many times:',
              ),
              SKR_SIZED_BOX_20,
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SkrDivider(),
              Container(
                margin: SKR_PADDING_ALL,
                padding: SKR_PADDING_CONTAINER_LARGE,
                child: SkrTextFormField(
                  validator: (val) =>
                      (val?.isEmpty ?? true) ? 'test text form' : null,
                  callback: (val) => print('text form callback: ' + val),
                ),
              ),
              SkrContainer(child: Text('skrContainer')),
              SkrLiteContainer(
                child: SkrNumberFormField(
                  value: 250,
                  labelText: 'skrNumberFormField',
                ),
              ),
              SkrElevatedButton(
                text: Text('skrElevatedButton'),
                callback: () => print('squareRaiseButton'),
              ),
              SKR_SIZED_BOX_20,
              SkrTextButton(
                text: Text('skrTextButton'),
                callback: () => print('skrTextButton'),
              ),
              SkrImage(path: 'images/avatar.jpg'),
              SkrPaymentRow(
                image: SkrIcon(path: 'images/googlepay.png'),
                text: Text('skrPaymentRow'),
                callback: () => print('skrPaymentRow'),
              ),
              SkrWarningText(text: 'warningText'),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
