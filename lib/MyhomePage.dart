import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w_app/Select.dart';
import 'package:w_app/provider/MyModel.dart';
import 'package:w_app/services.dart';
import 'package:w_app/model.dart';
import 'package:intl/intl.dart';


class ScreenUtil {
  static double screenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }
}


class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Model1 a= Model1();
  Welcome? mod1;

  // DateFormat? now=DateFormat();

  bool isloading = true;

  @override
  void initState() {
    super.initState();

    data('kochi');
  }

  Future<void> data(String value) async {
    try {
      Welcome fetchedModel = await a.getData(value);
      setState(() {
        mod1 = fetchedModel;
        isloading = false;
      });
      print('country : ${mod1?.location.country}');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }





  List<String> item = ['kochi','kolkata','delhi','chennai',];
  String dval='kochi';

  @override
  Widget build(BuildContext context) {
    var myModel = Provider.of<MyModel>(context);
    double width = ScreenUtil.screenWidth(context);
    double height = ScreenUtil.screenHeight(context);

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.grey[700],
        actions: [DropdownButton(
          icon: Icon(Icons.menu,size: 30,color: Colors.black),
          value: dval,
          onChanged: (v) {
            print (dval);

            setState(() {
              dval=v!;
              data(v!);
            });
          },
          items: item.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),

        ),],
      ),
      backgroundColor: Colors.black,
      body: SafeArea(
          child: isloading?Center(child: CircularProgressIndicator()):Container(
            height: height ,
            width: width,
            color: Colors.black,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        mod1!.location.name,style: TextStyle(
                        color: Colors.white60,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,),),
                      Text( '${DateFormat.yMMMMd('en_US').format(DateTime.now())}',style: TextStyle(color: Colors.white60)),
                      SizedBox(height: 100),
                      Image.network(
                        'http:'+mod1!.current.condition.icon,
                        width: 100,
                        height: 100,fit: BoxFit.cover,
                      ),
                      Text(mod1!.current.condition.text, style: TextStyle(fontSize: 30,color: Colors.white60)),

                    ],
                  ),
                  SizedBox(height: 100,),



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          height:150,
                          width: 150,
                          decoration: BoxDecoration(
                                      color: Colors.redAccent,
                                      borderRadius: BorderRadius.circular(75)),
                          padding: EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('Assets/temperature.png',
                                  height: 30,width: 30,fit: BoxFit.cover),
                              SizedBox(width: 5),
                              Text(
                                mod1!.current.feelslikeC.toString()+"°C",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),),
                            ],
                          ),

                       ),
                      SizedBox(width: 20,),
                      SizedBox(
                        height: 150,
                        width: width * .5,
                        child: Card(

                          color: Colors.grey[800],
                          child: Column(
                            children: [
                              Text('Wind',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30, color: Colors.white60)),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('Assets/wind.png',
                                      width: 35, height: 40),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(mod1!.current.gustKph.toString()+' kph',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700,color: Colors.white60)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),










                  // ElevatedButton(
                  //     onPressed: () {
                  //       a.getData();
                  //     },
                  //     child: Text(
                  //        'Get Data',
                  //     )),
                ]),
          )),
    );
  }
}