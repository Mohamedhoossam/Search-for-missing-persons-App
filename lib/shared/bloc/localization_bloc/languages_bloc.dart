import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:newnew/shared/bloc/localization_bloc/languages_bloc.dart';
import 'package:newnew/shared/bloc/localization_bloc/languages_bloc.dart';
import 'package:newnew/shared/bloc/localization_bloc/languages_bloc.dart';
import 'package:newnew/shared/bloc/localization_bloc/languages_bloc.dart';

part 'languages_event.dart';
part 'languages_state.dart';

class LanguagesBloc extends Bloc<LanguagesEvent, LanguagesState> {
  LanguagesBloc(LanguagesState initialState) : super(initialState) ;
  LanguagesState  get initialState => LanguagesState.initial();
  Stream<LanguagesState> mapEventToState(
      LanguagesEvent event,
      )async*{
    if(event is LoadLanguage){
      yield LanguagesState(locale: event.locale);
    }
  }


}
