import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_app/data/repositories/abstract/product_repository.dart';
import 'package:selling_app/data/repositories/abstract/user_repository.dart';
import 'package:selling_app/presentation/features/authentication/authentication_bloc.dart';
import 'package:selling_app/presentation/features/login/login_bloc.dart';
import 'package:selling_app/presentation/features/login/login_screen.dart';
import 'package:selling_app/presentation/features/product/product_screen.dart';
import 'package:selling_app/presentation/features/product/products_bloc.dart';
import 'package:selling_app/presentation/features/splash_screen.dart';
import 'config/routes.dart';
import 'locator.dart' as service_locator;
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  service_locator.init();
  Bloc.observer = SimpleBlocDelegate();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) => AuthenticationBloc()..add(AppStarted()),
    child: MultiRepositoryProvider(providers: [
      RepositoryProvider<UserRepository>(create: (context) => sl()),
      RepositoryProvider<ProductRepository>(create: (context) => sl())
    ], child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Selling App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: _registerRoutes(),
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AppRoutes.signin: (context) => _buildSignInBloc(),
      AppRoutes.home: (context) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticated) {
              return _buildProductsBloc();
            } else if (state is Unauthenticated) {
              return _buildSignInBloc();
            } else {
              return const SplashScreen();
            }
          }),
    };
  }

  BlocProvider<ProductsBloc> _buildProductsBloc() {
    return BlocProvider<ProductsBloc>(
      create: (context) => ProductsBloc(
          productRepository: RepositoryProvider.of<ProductRepository>(context))
        ..add(FetchDataEvent()),
      child: const ProductScreen(),
    );
  }

  BlocProvider<LoginBloc> _buildSignInBloc() {
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(
        userRepository: RepositoryProvider.of<UserRepository>(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: const LoginScreen(),
    );
  }
}
