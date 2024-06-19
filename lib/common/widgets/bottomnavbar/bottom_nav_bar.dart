import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdp2/common/widgets/bottomnavbar/starting_controller.dart';
import 'package:sdp2/utils/global_colors.dart';

class CustomBottomNavBar extends StatelessWidget {
  CustomBottomNavBar({Key? key}) : super(key: key);

  final CustNavController custNavController = Get.put(CustNavController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: Obx(
            () => BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: GlobalColors.white,
          currentIndex: custNavController.currentIndex.value,
          onTap: (index) {
            custNavController.changePage(index);
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: GlobalColors.mainColor,
          unselectedItemColor: Colors.grey,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: custNavController.pageTitles[0],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: custNavController.pageTitles[1],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: custNavController.pageTitles[2],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: custNavController.pageTitles[3],
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: custNavController.pageTitles[4],
            ),
          ],
        ),
      ),
    );
  }
}
