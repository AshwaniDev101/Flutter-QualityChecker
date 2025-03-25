import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qualitychecker/card/rowcard.dart';
import 'package:qualitychecker/style.dart';

import 'data.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SafeArea(
          child: Text(""),
        ),
        Container(
          color: MyColors.top_row,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                // [Defactive] [Tottal Defects] [Total Inspection (check)] [Total pass(accepted)] [DHU %] Defect x100/Total inspection
                Text(
                  "Hours",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
                Text(
                  "Defective",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
                Text(
                  "Total\nDefects",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
                Text(
                  "Total\nInspected",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
                Text(
                  "Total\nPassed",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
                Text(
                  "D.H.U %",
                  textAlign: TextAlign.center,
                  style: TextStyles.top_row,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 5),
              itemCount: Calculation.defectiveList.length,
              itemBuilder: (BuildContext context, int index) {
                return RowCard(
                    index: index,
                    defective: Calculation.defectiveList[index],
                    defects: Calculation.defectsList[index],
                    inspected: Calculation.inspectedList[index],
                    accepted: Calculation.passedList[index],
                    dhu: Calculation.dhuList[index],
                    onChange: onDataChange);
              }),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 8),
            child: Column(
              children: [
                // Text(
                //   '(Developed by Arun kumar)',
                //   style: TextStyle(color: Colors.blue, fontSize: 14),
                // ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    InkWell(
                      onTap: (){
                        calculatePassAndDHU();
                      },
                      child: Text("Total:",
                          style: TextStyles.row_index,
                          textAlign: TextAlign.center),
                    ),

                    SizedBox(
                      width: 45,
                      child: Text(
                        Calculation.totalDefective.toString(),
                        style: TextStyles.bottom_row,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: Text(
                        Calculation.totalDefects.toString(),
                        style: TextStyles.bottom_row,
                      ),
                    ),
                    SizedBox(
                      width: 45,
                      child: Text(
                        Calculation.totalInspected.toString(),
                        style: TextStyles.bottom_row,
                      ),
                    ),
                    Container(
                      width: 45,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: MyColors.field_blue_light,),

                      child: Center(
                        child: Text(
                          Calculation.totalPassed.toString(),
                          style: TextStyles.bottom_row,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      width: 65,
                      height: 40,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: MyColors.field_blue_light,),
                      child: Center(
                        child: Text(
                          "${Calculation.totalDHU.toStringAsFixed(2)}%",
                          style: TextStyles.bottom_row,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }

  void onDataChange(WhatChange change, int index, String value) {
    print('${change.toString()} : $index ($value)');

    total(change).whenComplete(() {
      setState(() {});
      calculatePassAndDHU().whenComplete(() {
        setState(() {});
      });
    });
  }



  Future<void> total(WhatChange change) async {
    switch (change) {

      case WhatChange.DEFECTIVE_LIST:
        Calculation.totalDefective = await Calculation.defectiveList.reduce((a, b) => a + b);
        break;

      case WhatChange.DEFECTS_LIST:
        Calculation.totalDefects = await Calculation.defectsList.reduce((a, b) => a + b);
        break;

      case WhatChange.INSPECTED_LIST:
        Calculation.totalInspected = await Calculation.inspectedList.reduce((a, b) => a + b);
        break;
    }
  }


/*  Timer? _timer;
  void updateCalculate()
  {
    _timer?.cancel();
    _timer = Timer(Duration(seconds: 2),(){

      print("===========Call Update============");
      calculatePassAndDHU();
    });
  }*/

  Future<void> calculatePassAndDHU() async
  {

    setState(() {
      Calculation.totalPassed = Calculation.totalInspected - Calculation.totalDefective;
      Calculation.totalDHU = (Calculation.totalDefects *100) /Calculation.totalInspected;
    });
  }
}
