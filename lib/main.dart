import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:grape_master/screens/Home/demo_langvangefiles.dart';
import 'package:grape_master/screens/Home/home_controller.dart';
import 'package:grape_master/screens/address/address_controller.dart';
import 'package:grape_master/screens/auth/LocalString.dart';
import 'package:grape_master/screens/live/video_controller.dart';
import 'package:grape_master/screens/post/post_controller.dart';
import 'package:grape_master/screens/registerplot/plot_controller.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/faq/faq_controller.dart';
import 'package:grape_master/screens/registerplot/plot_wegits/faq/faq_screen.dart';
import 'package:grape_master/screens/splashScreen.dart';
import 'package:grape_master/util/prefs/PreferencesKey.dart';
import 'package:grape_master/util/prefs/PreferencesKey.dart';
import 'package:grape_master/util/prefs/app_preference.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await initLanguage();
  await AppPreference().initialAppPreference();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
}

String? languageCode;
String? countryCode;
String cuntrycode = AppPreference().getString(PreferencesKey.languageid);

Future<void> initLanguage() async {
  // SharedPreferences prefs = await SharedPreferences.getInstance();
  // languageCode = prefs.getString('languageCode') ?? 'mr';
  // countryCode = prefs.getString('countryCode') ?? 'IN';
  // log(languageCode.toString());

  Locale initialLocale = Locale("mr", "IN");

  // Set the initial locale
  Get.updateLocale(initialLocale);
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
        OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
        OneSignal.initialize('70e9447b-2b3e-4359-ab42-210a75e0bb30'); 
       OneSignal.Notifications.requestPermission(true).then((value) {
      print('signal value: $value');
    });
    });

  }

  //  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<postCnt>(create: (_) => postCnt()),
        ChangeNotifierProvider<plotcnt>(create: (_) => plotcnt()),
        ChangeNotifierProvider<faqcnt>(create: (_) => faqcnt()),
        ChangeNotifierProvider<AddressController>(
            create: (_) => AddressController()),
        ChangeNotifierProvider<HomeController>(create: (_) => HomeController()),
        ChangeNotifierProvider<Videocnt>(create: (_) => Videocnt()),
      ],
      child: GetMaterialApp(
        translations: Messages(),
        locale: cuntrycode == 4 ? Locale('kn,IN') : Locale('mr,IN'),
        title: 'Grape Master',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          //  useMaterial3: true,
        ),
        home: SplashScreen(),
        fallbackLocale: Locale("mr", "IN"),
      ),
    );
  }
}
