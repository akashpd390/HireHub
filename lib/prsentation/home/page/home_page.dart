import 'package:flutter/material.dart';
import 'package:job_seeker/prsentation/applications/page/applications_page.dart';
import 'package:job_seeker/prsentation/bookmark/page/bookmark_page.dart';
import 'package:job_seeker/prsentation/bookmark/provider/bookmark_jobs_provider.dart';
import 'package:job_seeker/prsentation/chat/page/chat_page.dart';
import 'package:job_seeker/prsentation/explore/page/explorer_page.dart';
import 'package:job_seeker/prsentation/home/provider/filter_jobs_provider.dart';
import 'package:job_seeker/prsentation/home/provider/job_list_provider.dart';
import 'package:job_seeker/prsentation/home/widgets/recent_job_section_widget.dart';
import 'package:job_seeker/prsentation/home/widgets/suggested_section_widgets.dart';
import 'package:job_seeker/prsentation/home/widgets/top_bar.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int _selectedIndex = 0;

  late List<Widget> tabList = [
    homeWidget(),
    const ExplorerPage(),
    const BookMarkPage(),
    const ChatPage(),
    const ApplicationsPage(),
  ];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<JobListingProvider>(context, listen: false).fetchJobs();
      Provider.of<JobFilterProvider>(context, listen: false).fetchFilterJobs();
      Provider.of<BookMarkJobProvider>(context, listen: false)
          .fetchBookMarkJobs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: tabList[_selectedIndex],
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(),
    );
  }

  Widget homeWidget() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TopBAR
          TopBar(),

          SizedBox(height: 20),

          // Searh bar
          // SearchBarWidget(),

          // Suggested Job Selection
          SuggestedJobsSection(),

          SizedBox(height: 20),

          // Recent Job selection
          RecentJobsSection(),
        ],
      ),
    );
  }

  BottomNavigationBar bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explorer',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bookmark),
          label: 'Bookmark',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assessment),
          label: 'Application',
        ),
      ],
    );
  }
}
