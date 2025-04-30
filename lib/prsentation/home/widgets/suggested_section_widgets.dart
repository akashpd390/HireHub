import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/home/provider/job_list_provider.dart';
import 'package:job_seeker/prsentation/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

class SuggestedJobsSection extends StatelessWidget {
  const SuggestedJobsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Suggested Jobs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(onPressed: () {}, child: const Text('See all')),
            ],
          ),
        ),
        Consumer<JobListingProvider>(builder: (context, jobProvider, child) {
          if (jobProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (jobProvider.error != null) {
            return Text('Failed to load jobs: ${jobProvider.error}');
          } else if (jobProvider.jobs.isEmpty) {
            return const Text('No jobs available.');
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
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
          );
        }),
      ],
    );
  }
}
