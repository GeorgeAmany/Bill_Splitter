
import 'package:flutter/material.dart';

class BillSplitter extends StatefulWidget {
  @override
  _BillSplitterState createState() => _BillSplitterState();
}

class _BillSplitterState extends State<BillSplitter> {
  int _tipPercentage = 0 ; //tipPercentage
  int _personCounter = 1;  // splitBY
  double _billAmount = 0.0;// billAmount

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // child: Image.asset('assets/images/cover.png')
      appBar: AppBar(
          title: Text('Bill Splitter',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600)),
          backgroundColor: Colors.purpleAccent.shade100
      ),

      body:Container(
            decoration: BoxDecoration(
            image: DecorationImage(
            image: AssetImage("assets/images/cover.png"),
            fit: BoxFit.cover),
            ),

          child : ListView(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.all(20.3),
            children: [
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.shade100,
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Total Per Person',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                      Text('\$${calculateTotalPerPerson(_billAmount , _personCounter , _tipPercentage)}',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.purpleAccent.shade100,
                  border: Border.all(
                    color: Colors.purpleAccent.shade100,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(13.0),
                ),
                child: Column(
                  children: [
                    TextField(
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixText: 'Bill Amount : ',
                        prefixIcon: Icon(Icons.attach_money),
                      ),
                      onChanged: (String value) {
                        try {
                          _billAmount = double.parse(value);
                        } catch (exception) {
                          //return
                          _billAmount = 0.0;
                        }
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Split',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                        Row(
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_personCounter > 1) {
                                      _personCounter--;
                                    } else {
                                      // do nothing
                                    }
                                  });
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  margin: EdgeInsets.all(10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(7.0),
                                    color: Colors.white,
                                  ),
                                  child: Center(
                                    child: Text(
                                      '-',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 50.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              '$_personCounter',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _personCounter++;
                                });
                              },
                              child: Container(
                                width: 40.0,
                                height: 40.0,
                                margin: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(7.0)),
                                child: Center(
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),

                    //Tip
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Tip',
                          style: TextStyle(
                            fontSize:18,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '\$${(calculateTotalTip(_billAmount, _personCounter, _tipPercentage )).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),

                    //slider
                    Column(
                      children: [
                        Text(
                          '$_tipPercentage%',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        Slider(
                            min: 0,
                            max: 100,
                            activeColor: Colors.white,
                            inactiveColor: Colors.purple.shade100,
                            divisions: 10,
                            value: _tipPercentage.toDouble(),
                            onChanged: (double newvalue) {
                              setState(() {
                                _tipPercentage= newvalue.round();
                              });
                            }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
  calculateTotalPerPerson( double billAmount , int splitBy , int tipPercentage){
    var totalPerPerson = ( calculateTotalTip( billAmount ,splitBy,tipPercentage  ) + billAmount) / splitBy ;
    return totalPerPerson.toStringAsFixed(2);
  }

  calculateTotalTip( double billAmount , int splitBy, int tipPercentage  ){
    double totalTip = 0.0 ;
    if (billAmount < 0 || billAmount.toString().isEmpty || billAmount==null){
      print('Please Enter Bill Amount');
    }else{
      totalTip= (billAmount * tipPercentage) / 100 ;
    }
    return totalTip ;
  }



}
