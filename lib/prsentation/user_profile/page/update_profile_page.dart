import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/auth/widgets/my_custom_input_filed.dart';
import 'package:provider/provider.dart';

class UpdateProfilePage extends StatefulWidget {
  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
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
                            child: Consumer<AuthProvider>(
                                builder: (context, authProvider, child) {
                              final userData = authProvider.user!;

                              return Column(
                                children: [
                                  // const Text("Name"),
                                  MyCustomInputFiled(
                                      text: userData.name.isEmpty
                                          ? "Name"
                                          : userData.name,
                                      textEditingController: _nameController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // const Text("Last Name"),
                                  MyCustomInputFiled(
                                      text: userData.lastName.isEmpty
                                          ? "Last Name"
                                          : userData.lastName,
                                      textEditingController: _lastController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // const Text("Phone No"),
                                  MyCustomInputFiled(
                                      text: userData.phoneNo.isEmpty
                                          ? "Phone No"
                                          : userData.phoneNo,
                                      textEditingController:
                                          _phoneNoController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // const Text("Address"),
                                  MyCustomInputFiled(
                                      text: userData.address.isEmpty
                                          ? "Address"
                                          : userData.address,
                                      textEditingController:
                                          _addressController),
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
                                            text: userData.dateOfBirth.isEmpty
                                                ? "DD"
                                                : userData.dateOfBirth
                                                    .substring(0, 2),
                                            textEditingController:
                                                _dobDDController),
                                      ),
                                      Expanded(
                                        child: MyCustomInputFiled(
                                            text: userData.dateOfBirth.isEmpty
                                                ? "MM"
                                                : userData.dateOfBirth
                                                    .substring(3, 5),
                                            textEditingController:
                                                _dobMMController),
                                      ),
                                      Expanded(
                                        child: MyCustomInputFiled(
                                            text: userData.dateOfBirth.isEmpty
                                                ? "YYYY"
                                                : userData.dateOfBirth
                                                    .substring(6),
                                            textEditingController:
                                                _dobYYController),
                                      ),
                                    ],
                                  ),
                                  // const Text("Job Profile"),
                                  MyCustomInputFiled(
                                      text: userData.jobProfile.isEmpty
                                          ? "JobProfile"
                                          : userData.jobProfile,
                                      textEditingController:
                                          _jobProfileController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // const Text("Skills"),
                                  MyCustomInputFiled(
                                      text: userData.skills.isEmpty
                                          ? "Skills"
                                          : userData.skills,
                                      textEditingController: _skillsController),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                "Update Profile",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ))
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
