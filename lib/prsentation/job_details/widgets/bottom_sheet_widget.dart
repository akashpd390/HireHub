import "dart:io";

import "package:file_picker/file_picker.dart";
import "package:flutter/material.dart";
import "package:fluttertoast/fluttertoast.dart";
import "package:job_seeker/prsentation/auth/provider/auth_provider.dart";
import "package:job_seeker/prsentation/job_details/provider/job_details_provider.dart";
import "package:job_seeker/prsentation/job_details/provider/resume_service_provider.dart";
import "package:open_file/open_file.dart";
import "package:provider/provider.dart";
import "package:url_launcher/url_launcher.dart";

class BottomSheetWidget extends StatefulWidget {
  final int jobId;
  const BottomSheetWidget({super.key, required this.jobId});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  String? resumeUrl;
  String? _fileName;

  FilePickerResult? pickedFile;

  Future<void> launchPublicUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(
        msg: "Could not open the resume link",
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final user = context.read<AuthProvider>().user;
      setState(() {
        resumeUrl = user?.resumeUrl;
        _fileName =
            resumeUrl != null ? Uri.parse(resumeUrl!).pathSegments.last : null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ResumeProvider>(
      builder: (context, resumeProvider, _) {
        return SizedBox(
          width: double.infinity,
          height: 280,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Text(
                  "Please Select the latest Resume",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.attach_file),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              if (pickedFile?.files.first.path != null) {
                                OpenFile.open(pickedFile!.files.first.path!);
                              }
                            },
                            child: Text(
                              'File Name: ${resumeUrl == null ? pickedFile?.files.first.name ?? "No file selected" : _fileName}',
                              style: TextStyle(
                                color: pickedFile == null
                                    ? Colors.black
                                    : Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final result = await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['pdf', 'doc', 'docx'],
                          );

                          if (result != null) {
                            setState(() {
                              pickedFile = result;
                            });

                            final filePath =
                                File(pickedFile!.files.first.path!);
                            final fileName = pickedFile!.files.first.name;
                            _fileName = fileName;

                            try {
                              final publicUrl =
                                  await resumeProvider.uploadResume(
                                filePath,
                                fileName,
                              );
                              setState(() {
                                resumeUrl = publicUrl;
                              });

                              Fluttertoast.showToast(
                                msg: "Resume uploaded successfully!",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                              );
                            } catch (e) {
                              Fluttertoast.showToast(
                                msg: "Failed to upload resume!",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                              );
                            }
                          }
                        },
                        child: resumeProvider.isUploading
                            ? const CircularProgressIndicator()
                            : const Text("Choose File"),
                      ),
                    ],
                  ),
                ),

                // ✅ Clickable public resume link
                if (resumeUrl != null)
                  GestureDetector(
                    onTap: () {
                      launchPublicUrl(resumeUrl!);
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        "View uploaded resume",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(300, 70),
                    backgroundColor: resumeProvider.isUploading
                        ? Colors.white
                        : const Color(0xFF673AB7),
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: resumeProvider.isUploading || resumeUrl == null
                      ? null
                      : () {
                          context
                              .read<JobDetailsProvider>()
                              .applyJobs(widget.jobId, resumeUrl);
                          Navigator.pop(context);
                          Fluttertoast.showToast(msg: "Applied successfully!");
                        },
                  child: const Text(
                    'Apply for Job',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
