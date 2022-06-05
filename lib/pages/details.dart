import 'package:flutter/material.dart';
import 'package:flutter_fitness/model/ExercisesModel.dart';
import 'package:flutter_fitness/pages/home.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DetailsPage extends StatefulWidget {
   DetailsPage({Key? key,this.excerciesModel}) : super(key: key);
  ExercisesModel? excerciesModel;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            "${widget.excerciesModel!.thumbnail}",
            width: double.infinity,
            fit: BoxFit.cover,
            height: double.infinity,
          ),
          Positioned(
            bottom: 20,
            right: 0,
            left: 0,
            child: Column(
              children: [
                SleekCircularSlider(
                  innerWidget: (value) {
                    return Container(
                      alignment: Alignment.center,
                      child: Text("${second.toStringAsFixed(0)} S",style: TextStyle(fontSize: 28,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
                    );
                  },
                  appearance: CircularSliderAppearance(
                      customWidths: CustomSliderWidths(progressBarWidth: 10)),
                  min: 1,
                  max: 30,
                  initialValue: second,
                  onChange: (value) {
                    setState(() {
                      second = value;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () { Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => HomePage()));
                  },
                  child: Text(' Next '),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepOrange,
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25), // <-- Radius
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );


  }
  double second = 3;
}
