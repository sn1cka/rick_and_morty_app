final class Pagination<T> {
  final int currentPage;
  final int totalAmount;

  final List<T> currentItems;

  Pagination({
    required this.currentPage,
    required this.totalAmount,
    required this.currentItems,
  });

  bool get isFirstPage => currentPage <= 1;

  bool get isLastPage => currentPage == totalAmount;
}
