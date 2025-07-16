import 'package:ecommerce_app/src/profile/presentation/views/parts/profile_app_bar.dart';
import 'package:ecommerce_app/src/profile/presentation/views/parts/profile_body.dart';
import 'package:ecommerce_app/src/profile/presentation/views/parts/profile_header.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: const ProfileAppBar(),
        body: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              SizedBox(height: 20),
              // ProfileHeader(),
              SizedBox(height: 20),
              // ProfileBody(),
            ],
          ),
      ),
    );
  }
}
