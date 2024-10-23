final class Pagination<T> {
  final int currentPage;
  final bool isLastPage;

  final List<T> items;

  const Pagination({
    required this.currentPage,
    required this.isLastPage,
    required this.items,
  });

  bool get isFirstPage => currentPage <= 1;

  bool get isEmpty => items.isEmpty;
}
