import 'package:demo1/Services/DestinationFetcher.dart';
import 'package:demo1/Screens/FourthPage.dart';
import 'package:demo1/Constants/variablesFunctions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Models/ColorBloc.dart';
import 'package:sizer/sizer.dart';
import 'package:item_selector/item_selector.dart';

//Place Selector Page

class SecondPages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ColorChange(Colors.grey),
      child: MeetUpPage(),
    );
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
        backgroundColor: Color(0xffEDC7B7),
      body: Padding(
        padding: EdgeInsets.only(left: 2.0.w, top: 10.0.h),
        child: Column(
          children: [
            HeaderText(),
            ItemSelectorList(), /// A List of types of places user can visit.
            NextPageButton()
          ],
        ),
      ),
    );
  }
}

class HeaderText extends StatelessWidget {
  const HeaderText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.0.w, top: 10.0.h),
      child: Text(
        "Select the type of place where you wish to meet",
        style: TextStyle(
          fontSize: 13.0.sp,
          fontWeight: FontWeight.bold,
          color: Color(0xff123c69)
        ),
      ),
    );
  }
}

class ItemSelectorList extends StatelessWidget {
  const ItemSelectorList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ItemSelectionController(
      child: ListView.builder(
          itemCount: interestPoints.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return BlocBuilder<ColorChange, Color>(
              builder: (context, buttonColor) {
                return ItemSelectionBuilder(
                    index: index,
                    builder: (BuildContext context, int index1,
                        bool selected) {
                      selectedInterestPoint = interestPoints[index1];
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(placesIcon[index],color: Color(0xff123c69),),
                          SizedBox(width: 5.0.w,),
                          Text(
                            interestPoints[index],
                            style: TextStyle(
                                color:
                                    selected ? Colors.green : Color(0xffac3b61),
                                fontSize: 8.0.w,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    });
              },
            );
          }),
    );
  }
}

class NextPageButton extends StatelessWidget {
  const NextPageButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Color(0xffedc7b9)),
        ),
        onPressed: () {
          request_count = request_count + 1;
          fetchDestination(); /// A function to fetch the places around the centroid.
          print(latsum);
          print(longsum);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Fourth()));
        },
        child: Text("Save and Next",style: TextStyle(color:Color(0xffac3b61) ),));
  }
}
