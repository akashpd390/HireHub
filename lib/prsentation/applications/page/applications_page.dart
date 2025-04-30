import 'package:flutter/material.dart';
import 'package:job_seeker/domain/entity/applications_entity.dart';
import 'package:job_seeker/prsentation/applications/provider/application_provider.dart';
import 'package:provider/provider.dart';

class ApplicationsPage extends StatefulWidget {
  const ApplicationsPage({super.key});

  @override
  State<ApplicationsPage> createState() => _ApplicationsPageState();
}

class _ApplicationsPageState extends State<ApplicationsPage> {
  @override
  void initState() {
    super.initState();
    final applicationProvider = context.read<ApplicationProvider>();
    applicationProvider.fetchApplication();
    applicationProvider.subscribeToApplication();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        children: [
          const SizedBox(
            height: 100,
            width: double.infinity,
            child: Text(
              "Track Your \nApplication",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: context
                .watch<ApplicationProvider>()
                .applications
                .map((application) {
              final createdAt = DateTime.parse(application.createdAt);

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 70,
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(application.job.image.toString()),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                application.job.jobTitle.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(application.status.name.toString(),
                                  style: TextStyle(
                                    color: application.status ==
                                            ApplicationStatus.rejected
                                        ? Colors.red
                                        : Colors.green,
                                  )),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                              "${createdAt.year}-${createdAt.month}-${createdAt.day}"),
                          Text("${createdAt.hour}:${createdAt.minute}")
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          )
        ],
      ),
    );
  }
}
