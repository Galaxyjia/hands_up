import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:sensors/sensors.dart';
import './demo/view_demo.dart';
import './demo/rxdart/rxdart_demo.dart';


void main(){
  ///横屏
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight
  // ]);

  runApp(new MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: new Center(
          child: RxDartDemoHome(),
        ),
      ),
    );
  }
}


class Countdown extends StatefulWidget {
  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {

  Timer _timer;
  int seconds;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(constructTime(seconds)),
    );
  }

  //时间格式化，根据总秒数转换为对应的 hh:mm:ss 格式
  String constructTime(int seconds) {
    int hour = seconds ~/ 3600;
    int minute = seconds % 3600 ~/ 60;
    int second = seconds % 60;
    return formatTime(hour) + ":" + formatTime(minute) + ":" + formatTime(second);
  }

  //数字格式化，将 0~9 的时间转换为 00~09
  String formatTime(int timeNum) {
    return timeNum < 10 ? "0" + timeNum.toString() : timeNum.toString();
  }

  @override
  void initState() {
    super.initState();
    //获取当期时间
    var now = DateTime.now();
    //获取 2 分钟的时间间隔
    var twoHours = now.add(Duration(minutes: 2)).difference(now);
    //获取总秒数，2 分钟为 120 秒
    seconds = twoHours.inSeconds;
    startTimer();
  }

  void startTimer() {
    //设置 1 秒回调一次
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      //更新界面
      setState(() {
        //秒数减一，因为一秒回调一次
        seconds--;
      });
      if (seconds == 0) {
        //倒计时秒数为0，取消定时器
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
  }

}

class DisplayPage extends StatefulWidget {
  @override
  _DisplayPageState createState() => new _DisplayPageState();
}

class _DisplayPageState extends State<DisplayPage> {
  static bool _isAddGradient = false;

  final List descriptions = [
    'Correct',
    'Pass',
    'tryenough.com',
  ];

  var decorationBox = DecoratedBox(
    decoration: _isAddGradient
        ? BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomRight,
              end: FractionalOffset.topLeft,
              colors: [
                Color(0x00000000).withOpacity(0.9),
                Color(0xff000000).withOpacity(0.01),
              ],
            ),
          )
        : BoxDecoration(),
  );

  @override
  void initState() {
    super.initState();
    accelerometerEvents.listen((AccelerometerEvent event){
        print(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    PageController controller = PageController(viewportFraction: 0.8);

    controller.addListener((){

    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SizedBox.fromSize(
          size: Size.fromHeight(550.0),
          child: PageView.builder(
            controller: controller,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 8.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Scaffold.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.deepOrangeAccent,
                      duration: Duration(milliseconds: 800),
                      content: Center(
                        child: Text(
                          descriptions[index],
                          style: TextStyle(fontSize: 25.0),
                        ),
                      ),
                    ));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(8.0),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
                        decorationBox,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}