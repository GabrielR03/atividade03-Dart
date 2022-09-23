import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const List<String> userCondition = <String>[
  'Adulto saudável com cerca de 70 kg',
  'Crianças (a partir de 2 anos) e adolescentes',
  'Gestantes e lactantes',
  'Sensíveis a cafeína'
];

void main(){

  runApp(const MaterialApp(
    title: 'Caffeine Calculator',
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}
class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>{
  String _dropdownValue = userCondition.first;
  int _caffeine = 0;
  final TextEditingController _caffeineController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Inform your data";

  void _resetFields(){
    setState(() {
      _dropdownValue = userCondition.first;
      _caffeineController.text = "";
      _caffeine = 0;
      _formKey = GlobalKey<FormState>();
    });
  }
  void incrementCaffeine(int increment, String type){
    setState(() {
      if(type == "coffee"){
        if(increment == 1){
          _caffeine+=100;
        }else{
          _caffeine-=100;
        }
      }else if(type == "espresso"){
        if(increment == 1){
          _caffeine+=200;
        }else{
          _caffeine-=200;
        }
      }else if(type == "other"){
          _caffeine += int.parse(_caffeineController.text);
      }

      if(_caffeine < 0){
        _caffeine = 0;
      }

      if(_caffeine > 400){
        _infoText = "Your caffeine consumption is higher than the recommended";
      }else if(_dropdownValue == "Gestantes e lactantes" || _dropdownValue == "Sensíveis a cafeína" && _caffeine > 200){
        _infoText = "Your caffeine consumption is higher than the recommended";
      }else if(_dropdownValue == "Crianças (a partir de 2 anos) e adolescentes" && _caffeine > 100){
        _infoText = "Your caffeine consumption is higher than the recommended";
      }else{
        _infoText = "You are healthy!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Caffeine calculator"),
        centerTitle: true,
        backgroundColor: Colors.brown,
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.refresh), onPressed: _resetFields,),
        ],
      ),
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          const Image(
            image: AssetImage('images/wallpaper.png'),
            alignment: Alignment.center,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: Text(
                        "Caffeine until now: $_caffeine mg",
                        style: const TextStyle(color: Colors.white, fontSize: 30.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        color: Colors.black54, borderRadius: BorderRadius.circular(5),
                      ),
                      child: Theme(
                        data: Theme.of(context).copyWith(
                          canvasColor: Colors.black,
                        ),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _dropdownValue,
                          icon: const Icon(Icons.arrow_drop_down), iconSize: 40,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: userCondition.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Center(
                                child: Text(
                                  value,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? value) {
                            setState(() {
                              _dropdownValue = value!;
                            });
                            incrementCaffeine(0, "none");
                          },
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              elevation: 15,
                              shadowColor: Colors.brown,
                            ),
                            onPressed: (){
                              incrementCaffeine(1, "coffee");
                            },
                            child: const Text(
                              "+1 cup of coffee",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              elevation: 15,
                              shadowColor: Colors.brown,
                            ),
                            onPressed: (){
                              incrementCaffeine(-1, "coffee");
                            },
                            child: const Text(
                              "-1 cup of coffee",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              elevation: 15,
                              shadowColor: Colors.brown,
                            ),
                            onPressed: (){
                              incrementCaffeine(1, "espresso");
                            },
                            child: const Text(
                              "+1 cup of espresso",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          height: 50.0,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown,
                              elevation: 15,
                              shadowColor: Colors.brown,
                            ),
                            onPressed: (){
                              incrementCaffeine(-1, "espresso");
                            },
                            child: const Text(
                              "-1 cup of espresso",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Form(
                    key: _formKey,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 50.0,
                              width: 250,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                cursorColor: Colors.amberAccent,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.amberAccent),
                                  ),
                                  labelText: "Other (e.g.: Tea)",
                                  labelStyle: TextStyle(color: Colors.white),
                                  fillColor: Colors.black54,
                                  filled: true,
                                ),
                                textAlign: TextAlign.center,
                                style: const TextStyle(color: Colors.amberAccent, fontSize: 25.0),
                                controller: _caffeineController,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return "Nada foi inserido.";
                                  }
                                  if(int.parse(value!) <= 0 || int.parse(value!) > 10000){
                                    return "Inform a valid caffeine value!";
                                  }
                                },
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 50.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.brown,
                                  elevation: 15,
                                  shadowColor: Colors.brown,
                                ),
                                onPressed: (){
                                  if(_formKey.currentState!.validate()){
                                    incrementCaffeine(0, "other");
                                  }
                                },
                                child: const Text(
                                  "Add",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25.0
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Container(
                      height: 50.0,
                      child: Text(
                        _infoText,
                        style: const TextStyle(color: Colors.amberAccent, fontSize: 25.0, backgroundColor: Colors.black54),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
