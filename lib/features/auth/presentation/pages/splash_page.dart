import 'dart:async';

import 'package:coldana_flutter/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPage extends StatelessWidget {
  static const String routeName = '/splash';

  const SplashPage({Key? key}):super(key: key);

  @override
  Widget build(BuildContext context){
    //  context.read<AuthBloc>().add(CheckAuthStatusEvent());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 5), () {
        // After 5 seconds, trigger the authentication check
        context.read<AuthBloc>().add(CheckAuthStatusEvent());
      });
    });

     return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated){
            Navigator.of(context).pushReplacementNamed('/home');
          }else if (state is Unauthenticated) {
            Navigator.of(context).pushReplacementNamed('/login');
          }
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo.png', width: 150, height: 150,color: Colors.black,),
              const SizedBox(height: 24,),
              const Text(
                'Coldana',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 48,),
              const CircularProgressIndicator()
            ],
          ),
        ),
      ),
     );
  }
}