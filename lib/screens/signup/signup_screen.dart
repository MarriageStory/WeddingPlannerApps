import 'package:flutter/material.dart';
import 'package:wedding_planner/model/register_model.dart';
import 'package:wedding_planner/screens/signup/components/body.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
