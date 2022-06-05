import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fitness/model/ExercisesModel.dart';
import 'package:flutter_fitness/pages/details.dart';
import 'package:flutter_fitness/widget/widget.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<ExercisesModel>list=[];
  String link="https://raw.githubusercontent.com/codeifitech/fitness-app/master/exercises.json?fbclid=IwAR28_O-lpDF-lxTjLj9kG1z5qZ8_1KekSzmGZZYVRMWbCjQqrxTQHVcAvvU";
  bool isLoading = false;
  fechData() async{
    var responce= await http.get(Uri.parse(link));
    print("starts code is${responce.statusCode}");
    if(responce.statusCode==200){
      final item= jsonDecode(responce.body);
      for(var data in item["exercises"]){
        ExercisesModel exercisesModel =ExercisesModel(
          id: data["id"],
          title: data["title"],
          thumbnail: data["thumbnail"],
          gif: data["gif"],
          seconds: data["seconds"]

        );

        setState(() {
          list.add(exercisesModel);
        });
      }
      print("total lenght is${list.length}");
    } else{

    }



  }

  @override
  void initState(){
    fechData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Api Featch"),
        centerTitle: true,
      ),
      
      body: ModalProgressHUD(
        inAsyncCall: isLoading == true,
        progressIndicator: spinkit,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            child: ListView.builder(itemCount: list.length,shrinkWrap: true,itemBuilder: (context,index){
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailsPage(
                      excerciesModel: list[index],)));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Stack(
                      children: [
                        Image.network("${list[index].thumbnail}",width: double.infinity,fit: BoxFit.cover,),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 65,
                            padding: EdgeInsets.all(16),
                            alignment: Alignment.bottomLeft,
                            child: Text("${list[index].title}",style: TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.bold),),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black38,
                                  Colors.black54,
                                  Colors.black87,


                                ]
                              )
                            ),
                          ),
                        )
                      ],
                    )

                  ),
                ),
              );

            },),
          ),
        ),
      ),
    );
  }
}
