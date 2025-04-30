import "package:flutter/material.dart";
import "package:job_seeker/prsentation/bookmark/provider/bookmark_jobs_provider.dart";
import "package:job_seeker/prsentation/job_details/page/job_details_page.dart";
import "package:provider/provider.dart";

class JobCard extends StatelessWidget {
  final int id;
  final String company;
  final String jobTitle;
  final String location;
  final String salary;
  final List<String> tags;
  final String image;

  const JobCard({
    super.key,
    required this.id,
    required this.company,
    required this.jobTitle,
    required this.location,
    required this.salary,
    required this.tags,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => JobDetailsPage(id: id)),
        );
      },
      child: Container(
        width: 450,
        // height: 200,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 16, bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(image.isEmpty
                          ? "https://bbekokmtumrrmjbohsdv.supabase.co/storage/v1/object/public/profiles//microsoft_PNG13.webp" // TODO : unHandle for empty image
                          : image),
                      radius: 20,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobTitle,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          company,
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                Consumer<BookMarkJobProvider>(
                  builder: (context, bookmarkProvider, child) {
                    final isBookmarked = bookmarkProvider.jobs.contains(id);
                    return IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                        color: Colors.purple,
                      ),
                      onPressed: () {
                        bookmarkProvider.toggleBookmark(id);
                      },
                    );
                  },
                )
              ],
            ),
            const SizedBox(height: 10),
            // const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.grey, size: 16),
                Text(
                  location,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            const SizedBox(height: 10),
            Text(
              "\$ $salary",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
