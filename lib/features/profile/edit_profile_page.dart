import 'dart:io';

import 'package:emartecommerce/features/app/consts/colors.dart';
import 'package:emartecommerce/features/app/consts/strings.dart';
import 'package:emartecommerce/features/app/global/widgets/custom_textfeild.dart';
import 'package:emartecommerce/features/app/global/widgets/custombutton.dart';
import 'package:emartecommerce/features/auth_pages/widgets/bg_widget.dart';
import 'package:emartecommerce/features/provider_controller/getxprofilecontroller.dart';
import 'package:emartecommerce/features/service/cloudinary_services/cloudinary_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

import '../app/consts/images.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key, this.data});
  final dynamic data;
  final _formkey = GlobalKey<FormState>();

  final TextEditingController namecontroller = TextEditingController();

  final TextEditingController oldpasswordcontroller = TextEditingController();

  final TextEditingController passwordcontroller = TextEditingController();

  bool ispasswordchanged = false;

  final _profileController = Get.put(Getxprofilecontroller());

  @override
  Widget build(BuildContext context) {
    namecontroller.text = data["name"];
    return bgwidget(
        hight: MediaQuery.sizeOf(context).height,
        child: PopScope(
          canPop: true,
          onPopInvoked: (didPop) {
            _profileController.imagpath.value = "";
            namecontroller.dispose();
            oldpasswordcontroller.dispose();
            passwordcontroller.dispose();
          },
          child: Scaffold(
            appBar: AppBar(),
            body: Container(
              margin: const EdgeInsets.all(8),
              child: Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                       Obx(
                            ()=> GestureDetector(
                                onTap: () {
                                  _profileController.pickimage(context);
                                },
                                child: CircleAvatar(
                                  backgroundImage: _profileController
                                          .imagpath.isNotEmpty
                                      ? FileImage(File(_profileController.imagpath.value))
                                      : data["imgurl"].isEmpty
                                          ? AssetImage(profile_defauld)
                                          : NetworkImage(data["imgurl"]),

                                  // ? value!.imagpath.isEmpty
                                  // ?
                                  // :
                                  // : widget.ischange? FileImage(File(value.imagpath)):,
                                  radius: 50,
                                  // child:,
                                ))
                        ),
                        const Divider(),
                        Card(
                          elevation: 10,
                          color: redColor,
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(data["email"]),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                customtextfeild(
                                    validatortest: (value) {
                                      if (value!.isEmpty || value == "") {
                                        return "name is required.";
                                      } else {
                                        return null;
                                      }
                                    },
                                    hint: namehint,
                                    obscure: false,
                                    title: name,
                                    controller: namecontroller),
                                customtextfeild(
                                    validatortest: (value) {
                                      if (value!.isEmpty || value == "") {
                                        return null;
                                      } else if (value !=
                                          data["password"]) {
                                        return "old password is not matched.";
                                      } else {
                                        return null;
                                      }
                                    },
                                    hint: "Old password",
                                    obscure: true,
                                    title: "Old password",
                                    controller: oldpasswordcontroller),
                                customtextfeild(
                                    validatortest: (value) {
                                      if (value!.isEmpty || value == "") {
                                        if (oldpasswordcontroller.text.isEmpty) {
                                          return null;
                                        } else {
                                          return "password is required";
                                        }
                                      } else if (value ==
                                          data["password"]) {
                                        return "Create new password";
                                      } else if (value.length < 7) {
                                        return "Password must be contain 7 characters.";
                                      } else {
                                        ispasswordchanged = true;
                                        return null;
                                      }
                                    },
                                    hint: passwordhind,
                                    obscure: true,
                                    title: password,
                                    controller: passwordcontroller),
                              ],
                            )),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                            ()=> _profileController
                                  .isloading.value
                              ? Center(
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation(redColor),
                                  ),
                                )
                              : SizedBox(
                                  width: double.infinity,
                                  child: customButton(
                                      title: "Update",
                                      callback: () async {
                                        final isvalid =
                                            _formkey.currentState!.validate();
                                        if (isvalid) {
                                          bool isimagechanged = _profileController
                                              .imagpath.isNotEmpty;
                                          bool isnamechanged =
                                              namecontroller.text.trim() !=
                                                  data["name"];
                                          _profileController.isloading.value=true;
                                          if (ispasswordchanged) {
                                            _profileController.changeauthpassword(
                                                email: data["email"],
                                                oldpassword:
                                                    oldpasswordcontroller.text,
                                                password:
                                                    passwordcontroller.text);
                                          }
                                          if (isimagechanged) {
                                            if (data["imgurl"].isNotEmpty) {
                                              await CloudinaryServices()
                                                  .deleteImage(
                                                      publicId:
                                                          data["imgurl"]);
                                            }
                                            String? url =
                                                await CloudinaryServices()
                                                    .uploadImage(
                                                        filePath:
                                                            _profileController
                                                                .imagpath.value,
                                                        folderName:
                                                            "profile_images");
                                            _profileController.updatename(
                                                imgurl: url ?? "",
                                                name: isnamechanged
                                                    ? namecontroller.text
                                                        .toString()
                                                    : data["name"],
                                                password: ispasswordchanged
                                                    ? passwordcontroller.text
                                                        .toString()
                                                    : data["password"]);
                                            _profileController.isloading.value=false;
                                            VxToast.show(context,
                                                msg: "Profile is Updated");
                                            Navigator.pop(context);
                                          } else {
                                            _profileController.updatename(
                                                imgurl: data["imgurl"],
                                                name: isnamechanged
                                                    ? namecontroller.text
                                                        .toString()
                                                    : data["name"],
                                                password: ispasswordchanged
                                                    ? passwordcontroller.text
                                                        .toString()
                                                    : data["password"]);
                                            _profileController.isloading.value=false;
                                            VxToast.show(context,
                                                msg: "Profile is Updated");
                                            Navigator.pop(context);
                                          }
                                        }
                                      },
                                      bgcolor: redColor,
                                      textcolor: Colors.white),
                                ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
