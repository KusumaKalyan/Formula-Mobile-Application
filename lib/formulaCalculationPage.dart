import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'formula_classes/ClassicPhysics.dart';

ClassicPhysics classicPhysics = new ClassicPhysics();

List callbacks = [
  {
    "ClassicPhysics.force": classicPhysics.force,
    "ClassicPhysics.ke": classicPhysics.kineticEnergy,
    "ClassicPhysics.pe": classicPhysics.potentialEnergy,
    "ClassicPhysics.pythagoreanTheory": classicPhysics.pythagoreanTheorem
  },
];

// ignore: must_be_immutable
class FormulaCalculationPage extends StatefulWidget {
  dynamic data;
  String name;

  FormulaCalculationPage(_data, _name) {
    data = _data;
    name = _name;
  }

  @override
  _FormulaCalculationPageState createState() => _FormulaCalculationPageState();
}

class _FormulaCalculationPageState extends State<FormulaCalculationPage> {
  Size size;

  Map<String, TextEditingController> parametersList = {};

  BuildContext mContext;

  bool atStart = true;

  dynamic answer = '?';

  checkEveryParameterFieldFilled() {
    for(dynamic i in parametersList.entries) {
      if(i.value.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  calculateFormula () async{
    if(checkEveryParameterFieldFilled()) {
      try {
        double val = Function.apply(callbacks[0][widget.data['function']], [parametersList]);
        setState(() {
          answer = val;
        });
      }
      catch(e) {
        print(e);
        showDialog(
            context: mContext,
            builder: (_) => AlertDialog(
              title: Center(
                  child: Text('Parameters data is INVALID',
                    style: TextStyle(color: Colors.white),
                  )
              ),
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              elevation: 0.0,)
        );
      }
    }
    else {
      showDialog(
        context: mContext,
          builder: (_) => AlertDialog(
            title: Center(
                      child: Text('Fill Every Parameter',
                        style: TextStyle(color: Colors.white),
                      )
                  ),
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0.0,)
      );
    }
  }

  calculateButton() {
    return RaisedButton(onPressed: calculateFormula, color: Color.fromARGB(255,232,232,232),child: Text('Calculate'),);
  }

  addParameterToList(paramData, paramName) {
    if(atStart) {
      if(paramData['hasError']) {
        if(paramData['hasDefaultValue']) {
          parametersList[paramName.toString()] = new TextEditingController(text: paramData['defaultValue'].toString());
        }
        else {
          parametersList[paramName.toString()] = new TextEditingController();
        }
        parametersList[paramName.toString()+'e'] = new TextEditingController(text: paramData['defaultError'].toString());
      }
      else {
        if(paramData['hasDefaultValue']) {
          parametersList[paramName.toString()] = new TextEditingController(text: paramData['defaultValue'].toString());
        }
        else {
          parametersList[paramName.toString()] = new TextEditingController();
        }
      }
    }
  }

  formulaWidgetReturner() {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
      child: Text(widget.data['formula'],
        style: TextStyle(color: Color.fromARGB(255,246,214,173), fontSize: size.width * 0.075),
      ),
    );
  }

  unitsWidgetReturner() {
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
      child: Text('Units: '+widget.data['units'],
        style: TextStyle(color: Color.fromARGB(190,246,214,173), fontSize: size.width * 0.05),
      ),
    );
  }

  parameterInputBoxReturner(paramData, paramName) {
    addParameterToList(paramData, paramName);
    if(paramData['hasError']) {
      return Column(
        children: [
          Row(
            children: [
              Text(' '+paramName+' = ',
                style: TextStyle(color: Color.fromARGB(255,232,232,232), fontSize: size.width * 0.07),),
              Text(' '),
              Expanded(
                flex: 9,
                child: TextField(
                  controller: parametersList[paramName],
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white30),
                      hintText: paramData['name']+' in '+paramData['units'],
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  ),
                ),
              ),
              Text('   ')
            ],
          ),
          // Text(' '),
          Row(
            children: [
              Text(' '+paramName+'e = ',
                style: TextStyle(color: Color.fromARGB(255,232,232,232), fontSize: size.width * 0.07,),),
              Text(' '),
              Expanded(
                flex: 8,
                child: TextField(
                  controller: parametersList[paramName+'e'],
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      hintStyle: TextStyle(color: Colors.white30),
                      hintText: paramData['name']+' error in '+paramData['units'],
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                  ),
                ),
              ),
              Text('   ')
            ],
          ),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            Text(' '+paramName+' = ',
              style: TextStyle(color: Color.fromARGB(255,232,232,232), fontSize: size.width * 0.07),),
            Text(' '),
            Expanded(
              flex: 9,
              child: TextField(
                controller: parametersList[paramName],
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintStyle: TextStyle(color: Colors.white30),
                    hintText: paramData['name']+' in '+paramData['units'],
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white))
                ),
              ),
            ),
            Text('   ')
          ],
        ),
      ],
    );
  }

  parametersWidgetReturner() {
      List<String> params = widget.data['parameters'].keys.toList();
      return Expanded(
        child:
        Container(
          child: ListView.builder(itemCount: params.length+1,itemBuilder: (BuildContext context, int index){
            if(params.length == index) {
              atStart = false;
              return Text(' ', style: TextStyle(fontSize: 0.01),);
            }
            return parameterInputBoxReturner(widget.data['parameters'][params[index]], params[index]);
          }),
        ),
      );
  }

  answerWidget() {
    if(atStart) {
      return Padding(
        padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
        child: Text('Value = ?',
          style: TextStyle(color: Color.fromARGB(150,232,232,232), fontSize: size.width * 0.07),
        ),
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: size.height * 0.01, bottom: size.height * 0.01),
      child: Text('Value = '+answer.toString(),
        style: TextStyle(color: Color.fromARGB(255,232,232,232), fontSize: size.width * 0.07),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    size =  MediaQuery.of(context).size;
    mContext = context;
      return Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.amberAccent,
                ),
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
          ),
          backgroundColor: Color.fromARGB(255,33,33,33),
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return false;
            },
            child: Container(
              child: Column(
                children: [
                  formulaWidgetReturner(),
                  unitsWidgetReturner(),
                  answerWidget(),
                  calculateButton(),
                  parametersWidgetReturner(),
                ],
              ),
            ),
          )
      );
    }
}
