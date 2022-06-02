import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class OwnMessageCart extends StatelessWidget{
  String message;
  String time;
  OwnMessageCart({
    required this.message,
    required this.time,
});

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width - 45,
      ),
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          color: Colors.blueAccent,
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 60, top: 5, bottom: 20),
                child: Text(this.message,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 10,
                child: Text(this.time,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}