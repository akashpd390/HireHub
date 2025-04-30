import 'package:job_seeker/core/dependency_injection.dart';
import 'package:job_seeker/data/datasource/job_listing_datasource.dart';
import 'package:job_seeker/prsentation/home/provider/job_data.dart';
import 'package:job_seeker/data/datasource/application_datasource.dart';
import 'package:job_seeker/data/datasource/bookmark_jobs_datasource.dart';
import 'package:job_seeker/data/datasource/chat_datasorce.dart';
import 'package:job_seeker/data/datasource/resume_service_datasource.dart';
import 'package:job_seeker/data/datasource/user_auth_datasource.dart';
import 'package:job_seeker/prsentation/applications/provider/application_provider.dart';

import 'package:job_seeker/prsentation/auth/provider/auth_provider.dart';
import 'package:job_seeker/prsentation/bookmark/provider/bookmark_jobs_provider.dart';
import 'package:job_seeker/prsentation/chat/provider/chat_provider.dart';
import 'package:job_seeker/prsentation/chat/provider/message_provider.dart';
import 'package:job_seeker/prsentation/home/provider/filter_jobs_provider.dart';

import 'package:job_seeker/prsentation/home/provider/job_list_provider.dart';
import 'package:job_seeker/prsentation/job_details/provider/job_details_provider.dart';
import 'package:job_seeker/prsentation/job_details/provider/resume_service_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (context) => JobData()),
  ChangeNotifierProvider(
      create: (context) =>
          JobListingProvider(datasource: sl<JobListingDatasource>())),
  ChangeNotifierProvider(
      create: (context) =>
          JobFilterProvider(datasource: sl<JobListingDatasource>())),
  ChangeNotifierProvider(
      create: (context) =>
          JobDetailsProvider(datasource: sl<JobListingDatasource>())),
  ChangeNotifierProvider(
      create: (context) => AuthProvider(dataSource: sl<UserAuthDataSource>())),
  ChangeNotifierProvider(
      create: (context) =>
          ResumeProvider(datasource: sl<ResumeServiceDatasource>())),
  ChangeNotifierProvider(
      create: (context) =>
          ApplicationProvider(datasource: sl<ApplicationDatasource>())),
  ChangeNotifierProvider(
      create: (context) =>
          BookMarkJobProvider(datasource: sl<BookmarksJobsDatasource>())),
  ChangeNotifierProvider(
      create: (context) => ChatProvider(datasource: sl<ChatDatasource>())),
  ChangeNotifierProvider(
      create: (context) => MessageProvider(datasource: sl<ChatDatasource>())),
];
