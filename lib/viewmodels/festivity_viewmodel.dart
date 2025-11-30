import '../models/festivity.dart';
import '../services/mock_service.dart';

class FestivityViewModel {
  final MockService _service = MockService();

  Future<List<Festivity>> getFestivities() {
    return _service.fetchFestivities();
  }

  Future<Festivity?> getFestivityById(String id) {
    return _service.getFestivityById(id);
  }

  Future<List<Festivity>> getFestivitiesByMonth(String month) {
    return _service.fetchFestivitiesByMonth(month);
  }

  Future<List<Festivity>> getFeaturedFestivities() {
    return _service.fetchFeaturedFestivities();
  }

  Future<List<Festivity>> searchFestivities(String query) {
    return _service.searchFestivities(query);
  }
}