import 'dart:io';
import 'package:flutter/material.dart';
import 'package:soqsoq/core/constants/app_colors.dart';
import 'package:soqsoq/core/viewmodels/auth_vm.dart';

import '../../../helpers/image_picker_helper.dart';
import '../../../helpers/navigate_to_helper.dart';
import '../../models/user_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? imagePath;
  AuthVM authVM = AuthVM();

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final userInfo = arguments is UserInfo ? arguments : null;
    final String? passedImage = userInfo?.imagePath;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,

        actions: [
          authVM.checkAuth()
              ? IconButton(
                  onPressed: () {
                    // NavigationHelper.navigateTo(context, "/splash");
                    authVM.logout();
                  },
                  icon: Icon(Icons.logout_outlined),
                )
              : IconButton(
                  onPressed: () {
                    NavigationHelper.navigateTo(context, "/login");
                  },
                  icon: Icon(Icons.login_outlined),
                ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: AppColors.backgroundColor,
            ),
          ),
        ],
        title: Text(
          "Yemen Sooq",
          style: TextStyle(color: AppColors.backgroundColor),
        ),
        iconTheme: IconThemeData(color: AppColors.backgroundColor),
        backgroundColor: AppColors.primaryColor,
      ),
      drawer: Drawer(

        child: Column(
          // padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(40),
                ),
              ),
              padding: EdgeInsets.fromLTRB(16, 40, 16, 16),
              child: Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      await _getImage();
                      // setState(() {});
                    },
                    child: imagePath != null
                        ? CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.file(
                                File(imagePath!),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          )
                        : passedImage != null
                        ? CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.white,
                            child: ClipOval(
                              child: Image.file(
                                File(passedImage),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),
                          )
                        : CircleAvatar(
                            radius: 35,
                            backgroundColor: AppColors.backgroundColor,
                            child: Icon(
                              Icons.account_circle,
                              size: 70,
                              color: AppColors.primaryColor,
                            ),
                          ),
                  ),
                  SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, ${userInfo?.userName ?? "There ^_^"}",
                        style: TextStyle(
                          color: AppColors.backgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        userInfo?.userEmail ?? 'No email is passed',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerListTail(icon: Icons.home, text: "Home"),
                  DrawerListTail(icon: Icons.shopping_cart, text: "My Cart"),
                  DrawerListTail(icon: Icons.favorite, text: "Favorites"),
                  DrawerListTail(icon: Icons.person, text: "Profile"),
                  InkWell(
                    onTap: () => NavigationHelper.navigateTo(context, '/login'),
                    child: DrawerListTail(icon: Icons.login, text: "Login"),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => NavigationHelper.navigateTo(context, '/login'),
              child: ListTile(
                leading: Icon(Icons.logout, color: Colors.red),
                title: Text("Logout", style: TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _getImage() async {
    final path = await pickImage(context);
    if (path != null) {
      setState(() {
        imagePath = path;
      });
    }
  }
}

class DrawerListTail extends StatelessWidget {
  final IconData icon;
  final String text;

  const DrawerListTail({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(text),
    );
  }
}
