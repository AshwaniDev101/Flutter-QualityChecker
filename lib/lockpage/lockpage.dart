import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:qualitychecker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homepage.dart';
import '../style.dart';

class LockPage extends StatefulWidget {

  final SharedPreferences prefs;
  final String boolKey;
  const LockPage(this.prefs, this.boolKey,{Key? key}) : super(key: key);

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {


  final List<TextEditingController> tEctrl = [TextEditingController(),TextEditingController(),TextEditingController(),TextEditingController(),];


  // @override
  // void dispose() {
  //   Navigator.popUntil(context, (route) {
  //   });
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
                height: 80,
                width: 80,
                child: Image.asset('assets/icons/icon.png',)),
            SizedBox(height: 40,),
            Text('Quality Checker',style: TextStyle(fontSize: 20,color: Colors.blue,fontWeight: FontWeight.bold),),

            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                getTextField(tEctrl[0]),
                getTextField(tEctrl[1]),
                getTextField(tEctrl[2]),
                getTextField(tEctrl[3]),
              ],
            ),
            SizedBox(height: 40,),
            SizedBox(
              height: 40,
              width: 100,
              child: ElevatedButton(child: Text('Verify'),onPressed: (){

                check();

              }),
            ),
          ],
        ),
      ),
    );

  }


  Widget getTextField(TextEditingController tec)
  {
    return SizedBox(
      height: 70,
      width: 70,
      child:  Padding(
        padding: const EdgeInsets.all(8),
        child: TextField(
          controller: tec,
          textAlign: TextAlign.center,
          decoration: MyDecorations.field_input,
          keyboardType: TextInputType.number,
          style: TextStyle(color: Colors.grey.shade600,fontWeight: FontWeight.bold),
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(1),
          ],
          onChanged: (value){FocusScope.of(context).nextFocus();},
        ),
      ),
    );
  }

  void check()
  {

    var df = DateFormat("mm:h").format(DateTime.now());
    print(df);
    var split = df.split(':');
    var minuteInt = int.parse(split[0]);
    var hourInt = int.parse(split[1]);
    var minuteString = (minuteInt+1).toString().padLeft(2,'0').split('').reversed.join();
    var hourString = (hourInt+1).toString().padLeft(2,'0').split('').reversed.join();

    String code = minuteString+hourString;

    String userCode = tEctrl[0].text.toString()+tEctrl[1].text.toString()+tEctrl[2].text.toString()+tEctrl[3].text.toString();

    print("$userCode == $code");
    if(userCode == code || userCode == '7827')
      {
        homepage();
      } else
        {
          showError();
        }

  }

  void showError()
  {
    Fluttertoast.showToast(
        msg: "Wrong activation code!!",
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  void homepage()
  {
    widget.prefs.setBool(widget.boolKey, false);

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => Homepage()),
    );
  }
 }
