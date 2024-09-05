import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../controller/detail_controller.dart';
import '../utils/dimensions.dart';

class SeatBookingPage extends StatelessWidget {
  final int pageId;
  SeatBookingPage({super.key, required this.pageId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Book Seat", style: TextStyle(
          color: Colors.white
        ),),
        centerTitle: true,
        backgroundColor: AppColor.mainColor,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: Dimensions.height20, right: Dimensions.height15, left: Dimensions.height15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Male", style: TextStyle(
            color: AppColor.mainColor,
            fontSize: Dimensions.font20,
            fontWeight: FontWeight.bold
                    ),),
                Text("Female", style: TextStyle(
            color: AppColor.secondaryColor,
            fontSize: Dimensions.font20,
            fontWeight: FontWeight.bold
                    ),),
              ],
            ),
          ),
          SizedBox(
            height: Dimensions.height10,
          ),
          Divider(
            thickness: 2,
          ),
          Container(
            height: 500,
            child: GetBuilder<DetailController>(builder: (detailController){
              return GridView.builder(
                primary: true,
                shrinkWrap: true,
                // padding: EdgeInsets.all(20),
                // scrollDirection: Axis.horizontal,
                itemCount: 50,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 4/2.8,
                  // crossAxisSpacing: 180,
                  // mainAxisSpacing: 0,
                  mainAxisExtent: 50
                ),
                itemBuilder: (context, index){
            return GestureDetector(
              onTap: (){
                detailController.setSize(pageId, index + 1);
              },
              child: Icon(
                                  index + 1 != detailController.shoeSize[pageId]
                                      ? Icons.person_2_outlined
                                      : Icons.person_2,
                                  size: Dimensions.font26 * 1.5,
                                  color:
                                      index + 1 != detailController.shoeSize[pageId]
                                          ? AppColor.textColor2
                                          : Colors.black,
                                ),
            );
          });
            }
          ))
        ],
      ),
    );
  }
}