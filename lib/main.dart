import 'package:covid_tracker_app/app/repositories/data_repository.dart';
import 'package:covid_tracker_app/app/services/api.dart';
import 'package:covid_tracker_app/app/services/api_service.dart';
import 'package:covid_tracker_app/app/services/data_cache_service.dart';
import 'package:covid_tracker_app/ui/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'en_US';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (context) => DataRepository(
        apiService: APIService(API.sandbox()),
        dataCacheService: DataCacheService(
          sharedPreferences: sharedPreferences,
        ),
      ),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Color(0xFF101010),
          cardColor: Color(0xFF222222),
        ),
        home: Dashboard(),
      ),
    );
  }
}
