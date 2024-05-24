import 'package:flutter/material.dart';
import 'package:flutter_talkshare/core/values/app_colors.dart';
import 'package:flutter_talkshare/modules/request_teacher/controller/request_teacher_controller.dart';
import 'package:flutter_talkshare/modules/request_teacher/widgets/custom_teacher_text_field.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CreateRequestRoleTeacherScreen extends StatefulWidget {
  const CreateRequestRoleTeacherScreen({super.key});

  @override
  State<CreateRequestRoleTeacherScreen> createState() =>
      _CreateRequestRoleTeacherScreenState();
}

class _CreateRequestRoleTeacherScreenState
    extends State<CreateRequestRoleTeacherScreen> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController agentController;
  late final TextEditingController teacherIdController;
  late final TextEditingController contentController;
  late final RequestTeacherController requestTeacherController;
  @override
  void initState() {
    requestTeacherController = Get.put(RequestTeacherController());
    formKey = GlobalKey<FormState>();
    agentController = TextEditingController();
    teacherIdController = TextEditingController();
    contentController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _buildTextField(
                  controller: agentController,
                  hintTitle: 'Nhập tên trung tâm',
                  title: 'Trung tâm',
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildTextField(
                  controller: teacherIdController,
                  hintTitle: 'Nhập mã giáo viên',
                  title: 'Mã giáo viên',
                ),
                const SizedBox(
                  height: 16,
                ),
                _buildTextField(
                  controller: contentController,
                  hintTitle: 'Nhập nội dung yêu cầu trờ thành giáo viên',
                  title: 'Nội dung',
                  maxLines: 5,
                ),
                const Spacer(),
                _buildButtonSendRequest(controller: requestTeacherController),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSendRequest({
    required RequestTeacherController controller,
  }) {
    return Obx(
      () => controller.isLoadingSubmit.value == false
          ? GestureDetector(
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();

                  await requestTeacherController.setRole(
                    agentName: agentController.text.trim(),
                    teacherId: teacherIdController.text.trim(),
                    content: contentController.text.trim(),
                  );
                }
              },
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.secondary20,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Gửi yêu cầu',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: LoadingAnimationWidget.discreteCircle(
                secondRingColor: AppColors.secondary20,
                thirdRingColor: AppColors.gray40,
                color: AppColors.primary40,
                size: 30,
              ),
            ),
    );
  }

  Column _buildTextField({
    required String title,
    required TextEditingController controller,
    required String hintTitle,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        CustomTeacherTextField(
          maxLines: maxLines,
          title: hintTitle,
          controller: controller,
          requestTeacherController: requestTeacherController,
        ),
      ],
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'Tạo yêu cầu',
        style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColors.primary20),
      ),
    );
  }
}
