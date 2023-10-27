abstract class LocationDao {
  Future<int> insert(Map<String, dynamic> location);
  Future<void> update(int id, Map<String, dynamic> location);
  Future<void> deleteBy(int id);
  Future<List<Map<String, dynamic>>> findAll();
  Future<Map<String, dynamic>> findBy(int id);
}