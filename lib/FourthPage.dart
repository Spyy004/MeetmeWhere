import 'package:demo1/DestinationFetcher.dart';
import 'package:demo1/FifthPage.dart';
import 'package:demo1/variables.dart';
import 'package:flutter/material.dart';

class Fourth extends StatefulWidget {
  @override
  _FourthState createState() => _FourthState();
}

class _FourthState extends State<Fourth> {
  @override
  void initState() {
    // TODO: implement initState
    meetPoint= fetchDestination();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Padding(
      padding: const EdgeInsets.only(top:80.0,left: 10,right: 10),
      child: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Text('You can visit...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              Expanded(
                child: FutureBuilder(
                  future: meetPoint,
                  builder: (context, snapshot){
                    if(snapshot.hasData)
                      {
                        return ListView.builder(
                        itemCount: snapshot.data.results.length,
                          itemBuilder: (BuildContext context, int index){
                          return ListTile(
                            autofocus: true,
                            onTap: (){
                              placeID=snapshot.data.results[index].placeId;
                              fetchDestination();
                              Navigator.push(context, MaterialPageRoute(builder:(context) =>placeDetails()));
                            },
                            title: Text(snapshot.data.results[index].name),
                            selectedTileColor: Colors.green,
                            trailing: Text('${snapshot.data.results[index].rating}'),
                            subtitle: Text('Total No of Ratings:${snapshot.data.results[index].userRatingsTotal.toString()}'),
                          );
                          },
                        );

                      }
                    else if(snapshot.hasError)
                      {
                        return Text(snapshot.error.toString());
                      }
                    else
                      {
                        return Center(child: CircularProgressIndicator());
                      }
                },

                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
