
import 'package:get_it/get_it.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/services/storage.service.dart';


GetIt locator = GetIt.instance;

void setupLocator() async {
  // Services
  locator.registerSingleton<ProjectService>(ProjectService());
  locator.registerSingleton<StorageService>(StorageService());



}
