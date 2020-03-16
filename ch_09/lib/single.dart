//import 'package:dice_knock_out/knockout.dart';
import 'dice.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'knockout.dart';

class Single extends StatefulWidget {
  @override
  _SingleState createState() => _SingleState();
}

class _SingleState extends State<Single> {
  String currentAnimation;
  
  @override
  void initState() {
    currentAnimation = 'Start';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.8;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.fitness_center),
            onPressed: () {
              MaterialPageRoute route = MaterialPageRoute(builder: (context)=> KnockOutScreen());
              Navigator.push(context, route);
            },
          )
        ],
        title: Text('Single Dice'),
      ),
      body: Center(
          child: Column(
        children: <Widget>[
          Container(
              height: height / 1.5,
              width: width * 0.8,
              child: FlareActor(
                'assets/dice.flr',
                fit: BoxFit.contain,
                animation: currentAnimation,  
              )),
          SizedBox(
            width: width/2.5,
            height: height / 10,
            child:RaisedButton(
            child: Text('Play'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24)
            ),
            onPressed: () {
              setState(() {
                currentAnimation = 'Rolll';
              });
              Dice.wait3seconds().then((_){
                callResult();
              });            
            },
          ))
        ],
      )),
    );
  }

  
  void callResult() async {
    
    Map<int, String> animation = Dice.getRandomAnimation();
    setState(() {
      currentAnimation = animation.values.first;
    });
  }
}
