import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:w_app/provider/MyModel.dart';
import 'package:w_app/services.dart';


import 'model.dart';

class SelectScreen extends StatefulWidget {
  const SelectScreen({super.key});

  @override
  State<SelectScreen> createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  List<String> item = ['kochi','kolkata','delhi','chennai'];
  String dval='kochi';


  Model1 a= Model1();
  bool isloading = true;
  Welcome? mod1;

  Future<void> data( String value) async {
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

  @override
  Widget build(BuildContext context) {
var myModel = Provider.of<MyModel>(context);
    return Container(width: 100,
      child: DropdownButton(
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

      ),
    );
  }
}
