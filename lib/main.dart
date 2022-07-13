import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:newnew/missing_layout/layout.dart';
import 'package:newnew/modules/onboarding_screen.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/app_localization.dart';
import 'package:newnew/shared/bloc/bloc_observer.dart';
import 'package:newnew/shared/bloc/localization_bloc/languages_bloc.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/bloc/map_cubit/map_cubit.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/network/dio.dart';
import 'package:newnew/shared/style/colors.dart';
import 'package:newnew/shared/style/themes.dart';
import 'package:splash_screen_view/SplashScreenView.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  DioHelper.init();
  await CacheHelper.init();

  bool onBoarding =CacheHelper.getData(key: 'onboarding') ?? false;
  token=CacheHelper.getData(key: 'token')??'';
  print(token);
  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
  print(isDark);

  late Widget widget;

  if(onBoarding){
    if(token.isNotEmpty){
      widget = LayoutScreen();

    }else{
      widget = LoginScreen();
    }
  }else{
    widget = const OnboardingScreen();
  }

  BlocOverrides.runZoned(
        () {
      runApp( MyApp(widget, isDark:isDark,));
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  Widget widget;
  final bool isDark ;
  MyApp(this.widget, {Key? key, required this.isDark}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Widget splash=SplashScreenView(
      navigateRoute: widget,
      duration: 3000,
      imageSize: 300,
      pageRouteTransition:PageRouteTransition.CupertinoPageRoute ,
      imageSrc: "assets/images/splash.gif",
      text: "Search For Me",
      textType: TextType.ColorizeAnimationText,
      textStyle:  TextStyle(
        fontSize: 30.0,
        color: defaultColor ,

      ),
      colors: const[
        Colors.purple,
        Colors.blue,
        Colors.yellow,
        Colors.red,
      ],
      backgroundColor: Colors.white,
    );

    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginCubit(),),
   //   BlocProvider<LanguagesBloc>(create: (context) => LanguagesBloc(LanguagesState.initial()),),
      
      BlocProvider(create: (context) => MapCubit(),),
      BlocProvider(create: (context) => MainCubit()..checkInterNet()..changeAppMode(fromShared: isDark)..getAllPerson()..getAllThings()..getOldTenPerson()..getUserMissingCase()..getUserSearchForFamilyCase()..getUserThingsCase()..getProfile()..counterFound()..getAllAdmin()
      ),

    ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
             debugShowCheckedModeBanner: false,
            // localizationsDelegates: [
            //   AppLocalization.delegate,
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            //   GlobalCupertinoLocalizations.delegate,
            // ],
            // supportedLocales: [
            //   Locale('en', 'Us'), // English, no country code
            //   Locale('ar', ''), // Spanish, no country code
            // ],
            home: splash,
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: MainCubit.get(context).isDark ?ThemeMode.dark : ThemeMode.light,

          );
        },
      ),
    );
  }
}