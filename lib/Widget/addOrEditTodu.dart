import 'package:flutter/material.dart';

import '../model/ToduModel.dart';
import '../todu.dart';


class addOrEditTodu extends  StatefulWidget {
    String? title;
    String? dec;

    addOrEditTodu({this.title , this.dec});

  @override
  State<addOrEditTodu> createState() => _addOrEditToduState();
}

class _addOrEditToduState extends State<addOrEditTodu> {
  TextEditingController titleCon = TextEditingController();

  TextEditingController decCon = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleCon.text = widget.title??'';
     decCon.text = widget.dec??'';
  }

  @override
  Widget build(BuildContext context) {
      return AlertDialog(
        title:  Text(widget.title == null ?  'add' : 'edit') ,
        content: Container(
          height: MediaQuery.of(context).size.height*0.2,
          child:  Column(
            children: [
              TextField(
                controller: titleCon,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:'enter title'
                ),
              ),
              const SizedBox(height: 20,),
              TextField(
                controller: decCon,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:'enter des'
                ),
              )
            ],
          ),
        ),
        actions: [
          ElevatedButton(
              style: ButtonStyle(
                backgroundColor:  MaterialStateProperty.all(Colors.redAccent),
              ),
              onPressed: (){
                Navigator.pop(context);
              },
              child: const Text('cancel' ,)
          ),
          ElevatedButton(
              onPressed: (){
                    // Todu(id: 1 , title: titleCon.text.toString() , dec:  decCon.text.toString())

                    // print(todu.length.toString());
                Navigator.pop(context , Todu(title: titleCon.text.toString() , dec:  decCon.text.toString()));
              },
              child:  Text(widget.title ==null ?  'create' : 'update')
          )
        ],
      );
  }
}