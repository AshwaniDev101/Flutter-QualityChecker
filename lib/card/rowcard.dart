
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qualitychecker/style.dart';

import '../data.dart';


class RowCard extends StatefulWidget {

  final int index;
  final int defective;
  final int defects;
  final int inspected;
  final int accepted;
  final double dhu;
  final Function(WhatChange, int, String) onChange;


  const RowCard({Key? key, required this.index, required this.defective, required this.defects, required this.inspected, required this.accepted, required this.dhu, required this.onChange}) : super(key: key);


  @override
  State<RowCard> createState() => _RowCardState();
}

class _RowCardState extends State<RowCard> {


  final double _boxHeight = 60;
  final double _boxWidth = 60;

  final TextEditingController ctrlDefective = TextEditingController();
  final TextEditingController ctrlDefects = TextEditingController();
  final TextEditingController ctrlInspected = TextEditingController();
  final TextEditingController ctrlPassed = TextEditingController();
  final TextEditingController ctrlDHU = TextEditingController();

  @override
  void initState() {
    super.initState();

    ctrlDefective.text = widget.defective==0?'':widget.defective.toString();
    ctrlDefects.text  = widget.defects==0?'':widget.defects.toString();
    ctrlInspected.text = widget.inspected==0?'':widget.inspected.toString();
    ctrlPassed.text = widget.accepted==0?'':widget.accepted.toString();
    ctrlDHU.text = widget.dhu==0?'':widget.dhu.toString();


  }


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(top: 1),
      color: MyColors.field_background,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [

          SizedBox(
            width: 25,
              child: Text("${widget.index+1}.",textAlign: TextAlign.right,style: TextStyles.row_index,)),

          SizedBox(
            height: _boxHeight,
            width: _boxWidth,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: ctrlDefective,
                onChanged: (String str){
                  Calculation.defectiveList[widget.index] = int.parse(str.isEmpty?'0':str);
                  totalAcceptedAndDHU();
                  widget.onChange(WhatChange.DEFECTIVE_LIST,widget.index,str);



                },
                onEditingComplete: ()=>FocusScope.of(context).nextFocus(),

                textAlign: TextAlign.center,
                decoration: MyDecorations.field_input,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],

              ),
            ),
          ),
          SizedBox(
            height: _boxHeight,
            width: _boxWidth,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: ctrlDefects,
                onChanged: (String str){

                  Calculation.defectsList[widget.index] = int.parse(str.isEmpty?'0':str);
                  totalAcceptedAndDHU();
                  widget.onChange(WhatChange.DEFECTS_LIST,widget.index,str);

                },
                onEditingComplete: ()=>FocusScope.of(context).nextFocus(),
                textAlign: TextAlign.center,
                decoration: MyDecorations.field_input,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ),
          SizedBox(
            height: _boxHeight,
            width: _boxWidth,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: ctrlInspected,
                onChanged: (String str){
                  Calculation.inspectedList[widget.index] = int.parse(str.isEmpty?'0':str);
                  totalAcceptedAndDHU();
                  widget.onChange(WhatChange.INSPECTED_LIST,widget.index,str);
                },
                onEditingComplete: ()=>FocusScope.of(context).nextFocus(),
                textAlign: TextAlign.center,
                decoration: MyDecorations.field_input,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ),
          SizedBox(
            height: _boxHeight,
            width: _boxWidth,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: ctrlPassed,
                onEditingComplete: ()=>FocusScope.of(context).nextFocus(),
                enabled: false,
                textAlign: TextAlign.center,
                decoration: MyDecorations.field_input_disable,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ),
          SizedBox(
            height: _boxHeight,
            width: _boxWidth+30,
            child:  Padding(
              padding: const EdgeInsets.all(8),
              child: TextField(
                controller: ctrlDHU,
                onEditingComplete: ()=>FocusScope.of(context).nextFocus(),
                enabled: false,
                textAlign: TextAlign.center,
                decoration: MyDecorations.field_input_disable,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
            ),
          ),



        ],
      ),
    );
  }



  void totalAcceptedAndDHU()
  {
    Calculation.passedList[widget.index] =  Calculation.inspectedList[widget.index] - Calculation.defectiveList[widget.index];

    setState(() {
      ctrlPassed.text = Calculation.passedList[widget.index]==0?'':Calculation.passedList[widget.index].toString();
    });
    dshCalculation();
  }

  void dshCalculation()
  {
    Calculation.dhuList[widget.index] = (Calculation.defectsList[widget.index] *100)/Calculation.inspectedList[widget.index];
    setState(() {

      if(ctrlInspected.text.isEmpty && ctrlDefects.text.isEmpty)
        {
          ctrlDHU.text = '';
        }else
          {
            ctrlDHU.text = '${Calculation.dhuList[widget.index].toStringAsFixed(2)}%';
          }

    });
  }
}


