import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}
class _OCRPageState extends State<OCRPage> {
  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "TEXT";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('OCR In Flutter'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(_text,style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 500,
              ),
              Container(
                padding: EdgeInsets.only(right: 20,left: 20),
                width: MediaQuery.of(context).size.width,
                  child: RaisedButton.icon(
                      onPressed: _read,
                      icon: Icon( CupertinoIcons.search_circle),
                      label: Text("Scan", style: TextStyle(fontSize: 22),)),

              ),

            ],
          ),
        ),
      ),
    );
  }
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: true,
      );
      setState(() {
        _text = texts[0].value;
      });
    } on Exception {
      texts.add( OcrText('Failed to recognize text'));
    }
  }
}