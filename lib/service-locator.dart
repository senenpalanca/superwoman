import 'package:get_it/get_it.dart';
import 'package:superwoman/services/project.service.dart';
import 'package:superwoman/services/stakeholder.service.dart';
import 'package:superwoman/services/storage.service.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {

  locator.registerSingleton<ProjectService>(ProjectService());
  locator.registerSingleton<StakeholderService>(StakeholderService());
  locator.registerSingleton<StorageService>(StorageService());

}
