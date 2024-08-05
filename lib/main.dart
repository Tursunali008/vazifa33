import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vazifa33/data/repostory/cart_repostory.dart';
import 'package:vazifa33/firebase_options.dart';
import 'package:vazifa33/logic/bloc/cart_bloc.dart';
import 'package:vazifa33/services/cart_service.dart';
import 'package:vazifa33/ui/screen/home_screen.dart';
import 'package:vazifa33/ui/screen/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final cartsRepository =
      CartsRepository(firebaseCartService: FirbaseCartService());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return CartBloc(cartsRepository: cartsRepository);
          },
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}