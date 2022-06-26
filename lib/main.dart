import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newnew/missing_layout/layout.dart';
import 'package:newnew/modules/onboarding_screen.dart';
import 'package:newnew/modules/user_authentication/login_screen.dart';
import 'package:newnew/shared/bloc/bloc_observer.dart';
import 'package:newnew/shared/bloc/login_register_cubit/login_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_cubit.dart';
import 'package:newnew/shared/bloc/main_cubit/main_state.dart';
import 'package:newnew/shared/constant.dart';
import 'package:newnew/shared/local/share_pereference.dart';
import 'package:newnew/shared/network/dio.dart';
import 'package:newnew/shared/style/themes.dart';


void main()async{

  WidgetsFlutterBinding.ensureInitialized();
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
    return MultiBlocProvider(providers: [
      BlocProvider(create: (context) => LoginCubit(),),
      BlocProvider(create: (context) => MainCubit()..checkInterNet()..changeAppMode(fromShared: isDark)..getAllPerson()..getAllThings()..getOldTenPerson()..getUserMissingCase()..getUserSearchForFamilyCase()..getUserThingsCase()..getProfile()..counterFound()..getAllAdmin()
      ),

    ],
      child: BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {

          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: widget,
            theme: lightTheme,
            darkTheme:darkTheme,
            themeMode: MainCubit.get(context).isDark ?ThemeMode.dark : ThemeMode.light,

          );
        },
      ),
    );
  }
}