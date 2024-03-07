import 'package:flutter/material.dart';
import '../services/splash_services.dart';
import '../util/image_assets.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
} 
 

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SplashServices().checkAuthentication(context);
    // TODO: implement initState
    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container( 
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration( 
          image: DecorationImage( 
            fit: BoxFit.cover,
            image: AssetImage(ImageAssets.ic_splash_screen)
          )
        ),
      ),
    );
  }
}