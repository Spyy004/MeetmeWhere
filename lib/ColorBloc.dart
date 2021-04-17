import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorChange extends Cubit<Color>
{
  ColorChange(initialState) : super(Colors.grey);
  void activate(){
    emit(Colors.green);
  }
  void deActivate()
  {
    emit(Colors.grey);
  }
}
