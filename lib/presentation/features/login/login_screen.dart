import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selling_app/config/theme.dart';
import 'package:selling_app/presentation/features/login/login_bloc.dart';
import 'package:selling_app/presentation/widgets/independent/block_header.dart';
import 'package:selling_app/presentation/widgets/independent/custom_button.dart';
import 'package:selling_app/presentation/widgets/independent/error_dialog.dart';
import 'package:selling_app/presentation/widgets/independent/input_field.dart';
import 'package:selling_app/utils/validator.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<OpenFlutterInputFieldState> emailKey = GlobalKey();
  final GlobalKey<OpenFlutterInputFieldState> passwordKey = GlobalKey();

  late double sizeBetween;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    sizeBetween = height / 20;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            ErrorDialog.showErrorDialog(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is LoginProcessingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  OpenFlutterBlockHeader(title: 'Sign in', width: width),
                  SizedBox(
                    height: sizeBetween,
                  ),
                  OpenFlutterInputField(
                    key: emailKey,
                    controller: emailController,
                    hint: 'Username',
                    validator: Validator.valueExists,
                    keyboard: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  OpenFlutterInputField(
                    key: passwordKey,
                    controller: passwordController,
                    hint: 'Password',
                    validator: Validator.valueExists,
                    keyboard: TextInputType.visiblePassword,
                    isPassword: true,
                  ),
                  SizedBox(
                    height: sizeBetween,
                  ),
                  OpenFlutterButton(
                      title: 'LOGIN', onPressed: _validateAndSend),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _validateAndSend() {
    if (emailKey.currentState?.validate() != null) {
      return;
    }
    if (passwordKey.currentState?.validate() != null) {
      return;
    }
    BlocProvider.of<LoginBloc>(context).add(
      LoginPressed(
        email: emailController.text,
        password: passwordController.text,
      ),
    );
  }
}
