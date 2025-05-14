import 'package:get_it/get_it.dart';
import 'package:recipes_app/core/domain/facades/http_facade.dart';
import 'package:recipes_app/features/recipes/di/recipes_injector.dart';
import 'package:recipes_app/integrations/dio_facade.dart';

final GetIt injector = GetIt.instance;

void registerDependencies() {
  injector.registerFactory<HttpFacade>(() => HttpDioFacade());

  injectRecipesDependencies();
}
