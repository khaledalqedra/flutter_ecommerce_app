import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecommerce_app/utils/app_routes.dart';
import 'package:flutter_ecommerce_app/view_models/auth_cubit/auth_cubit.dart';
import 'package:flutter_ecommerce_app/views/widgets/main_botton.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<AuthCubit>(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: BlocConsumer<AuthCubit, AuthState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              current is AuthLoggedOut || current is AuthLogoutError,
          listener: (context, state) {
            if (state is AuthLoggedOut) {
              Navigator.of(context, rootNavigator: true)
                  .pushNamedAndRemoveUntil(
                AppRoutes.loginRoute,
                (route) => false,
              );
            } else if (state is AuthLogoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          // ✅ Fixed: rebuild on all relevant states
          buildWhen: (previous, current) =>
              current is AuthLoggingOut ||
              current is AuthDone ||
              current is AuthInitial,
          builder: (context, state) {
            if (state is AuthLoggingOut) {
              return MainBotton(
                text: 'Logout',
                isLoading: true,
              );
            }
            return MainBotton(
              text: 'Logout',
              onTap: () async => await cubit.logout(),
            );
          },
        ),
      ),
    );
  }
}