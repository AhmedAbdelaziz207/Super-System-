import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:super_system/core/di/dependency_injection.dart';
import 'package:super_system/core/routing/app_routes.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'package:super_system/features/login/logic/login_cubit.dart';
import 'package:super_system/features/login/logic/login_states.dart';
import 'widgets/login_button.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';
import 'widgets/login_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentCodeController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _studentCodeController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginCubit>().emitLogin(
        studentCode: _studentCodeController.text,
        password: _passwordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt()),
      child: Scaffold(
      backgroundColor: AppColors.surface,
      body: Stack(
        children: [
          // Radial glow background
          Positioned(
            top: -80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 320.w,
                height: 320.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primary.withOpacity(0.15),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Main content
          SafeArea(child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 32.h),
                    const LoginLogo(),
                    SizedBox(height: 35.h),
                    const LoginHeader(),
                    SizedBox(height: 60.h),
                    // Card container
                    Container(
                      padding: EdgeInsets.all(24.w),
                      decoration: BoxDecoration(
                        color: AppColors.surface.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.outlineVariant,
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: LoginForm(
                        studentCodeController: _studentCodeController,
                        passwordController: _passwordController,
                      ),
                    ),
                    SizedBox(height: 40.h),
                    BlocConsumer<LoginCubit, LoginStates>(
                      listener: (context, state) {
                        if (state is LoginSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                          Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false);
                        } else if (state is LoginFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return LoginButton(
                          onPressed: () => _handleLogin(context),
                          isLoading: state is LoginLoading,
                        );
                      },
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ),
       )  ],
      ),
    ));
  }
}
