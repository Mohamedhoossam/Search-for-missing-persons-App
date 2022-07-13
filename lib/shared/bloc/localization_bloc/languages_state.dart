part of 'languages_bloc.dart';

 class LanguagesState  {
   late final Locale locale;
   LanguagesState({required this.locale});
   factory LanguagesState.initial() => LanguagesState(locale: Locale('en','Us'));
   LanguagesState copyWith({Locale? locale}) => LanguagesState(locale: locale ?? this.locale);

   @override
   List<Object> get props => [locale];

 }

