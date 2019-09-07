import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:async';

class RxDartDemoHome extends StatefulWidget {
  RxDartDemoHome({Key key}) : super(key: key);

  _RxDartDemoHomeState createState() => _RxDartDemoHomeState();
}

class _RxDartDemoHomeState extends State<RxDartDemoHome> {
  String txt='';

  @override
  void initState(){
    super.initState();
    // Observable<String> _observable =
    //   // Observable(Stream.fromIterable(['elements','hello']));
    //   // Observable.fromFuture(Future.value("hello~"));
    //   // Observable.fromIterable(['data','haha']);
    //   // Observable.just("data");
    //   // Observable.periodic(Duration(seconds: 3),(x)=>x.toString());
    //   _observable.listen(print)

      // BehaviorSubject<String> _subject = BehaviorSubject<String>();
      // _subject.add("hello");
      // _subject.add("hola");
      // _subject.listen((data)=>print('listen 1: $data'));
     
      // _subject.listen((data)=>print('listen 2:${data.toUpperCase()}'));
      
      // _subject.close();
    someBasicFn();

  }

  someBasicFn(){
    String str="床前明月光，疑是地上霜。举头望明月，低头思故乡。";
    var words = str.split('');
    var obs1 = new Observable(new Stream.fromIterable(words))
    .interval(new Duration(milliseconds:200))
    // .map((String oneItem)=>oneItem = oneItem.toUpperCase())
    // .expand((String oneItem)=>[oneItem,oneItem.split('')])
    .listen((val){
      print(val);
      setState(() {
          txt += val;
      });
    });
  }


  @override
  Widget build(BuildContext context){
    return Container(
       child: Text("$txt"),
    );
  }
}