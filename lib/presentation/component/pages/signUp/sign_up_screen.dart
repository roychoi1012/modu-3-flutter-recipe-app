import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/presentation/component/pages/home/main_screen.dart';
import 'package:recipe_app/presentation/component/widgets/big_button.dart';
import 'package:recipe_app/presentation/component/widgets/custom_text_field.dart';
import 'package:recipe_app/ui/app_text_styles.dart';
import 'package:recipe_app/ui/color_style.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              Text(
                'Create an account',
                style: AppTextStyles.largeBold(color: ColorStyle.black1),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: 200,
                height: 44,
                child: Text(
                  'Let’s help you set up your account, it won’t take long.',
                  style: AppTextStyles.extraSmallRegular(color: ColorStyle.black2),
                  maxLines: 2, // 최대 2줄까지 줄바꿈 허용
                  softWrap: true, // 자동 줄바꿈 허용
                  overflow: TextOverflow.ellipsis, // 넘칠 경우 말줄임표로 처리
                ),
              ),

              const SizedBox(height: 57),

              // Email 입력
              Text(
                'Email',
                style: AppTextStyles.smallRegular(color: ColorStyle.black2),
              ),
              const SizedBox(height: 8),
              CustomTextField(hintText: 'Enter Email'),
              const SizedBox(height: 30),

              // Password 입력
              Text(
                'Enter Password',
                style: AppTextStyles.smallRegular(color: ColorStyle.black2),
              ),
              const SizedBox(height: 8),
              CustomTextField(hintText: 'Enter Password'),
              const SizedBox(height: 20),

              // Sign Up 버튼
              BigButton(
                text: 'Sign Up',
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const MainScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
