import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc_observer.dart';
import 'data/portfolio_data.dart';
import 'portfolio_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PortfolioData.load();
  Bloc.observer = MyBlocObserver();
  runApp(const PortfolioApp());
}
