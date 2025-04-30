import "package:flutter/material.dart";
import "package:job_seeker/prsentation/job_details/provider/job_details_provider.dart";
import "package:job_seeker/prsentation/job_details/widgets/header.dart";
import "package:job_seeker/prsentation/job_details/widgets/job_details_widgets.dart";
import "package:provider/provider.dart";

class JobDetailsPage extends StatefulWidget {
  final int id;
  const JobDetailsPage({super.key, required this.id});

  @override
  State<JobDetailsPage> createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.microtask(() {
      Provider.of<JobDetailsProvider>(context, listen: false)
          .fetchJob(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Column(
          children: [
            const Header(),
            Consumer<JobDetailsProvider>(builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (value.job == null) {
                return Center(
                  child:
                      Text("there is problem fetching the data ${value.error}"),
                );
              }

              final job = value.job!;

              return Expanded(
                child: JobDetailsContent(job: job),
              );
            }),
          ],
        ),
      ),
    );
  }
}
