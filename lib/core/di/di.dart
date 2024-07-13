import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'di.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<GetIt> configureDependencies() async => await init(getIt);

Dep findDep<Dep extends Object>({String? instanceName}) {
  if (instanceName?.isNotEmpty ?? false) getIt<Dep>(instanceName: instanceName);
  return getIt<Dep>();
}

/// It's helper method to retrieve the [AppNavigator] Class
// AppNavigator get navigator {
//   return findDep<AppNavigator>();
// }