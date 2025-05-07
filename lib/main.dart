
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:movies_app/core/services/services_locator.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_bloc.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_event.dart';
import 'package:movies_app/settings/presentation/controller/app_setting_state.dart';
import 'package:movies_app/settings/presentation/screens/splash_screen.dart';
import 'package:movies_app/tv/data/models/tv_series_hive_model.dart';
import 'core/network/cache_helper.dart';
import 'core/utils/theme.dart';
import 'movies/data/models/movie_hive_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ServicesLocator().init();
  await dotenv.load();
  await CacheHelper.init();
  bool? dark=CacheHelper.getMode(key: "isDark");
  await Hive.initFlutter();
  Hive.registerAdapter(MovieHiveModelAdapter());
  Hive.registerAdapter(TvSeriesHiveModelAdapter());

  runApp( MyApp(dark));
}

class MyApp extends StatelessWidget {
  bool? isDark;
  MyApp(this.isDark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>sl<AppSettingBloc>()..add(ChangeModeEvent(mode: isDark))..add(const NavigateScreenEvent(index: 0)),
      child: BlocBuilder<AppSettingBloc,AppSettingState>(builder:(context,state)=>MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        theme:lightTheme(),
        darkTheme: darkTheme(),
        themeMode: state.mode?ThemeMode.dark:ThemeMode.light,
        home:AnimatedSplashScreen(backgroundColor:state.mode?Colors.black:Colors.white ,
          splash:
          Center(
            child:state.mode?LottieBuilder.asset(backgroundLoading: true,"assets/Animation5.json"): LottieBuilder.asset(backgroundLoading: true,"assets/Animation2.json"),
          ),splashIconSize: 400,
          nextScreen: const SplashScreen(),),// const SplashScreen(),
      ) ,)
    );
  }
}
