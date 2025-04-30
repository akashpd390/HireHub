import 'package:get_it/get_it.dart';
import 'package:job_seeker/data/datasource/application_datasource.dart';
import 'package:job_seeker/data/datasource/bookmark_jobs_datasource.dart';
import 'package:job_seeker/data/datasource/chat_datasorce.dart';
import 'package:job_seeker/data/datasource/job_listing_datasource.dart';
import 'package:job_seeker/data/datasource/resume_service_datasource.dart';
import 'package:job_seeker/data/datasource/user_auth_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

setup() {
  sl.registerSingleton<SupabaseClient>(Supabase.instance.client);

  sl.registerSingleton<JobListingDatasource>(
      JobListingDatasource(supabaseClient: sl<SupabaseClient>()));

  sl.registerSingleton<UserAuthDataSource>(
      UserAuthDataSource(supabase: sl<SupabaseClient>()));

  sl.registerSingleton<ResumeServiceDatasource>(
      ResumeServiceDatasource(supabase: sl<SupabaseClient>()));

  sl.registerSingleton<ApplicationDatasource>(
      ApplicationDatasource(supabase: sl<SupabaseClient>()));

  sl.registerSingleton<BookmarksJobsDatasource>(
      BookmarksJobsDatasource(supabase: sl<SupabaseClient>()));

  sl.registerSingleton<ChatDatasource>(
      ChatDatasource(supabase: sl<SupabaseClient>()));
}
