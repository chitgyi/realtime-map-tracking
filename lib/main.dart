import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'features/home/presentation/blocs/home.bloc.dart';
import 'features/home/presentation/blocs/location.picker.bloc.dart';
import 'features/home/presentation/pages/home.page.dart';

void main() async {
  configApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeBloc(),
          lazy: true,
        ),
        ChangeNotifierProvider(
          create: (_) => LocationPickerBloc(),
          lazy: true,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "RealTimeTracking",
        home: HomePage(),
      ),
    ),
  );
}

void configApp() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.white,
    ),
  );
}
