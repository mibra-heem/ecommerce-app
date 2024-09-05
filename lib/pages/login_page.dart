import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../utils/dimensions.dart';
import '../widgets/app_text_field.dart';
import 'dashboard_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // app logo
              Container(
                height: Dimensions.screenHeight*0.25,
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 80,
                    backgroundImage: AssetImage(
                        "assets/image/food logo 1.png"
                    ),
                  ),
                ),
              ),
              //welcome
              Container(
                margin: EdgeInsets.only(left: Dimensions.width20),
                width: double.maxFinite,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello",
                      style: TextStyle(
                          fontSize: Dimensions.font20*3+Dimensions.font20/2,
                          fontWeight: FontWeight.bold
                      ),),
                    Text(
                      "Sign into your account",
                      style: TextStyle(
                          fontSize: Dimensions.font20,
                          color: Colors.grey[500]
                        //fontWeight: FontWeight.bold
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: Dimensions.height20,),

              AppTextField(icon: Icons.email,
                  hintText: "Email",
                  textController: emailController),
              SizedBox(height: Dimensions.height20,),
              AppTextField(icon: Icons.password,

                  hintText: "Password",
                  textController: passwordController,
                  isObscure: true),
              SizedBox(height: Dimensions.height20,),

              // tag line
              Row(
                children: [
                  Expanded(child: Container()),
                  RichText(
                      text: TextSpan(
                          text: "Forget Password?",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: Dimensions.font20,
                          )
                  )),
                  SizedBox(width: Dimensions.width20,),
                ],
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // Sign In
              GestureDetector(
                onTap: (){
                  // _login(authController);
                  Get.off(()=> DashBoardPage());
                },
                child: Container(
                  width: Dimensions.screenWidth/2,
                  height: Dimensions.screenHeight/13,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius30),
                      color: AppColor.secondaryColor
                  ),
                  child: Center(
                    child: Text("Sign In", style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    ), 
                    ),
                  ),
                ),
              ),
              SizedBox(height: Dimensions.screenHeight*0.05,),
              // sign up options
              RichText(text: TextSpan(
                  text: "Don\'t have an account?",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: Dimensions.font20,
                  ),
                  children: [
                    TextSpan(
                        recognizer: TapGestureRecognizer()..onTap=()=>Get.to((){}, transition: Transition.fade),
                        text: " Create",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColor.mainColor,
                          fontSize: Dimensions.font20,
                        )),
                  ]

              )
              ),


            ],
          ),
        ),
      );
  }
}
