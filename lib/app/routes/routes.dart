import 'package:firebase_bloc/app/bloc/app_bloc.dart';
import 'package:firebase_bloc/home/view/home_page.dart';
import 'package:firebase_bloc/login/view/login_page.dart';
import 'package:flutter/widgets.dart';

List<Page<dynamic>> onGenerateAppViewPages(
  AppStatus state,
  List<Page<dynamic>> pages,
) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
