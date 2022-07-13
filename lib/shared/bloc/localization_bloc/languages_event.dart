part of 'languages_bloc.dart';

 abstract class LanguagesEvent  {

 
}
class LoadLanguage extends LanguagesEvent{
  late final Locale locale;
  LoadLanguage({required this.locale});
}
