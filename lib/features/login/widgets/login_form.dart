import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:super_system/core/theme/app_colors.dart';
import 'login_text_field.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController studentCodeController;
  final TextEditingController passwordController;

  const LoginForm({
    super.key,
    required this.studentCodeController,
    required this.passwordController,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Student Code Label
        Text(
          'كود الطالب',
          style: GoogleFonts.cairo  (
            color: AppColors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        LoginTextField(
          controller: widget.studentCodeController,
          hintText: 'أدخل كود الطالب',
          prefixIcon: Icons.person_outline_rounded,
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'من فضلك أدخل كود الطالب';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        // Password Label
        Text(
          'الرقم السري',
          style: GoogleFonts.cairo  (
            color: AppColors.white,
            fontSize: 13.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        LoginTextField(
          controller: widget.passwordController,
          hintText: '••••••••',
          prefixIcon: Icons.lock_outline_rounded,
          obscureText: _obscurePassword,
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.onSurfaceVariant,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _obscurePassword = !_obscurePassword;
              });
            },
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'من فضلك أدخل الرقم السري';
            }
            return null;
          },
        ),
      ],
    );
  }
}
