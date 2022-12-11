import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_maps/MyBlocObserver.dart';
import 'package:flutter_maps/app_router.dart';
import 'package:flutter_maps/constnats/strings.dart';
import 'package:flutter_maps/firebase_options.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


late String? initialRoute ;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();

FirebaseAuth.instance.authStateChanges().listen((user) {

  if(user == null)
  {
    initialRoute = loginScreen;
  }else 
  {
    initialRoute = mapScreen;
  }
 });




  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  
  const MyApp({super.key, required this.appRouter});
  
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: appRouter.generateRoute,
        initialRoute: initialRoute,
      );
      },
    );
  }
}

