import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ViewDemo extends StatelessWidget {
  const ViewDemo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: PageView(
        onPageChanged: (currentPage)=> debugPrint('Page:$currentPage'),
        controller: PageController(
          initialPage:0,
    
          ),
        children: <Widget>[
          Container(
            color:Colors.brown[900],
            alignment: Alignment(0.0,0.0),
            child: Text(
              'ONE',
              style: TextStyle(fontSize: 32.0,color: Colors.white),
            ),
          ),
          Container(
            color:Colors.grey[900],
            alignment: Alignment(0.0,0.0),
            child: Text(
              'TWO',
              style: TextStyle(fontSize: 32.0,color: Colors.white),
            ),
          ),
          Container(
            color:Colors.blueGrey[900],
            alignment: Alignment(0.0,0.0),
            child: Text(
              'THREE',
              style: TextStyle(fontSize: 32.0,color: Colors.white),
            ),
          ),
        ],
      )
    );
  }
}


class MyPageView extends StatefulWidget {
  MyPageView({Key key}) : super(key: key);

  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  PageController _pageController;
  num currentPage =0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    accelerometerEvents.listen((AccelerometerEvent event){
        print(event);
        var currentIndex = event.x<10?1:0;
        currentPage+=currentIndex;
        _pageController.animateToPage(
                        currentPage,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
        );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          children: [
            Container(
              color: Colors.red,
              child: Center(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text('Next'),
                ),
              ),
            ),
            Container(
              color: Colors.blue,
              child: Center(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        2,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text('Previous'),
                ),
              ),
            ),
            Container(
              color: Colors.green,
              child: Center(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {
                    if (_pageController.hasClients) {
                      _pageController.animateToPage(
                        0,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text('Three'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}