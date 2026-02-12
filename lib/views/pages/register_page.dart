import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_app/utils/app_colors.dart';
import 'package:flutter_ecommerce_app/utils/app_routes.dart';
import 'package:flutter_ecommerce_app/views/widgets/label_with_textfield.dart';
import 'package:flutter_ecommerce_app/views/widgets/main_botton.dart';
import 'package:flutter_ecommerce_app/views/widgets/social_media_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Create Account',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Start shopping with create your account!',
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.grey,
                        ),
                  ),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                      label: 'username',
                      controller: usernameController,
                      prefixIcon: Icons.person,
                      icon: Icons.person,
                      hintText: 'Enter your username'),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                      label: 'Email',
                      controller: emailController,
                      prefixIcon: Icons.email,
                      icon: Icons.email,
                      hintText: 'Enter your email'),
                  const SizedBox(height: 24),
                  LabelWithTextField(
                      label: 'Password',
                      controller: passwordController,
                      prefixIcon: Icons.lock,
                      icon: Icons.password,
                      hintText: 'Enter your password',
                        obsecureText: true,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {},
                      ),
                  ),
                  const SizedBox(height: 40),
                  MainBotton(
                    text: 'Create Account',
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.of(context).pushNamed(AppRoutes.homeRoute); 
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('You have an account? Login'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Or using other methods',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                            color: AppColors.grey,
                          ),
                    ),
                  ),
                  SocialMediaButton(
                      text: 'Signup With Google', 
                      imgUrl: 'https://cdn1.iconfinder.com/data/icons/google-s-logo/150/Google_Icons-09-512.png', 
                      onTap: () {}),
                  const SizedBox(height: 16),
                  SocialMediaButton(
                      text: 'Signup With Facebook',
                      imgUrl: 'https://www.freepnglogos.com/uploads/facebook-logo-icon/facebook-logo-icon-facebook-logo-png-transparent-svg-vector-bie-supply-15.png',
                      onTap: () {}),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
