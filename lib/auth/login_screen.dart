import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:machine_code/auth/auth_provider.dart';
import 'package:machine_code/utils/loading_dilaog_widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with LoadingDialogMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  bool _passVisibility = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password must contain both letters and numbers';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Login')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter valid email id',
                      prefixIcon: Icon(Icons.email),
                    ),
                    autofillHints: const [AutofillHints.email],
                    validator: _validateEmail,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_passwordFocusNode);
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: 'Enter password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _passVisibility = !_passVisibility;
                          });
                        },
                        child: Icon(_passVisibility
                            ? Icons.visibility_off
                            : Icons.visibility),
                      ),
                    ),
                    autofillHints: const [AutofillHints.newPassword],
                    obscureText: _passVisibility,
                    validator: _validatePassword,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          debugPrint('before showLoadingDialog');
                          showLoadingDialog(context);
                          try {
                            await Provider.of<
                                    AuthProvider>(context, listen: false)
                                .login(
                                    email:
                                        _emailController.text.trim().toString(),
                                    password: _passwordController.text
                                        .trim()
                                        .toString());
                            debugPrint('login successful');
                            hideLoadingDialog(context);
                            Navigator.pushReplacementNamed(context, '/agenda');
                          } catch (error) {
                            debugPrint('inside error');
                            hideLoadingDialog(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login failed')),
                            );
                          }
                        }
                      },
                      child: const Text("Login")),
                ],
              ),
            ),
          ),
        ));
  }
}
