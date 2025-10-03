
import 'package:dio_methods_curd/framework/controller/profilecontroller/profile_controller.dart';
import 'package:dio_methods_curd/ui/home/home_screen.dart';
import 'package:dio_methods_curd/ui/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../framework/controller/homecontroller/home_controller_provider.dart';
import '../../../main.dart';
import '../theme/app_color.dart';


class CustomBottomNavigationBar extends ConsumerStatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  ConsumerState<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends ConsumerState<CustomBottomNavigationBar> {



  @override
  Widget build(BuildContext context) {

      return BottomNavigationBar(
        elevation: 10,
        backgroundColor: AppColor.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        selectedFontSize: 13,
        selectedItemColor: AppColor.orage,
        unselectedItemColor: AppColor.black,
        onTap: (index)async{
          selectedIndex = index;
          if(selectedIndex==0){
            await ref.read(apisOperationProvider.notifier).getAllResponseApi(false);
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return HomeScreen();
            }));
          }else{
            await ref.read(profileController.notifier).getUserInfo();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
              return ProfileScreen();
            }));
          }


          setState(() {
          });
        },
        items: [
          BottomNavigationBarItem(icon: selected(Icons.home_outlined,Icons.home,0,selectedIndex),label: "Home"),

          BottomNavigationBarItem(icon:selected(Icons.perm_identity,Icons.person,1,selectedIndex) ,label: "Profile"),
        ],
      );
    }
  }
  Widget selected(IconData icon,IconData icon1,int positionIndex ,int selectedIndex){

    return (positionIndex == selectedIndex) ?Container(
        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(color: Colors.black,width: 4)
            )
        ),

        child: Icon(icon1,color:AppColor.orage)):Container(padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),child: Icon( icon,color: AppColor.black));
  }
