import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  var valSwitch = false;

  AnimationController _animationController;
  Animation _heightAnimation;
  double heightSizeContainer;
  
  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: Duration(milliseconds: 100),
      vsync: this
    );

    _heightAnimation = Tween(
      begin: 50.0,
      end: 200.0
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: [
              Container(height: 200),
              
              AnimatedBuilder(
                animation: _animationController, 
                builder: (BuildContext context, _) {
                  return 
                    Container(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: _heightAnimation.value == 0 ? 50 : _heightAnimation.value * 1.0,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1
                        )
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 48,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: 
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Habilitar detalhes"
                                  ),
                                  Switch(
                                    value: valSwitch, 
                                    onChanged: (val) {
                                      valSwitch = !valSwitch;

                                      valSwitch ?
                                      _animationController.forward() :_animationController.reverse();

                                      setState(() {
                                        
                                      });
                                    }
                                  )
                                ],
                              )
                          ),
                          _heightAnimation.value == 50 ? Container() : Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.grey[300],
                          ),
                        ],
                      ),
                    );
                }
              ),

              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                margin: EdgeInsets.only(top: 16),
                child: 
                  Text("Outros conteúdos logo abaixo")
              )

            ],
          ),
        ),
      ),
    );
  }
}