import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/home/provider/filter_jobs_provider.dart';
import 'package:job_seeker/prsentation/home/provider/job_data.dart';

import 'package:job_seeker/prsentation/home/widgets/job_card.dart';
import 'package:provider/provider.dart';

class RecentJobsSection extends StatelessWidget {
  const RecentJobsSection({super.key});

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
                'Recent Jobs',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See all'),
              ),
            ],
          ),
        ),
        Consumer<JobData>(
          builder: (context, jobData, child) => SizedBox(
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: jobData.recentJobFilters.length,
              separatorBuilder: (context, index) => const SizedBox(width: 8.0),
              itemBuilder: (context, index) {
                final filter = jobData.recentJobFilters[index];
                return FilterChip(
                  label: Text(filter),
                  selected: jobData.selectedRecentJobFilter == filter,
                  onSelected: (bool selected) {
                    jobData.setSelectedRecentJobFilter(filter);
                    Provider.of<JobFilterProvider>(context, listen: false)
                        .setSelectedFilter(filter);
                  },
                );
              },
            ),
          ),
        ),
        Consumer<JobFilterProvider>(builder: (context, jobProvider, child) {
          if (jobProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (jobProvider.error != null) {
            return Text('Failed to load jobs: ${jobProvider.error}');
          } else if (jobProvider.filteredJobs.isEmpty) {
            return const Text('No jobs available.');
          }
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: jobProvider.filteredJobs.map((job) {
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
