import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soqsoq/helpers/navigate_to_helper.dart';

import '../../models/user_info.dart';
import '../components/app_textformField.dart';
import 'package:soqsoq/helpers/image_picker_helper.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserInfo userInfo = UserInfo();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userName = TextEditingController();
  String? SelectedCountry;
  String? SelectedCity;
  String? selectedGender = "male";
  String? imagePath;
  Color teal = const Color(0xFF3A7685);
  Color cyan = const Color(0xFFB0E1DA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => NavigationHelper.navigateTo(context, "/home"),
        ),
        backgroundColor: const Color(0xFF3A7685),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  height: 150,
                  child: InkWell(
                    onTap: () async {
                      await _getImage();
                    },
                    child: imagePath == null
                        ? const CircleAvatar(
                      radius: 150,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.account_circle,
                        size: 150,
                        color: Color(0xFF3A7685),
                      ),
                    )
                        : CircleAvatar(
                      radius: 100,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.file(
                          File(imagePath!),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: AppTextformfield(
                        controller: _userName,
                        label: "Name",
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: AppTextformfield(label: "Surname")),
                  ],
                ),
                const SizedBox(height: 10),
                AppTextformfield(
                  controller: _emailController,
                  label: "Email",
                  isEmail: true,
                ),
                const SizedBox(height: 10),
                 AppTextformfield(label: "Password", isPwd: true),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      width: 110,
                      height: 60,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: DropdownButton(
                        underline: const SizedBox(),
                        value: SelectedCountry,
                        isExpanded: true,
                        hint: const Text("Country"),
                        items: const [
                          DropdownMenuItem(value: "YE", child: Text("+967")),
                          DropdownMenuItem(value: "SA", child: Text("+966")),
                          DropdownMenuItem(value: "US", child: Text("+1")),
                          DropdownMenuItem(value: "UK", child: Text("+2")),
                          DropdownMenuItem(value: "UA", child: Text("+961")),
                        ],
                        onChanged: (x) {
                          SelectedCountry = x!;
                          setState(() {});
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: AppTextformfield(
                        label: "Number",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Gender: ", style: TextStyle(fontSize: 16)),
                      Radio<String>(
                        value: 'male',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const Text("Male"),
                      const SizedBox(width: 20),
                      Radio<String>(
                        value: 'female',
                        groupValue: selectedGender,
                        onChanged: (String? value) {
                          setState(() {
                            selectedGender = value;
                          });
                        },
                      ),
                      const Text("Female"),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                 AppTextformfield(label: "Bate of Birth", isDoB: true),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: 60,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButton(
                    value: SelectedCity,
                    underline: const SizedBox(),
                    isExpanded: true,
                    hint: const Text("Select your city..."),
                    items: const [
                      DropdownMenuItem(value: "sa", child: Text("Sanaa")),
                      DropdownMenuItem(value: "ad", child: Text("Aden")),
                      DropdownMenuItem(value: "ta", child: Text("Taiz")),
                      DropdownMenuItem(value: "ib", child: Text("Ibb")),
                      DropdownMenuItem(value: "ha", child: Text("Hadhramaot")),
                    ],
                    onChanged: (x) {
                      SelectedCity = x!;
                      setState(() {});
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_emailController.text.trim().isEmpty ||
                        _userName.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          showCloseIcon: true,
                          content: Text("Please enter your name and email ^_^"),
                        ),
                      );
                      return;
                    } else {
                      userInfo.userName = _userName.text.trim();
                      userInfo.userEmail = _emailController.text.trim();
                      userInfo.imagePath = imagePath;
                      NavigationHelper.navigateTo(
                        context,
                        "/splash",
                        userInfo: userInfo,
                      );
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(teal),
                    fixedSize: MaterialStateProperty.all<Size>(const Size(120, 45)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  child: const Text("Register"),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    InkWell(
                      onTap: () {
                        NavigationHelper.navigateTo(context, "/login");
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: teal,
                        ),
                      ),
                    ),
                  ],)
              ],
            ),
          ),
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
