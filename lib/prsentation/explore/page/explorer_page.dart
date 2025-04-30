import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/home/provider/job_list_provider.dart';
import 'package:job_seeker/prsentation/home/widgets/job_card.dart';
import 'package:job_seeker/prsentation/home/widgets/search_bar_widgets.dart';
import 'package:provider/provider.dart';

class ExplorerPage extends StatelessWidget {
  const ExplorerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          const SearchBarWidget(),
          const SizedBox(
            height: 20,
          ),
          Consumer<JobListingProvider>(builder: (context, jobProvider, child) {
            if (jobProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (jobProvider.error != null) {
              return Text('Failed to load jobs: ${jobProvider.error}');
            } else if (jobProvider.jobs.isEmpty) {
              return const Text('No jobs available.');
            }
            return Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: jobProvider.jobs.map((job) {
                    return JobCard(
                      id: job.id,
                      company: job.companyName,
                      jobTitle: job.jobTitle,
                      location: job.location,
                      salary: job.salary,
                      tags: [job.level, job.workingModel, job.type],
                      image: job.image,
                    );
                  }).toList(),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
