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
        home: MyHomePage(title: 'Wabisabi Demo', toggleTheme: _toggleTheme, isDark: isDark),
      );
    }
    return MaterialApp(
      theme: WabTheme.materialTheme(lightTheme: !isDark),      
      home: MyHomePage(title: 'Wabisabi Demo', toggleTheme: _toggleTheme, isDark: isDark),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({required this.title, this.toggleTheme, required this.isDark});

  final String title;
  final VoidCallback? toggleTheme;
  final bool isDark;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>{
  int _counter = 0;
  bool _isToggled = false;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }
  
  void _toggleSwitch() {
    setState(() {
      _isToggled = !_isToggled;
    });
  }
 
  @override
  Widget build(BuildContext context) {
    bool _isDark = widget.isDark;
    var theme = Theme.of(context);  
    WabTheme.materialTheme(lightTheme: !_isDark);

    return WabTexturedScaffold(
      appBar: WabAppBar(
        title: Text(widget.title),
        action: WabIconButton(
          icon: Icon(Icons.info_outline),
          callback: () => print('Info button pressed'),
        ),
        leading: WabIconButton(
          icon: Icon(widget.isDark ? Icons.light_mode : Icons.dark_mode),
          callback: () => widget.toggleTheme!(),
        )
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Display themed widgets
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    // Container examples
                    WabContentContainer(
                      child: WabContainer(
                        child: Column(
                          children: [
                            Text(
                              'WabContainer Example',
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'This shows the primary surface color with rounded corners.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    WabContentContainer(
                      child: WabLiteContainer(
                        child: Column(
                          children: [
                            Text(
                              'Light Container Example',
                              style: theme.textTheme.titleLarge,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'This shows the secondary surface color with rounded corners.',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    WabDivider(),
                    
                    // Counter section
                    WabContentContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'You have pushed the button this many times:',
                            ),
                            SizedBox(height: 10),
                            Text(
                              '$_counter',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    WabDivider(),
                    
                    // Buttons section header
                    WabContentContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Button Examples',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    
                    // Standard Elevated Button
                    WabContentContainer(
                      child: WabElevatedButton(
                        text: Text('Elevated Button'),
                        callback: () => print('Elevated button pressed'),
                        padding: 16.0,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // LTE style button (with chevron)
                    WabContentContainer(
                      child: WabElevatedButton(
                        text: Text('LTE'),
                        callback: () => print('LTE button pressed'),
                        showChevron: true,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Option button (with icon and chevron)
                    WabContentContainer(
                      child: WabElevatedButton(
                        text: Text('Option'),
                        callback: () => print('Option button pressed'),
                        icon: Icon(Icons.settings, size: 18),
                        showChevron: true,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Text Button
                    WabContentContainer(
                      child: WabTextButton(
                        text: Text('Text Button'),
                        callback: () => print('Text button pressed'),
                        padding: 16.0,
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Toggle Buttons Row
                    WabContentContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: WabToggleButton(
                              text: Text('ON'),
                              isOn: true,
                              callback: _toggleSwitch,
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: WabToggleButton(
                              text: Text('OFF'),
                              isOn: false,
                              callback: _toggleSwitch,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Icon Buttons Row
                    WabContentContainer(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 3,
                            child: WabIconButton(
                              icon: Icon(Icons.settings),
                              label: Text('Settings'),
                              callback: () => print('Settings button pressed'),
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            flex: 1,
                            child: WabIconButton(
                              icon: Icon(Icons.search),
                              callback: () => print('Search button pressed'),
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    // Search field
                    WabContentContainer(
                      child: WabSearchField(
                        hintText: 'Search',
                        onSubmitted: (value) => print('Search submitted: $value'),
                      ),
                    ),
                    
                    SizedBox(height: 24),
                    
                    WabDivider(),
                    
                    // Form controls section header
                    WabContentContainer(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          'Form Controls',
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                    ),
                    
                    // Text Form Field
                    WabContentContainer(
                      child: WabTextFormField(
                        validator: (val) =>
                            (val?.isEmpty ?? true) ? 'Text cannot be empty' : null,
                        callback: (val) => print('Text submitted: ' + val),
                        hintText: 'Enter some text',
                      ),
                    ),
                    
                    SizedBox(height: 16),
                    
                    // Number Form Field
                    WabContentContainer(
                      child: WabNumberFormField(
                        value: _counter,
                        labelText: 'Counter Value',
                      ),
                    ),
                    
                    SizedBox(height: 32),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

