import 'package:demo1/DestinationFetcher.dart';
import 'package:demo1/FourthPage.dart';
import 'package:demo1/variables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'ColorBloc.dart';
import 'package:item_selector/item_selector.dart';

class SecondPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (_)=>ColorChange(Colors.grey),
    child: MeetUpPage(),);
  }
}

class MeetUpPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MeetUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body:
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    height: double.infinity,
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                              "Select the type of place where you wish to meet(can select only one)",style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),),
                        ),
                        ItemSelectionController(
                          child: ListView.builder(
                            itemCount: interestPoints.length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder:(BuildContext context, int index){
                              return BlocBuilder<ColorChange,Color>(
                                builder: (context,buttonColor){
                                  return ItemSelectionBuilder(index: index, builder: (BuildContext context,int index1, bool selected){
                                    selectedInterestPoint=interestPoints[index1];
                                    return Text(interestPoints[index],style:TextStyle(color:selected?Colors.green:Colors.grey,fontSize:30 ),);
                                  });
                                },
                              );
                            }
                          ),
                        ),
                        ElevatedButton(onPressed: (){
                          request_count=request_count+1;
                          fetchDestination();
                          print(latsum);
                          print(longsum);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Fourth()));
                        }, child: Text("Save and Next"))
                      ],
                    )
                ),
              ),
          );

  }
}
