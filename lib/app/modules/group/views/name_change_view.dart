
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirror_fly_demo/app/common/widgets.dart';
import 'package:mirror_fly_demo/app/modules/group/controllers/group_info_controller.dart';

import '../../../common/constants.dart';

class NameChangeView extends GetView<GroupInfoController> {
  const NameChangeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Enter New Name'),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (controller.showEmoji.value) {
            controller.showEmoji(false);
          } else {
            Get.back();
          }
          return Future.value(false);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        style:
                            const TextStyle(fontSize: 20, fontWeight: FontWeight.normal,overflow: TextOverflow.visible),
                        onChanged: (_) => controller.onChanged(),
                        maxLength: 121,
                        maxLines: 1,
                        controller: controller.nameController,
                        decoration: const InputDecoration(border: InputBorder.none,counterText:"" ),
                      ),
                    ),
                    Container(
                      height: 50,
                      padding: const EdgeInsets.all(4.0),
                        child: Center(
                          child: Obx(
                            ()=> Text(
                      controller.count.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                    ),
                          ),
                        )),
                    IconButton(
                        onPressed: () {
                          if (!controller.showEmoji.value) {
                            FocusScope.of(context).unfocus();
                            controller.focusNode.canRequestFocus = false;
                          }
                          Future.delayed(const Duration(milliseconds: 500), () {
                            controller.showEmoji(!controller.showEmoji.value);
                          });
                        },
                        icon: SvgPicture.asset(smileIcon))
                  ],
                ),
              ),
            ),
            Row(children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
              const Divider(
                color: Colors.grey,
                thickness: 0.2,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if(controller.nameController.text.trim().isNotEmpty) {
                      Get.back(result: controller.nameController.text
                          .trim().toString());
                    }else{
                      toToast("Name cannot be empty");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ),
              ),
            ]),
            emojiLayout(),
          ],
        ),
      ),
    );
  }

  Widget emojiLayout() {
    return Obx(() {
      if (controller.showEmoji.value) {
        return EmojiLayout(
          textController: controller.nameController,
            onEmojiSelected : (cat, emoji)=>controller.onChanged()
        );
      } else {
        return const SizedBox.shrink();
      }
    });
  }
}
