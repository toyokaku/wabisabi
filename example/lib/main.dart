import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wabisabi/flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = true;
  
  void _toggleTheme() {
    setState(() {
      isDark = !isDark;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    if (isIos()) {
      return CupertinoApp(
        theme: WabTheme.cupertinoTheme(lightTheme: !isDark),        
        home: MyHomePage(title: 'Cupertino Preview', toggleTheme: _toggleTheme, isDark: isDark,),
      );
    }
    return MaterialApp(
      theme: WabTheme.materialTheme(lightTheme: !isDark),      
      home: MyHomePage(title: 'Material Preview', toggleTheme: _toggleTheme, isDark: isDark,),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, this.toggleTheme, required this.isDark});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final VoidCallback? toggleTheme;
  final bool isDark;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
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

    bool _isDark = widget.isDark;
    var theme = Theme.of(context);  
    WabTheme.materialTheme(lightTheme: !_isDark);

    return WabScaffold(
      appBar: WabAppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        action: new WabIconButton(
          label: Text('Appbar Action'),
          icon: Icon(Icons.auto_stories),
          callback: () => print('appbar callback'),
        ),
        leading:  WabIconButton(
          icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          callback: () => widget.toggleTheme!(),
        )

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
              WAB_SIZED_BOX_20,
              Text(
                'Headline6',
                style: theme.textTheme.titleLarge,
              ),
              WAB_SIZED_BOX_20,
              Text(
                'Headline1',
                style: theme.textTheme.displayLarge,
              ),
              WabDivider(),
              Text(
                'You have pushed the button this many times:',
              ),
              WAB_SIZED_BOX_20,
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              WabDivider(),
              Container(
                margin: WAB_PADDING_ALL,
                padding: WAB_PADDING_CONTAINER_LARGE,
                child: WabTextFormField(
                  validator: (val) =>
                      (val?.isEmpty ?? true) ? 'test text form' : null,
                  callback: (val) => print('text form callback: ' + val),
                ),
              ),
              WabContainer(child: Text('WabContainer')),
              WabLiteContainer(
                child: WabNumberFormField(
                  value: 250,
                  labelText: 'WabNumberFormField',
                ),
              ),
              WabElevatedButton(
                text: Text('WabElevatedButton'),
                callback: () => print('WabRaiseButton'),
              ),
              WAB_SIZED_BOX_20,
              WabTextButton(
                text: Text('WabTextButton'),
                callback: () => print('WabTextButton'),
              ),
              WabImage(path: 'images/avatar.jpg'),
              WabPaymentRow(
                image: WabIcon(path: 'images/googlepay.png'),
                text: Text('WabPaymentRow'),
                callback: () => print('WabPaymentRow'),
              ),
              WabWarningText(text: 'WarningText'),
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
