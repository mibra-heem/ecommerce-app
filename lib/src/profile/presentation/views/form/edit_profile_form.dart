
import 'package:ecommerce_app/src/profile/presentation/views/widgets/edit_profile_form_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({
    required this.emailController,
    required this.nameController,
    required this.passwordController,
    required this.oldPasswordController,
    required this.bioController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController oldPasswordController;
  final TextEditingController bioController;

  @override
  Widget build(BuildContext context) {
    if(kDebugMode) print('................building..................');
    return Column(
      children: [
        EditProfileFormField(
          controller: nameController,
          title: 'FULL NAME',
          // hintText: context.currentUser!.name,
        ),
        const SizedBox(height: 30,),
        EditProfileFormField(
          title: 'EMAIL ADDRESS',
          controller: emailController,
          // hintText: context.currentUser!.email.obscureEmail,
        ),
        const SizedBox(height: 30,),
        EditProfileFormField(
          title: 'CURRENT PASSWORD',
          controller: oldPasswordController,
          hintText: '********',
        ),
        const SizedBox(height: 30,),
        StatefulBuilder(
          builder: (context, setState) {
            oldPasswordController.addListener(()=> setState((){}));
            return EditProfileFormField(
              title: 'PASSWORD',
              controller: passwordController,
              hintText: '********',
              readOnly: oldPasswordController.text.isEmpty,
            );
          },
        ),
        const SizedBox(height: 30,),
        EditProfileFormField(
          title: 'BIO', 
          controller: bioController,
          // hintText: context.currentUser!.bio,
          maxLength: 500,
          isTextArea: true,
        ),
      ],
    );
  }
}
