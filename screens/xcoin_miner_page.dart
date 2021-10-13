import 'package:flutter/material.dart';

class MinerPage extends StatefulWidget {
  const MinerPage({ Key? key }) : super(key: key);

  @override
  _MinerPageState createState() => _MinerPageState();
}

class _MinerPageState extends State<MinerPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: const <Widget>[
        Center(child: Text("Miner")),
      ],
    );
  }
}