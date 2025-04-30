import 'package:flutter/material.dart';
import 'package:job_seeker/domain/entity/user_entity.dart';
import 'package:job_seeker/prsentation/auth/page/auth_gate.dart';
import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/auth/widgets/auth_action_button.dart';
import 'package:job_seeker/prsentation/auth/widgets/auth_header_widget.dart';
import 'package:job_seeker/prsentation/auth/widgets/my_custom_input_filed.dart';
import 'package:provider/provider.dart';

class UserFillUpFormPage extends StatefulWidget {
  const UserFillUpFormPage({super.key});

  @override
  State<UserFillUpFormPage> createState() => _UserFillUpFormPageState();
}

class _UserFillUpFormPageState extends State<UserFillUpFormPage> {
  late TextEditingController _nameController;
  late TextEditingController _lastController;

  late TextEditingController _phoneNoController;
  late TextEditingController _jobProfileController;
  late TextEditingController _skillsController;
  late TextEditingController _addressController;
  late TextEditingController _dobDDController;
  late TextEditingController _dobMMController;
  late TextEditingController _dobYYController;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _lastController = TextEditingController();
    _phoneNoController = TextEditingController();
    _jobProfileController = TextEditingController();
    _skillsController = TextEditingController();
    _addressController = TextEditingController();
    _dobDDController = TextEditingController();
    _dobMMController = TextEditingController();
    _dobYYController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _nameController.dispose();
    _lastController.dispose();

    _phoneNoController.dispose();
    _jobProfileController.dispose();
    _skillsController.dispose();
    _addressController.dispose();
    _dobDDController.dispose();
    _dobMMController.dispose();
    _dobYYController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Colors.deepPurple,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 80,
              ),
              const AuthHeaderWidget(
                text: "Create an Profile",
                title: "Profile",
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    height: 900,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60),
                            topRight: Radius.circular(60))),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const SizedBox(
                            height: 60,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.deepPurple.shade100,
                                      blurRadius: 20,
                                      offset: const Offset(0, 10))
                                ]),
                            child: Column(
                              children: [
                                // const Text("Name"),
                                MyCustomInputFiled(
                                    text: "Name",
                                    textEditingController: _nameController),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Text("Last Name"),
                                MyCustomInputFiled(
                                    text: "Last Name",
                                    textEditingController: _lastController),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Text("Phone No"),
                                MyCustomInputFiled(
                                    text: "Phone No",
                                    textEditingController: _phoneNoController),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Text("Address"),
                                MyCustomInputFiled(
                                    text: "Address",
                                    textEditingController: _addressController),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // const Text("Date of Birth"),
                                    Expanded(
                                      child: MyCustomInputFiled(
                                          text: "DD",
                                          textEditingController:
                                              _dobDDController),
                                    ),
                                    Expanded(
                                      child: MyCustomInputFiled(
                                          text: "MM",
                                          textEditingController:
                                              _dobMMController),
                                    ),
                                    Expanded(
                                      child: MyCustomInputFiled(
                                          text: "YYYY",
                                          textEditingController:
                                              _dobYYController),
                                    ),
                                  ],
                                ),
                                // const Text("Job Profile"),
                                MyCustomInputFiled(
                                    text: "Job Profile",
                                    textEditingController:
                                        _jobProfileController),
                                const SizedBox(
                                  height: 10,
                                ),
                                // const Text("Skills"),
                                MyCustomInputFiled(
                                    text: "Skills",
                                    textEditingController: _skillsController),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          AuthActionButton(
                              text: "Create",
                              onPressed: () {
                                final dob =
                                    "${_dobDDController.text}-${_dobMMController.text}-${_dobYYController.text}";
                                context.read<AuthProvider>().createProfile(
                                    UserEntity(
                                        id: "",
                                        name: _nameController.text,
                                        email: "",
                                        skills: _skillsController.text,
                                        lastName: _lastController.text,
                                        address: _addressController.text,
                                        avatar: "",
                                        resumeUrl: "",
                                        dateOfBirth: dob,
                                        jobProfile: _jobProfileController.text,
                                        phoneNo: _phoneNoController.text));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const AuthGate()),
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
