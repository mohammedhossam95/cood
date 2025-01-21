import '../../core/client/http_client.dart';
import '../../data/data_sources/get_search_remote_datasource.dart';
import '../../data/repositories/get_search_repository.dart';
import '../../domain/usecases/use_case.dart';
import '../../presentation/bloc/awesome_places_search_bloc.dart';

class Dependencies {
  late AwesomePlacesSearchBloc bloc;

  void initDependencies(String key) {
    final dataSource = GetSearchRemoteDataSource(key: key, http: HttpClient());
    final repository = GetSearchRepository(dataSource: dataSource);
    final placeUseCase = GetPlacesUseCase(repository: repository);
    final latLngUseCase = GetLatLngUseCase(repository: repository);
    bloc = AwesomePlacesSearchBloc(
      useCase: placeUseCase,
      latLngUseCase: latLngUseCase,
      key: key,
    );
  }
}
