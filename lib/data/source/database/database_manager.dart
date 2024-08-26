abstract interface class DatabaseManager<T> {
  Future<List<T>> getAll(String country);
  Future<void> create({required T item});
  Future<void> delete({required int id});
  Future<void> update({required T item});
}
