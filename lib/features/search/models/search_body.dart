class SearchBody {
  final String q;
  final String searchIn;
  final int page;
  final int pageSize;

  const SearchBody({
    required this.q,
    this.searchIn = 'title',
    this.page = 1,
    this.pageSize = 15,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'q': q});
    result.addAll({'searchIn': searchIn});
    result.addAll({'page': page});
    result.addAll({'pageSize': pageSize});
  
    return result;
  }

  factory SearchBody.fromMap(Map<String, dynamic> map) {
    return SearchBody(
      q: map['q'] ?? '',
      searchIn: map['searchIn'] ?? '',
      page: map['page']?.toInt() ?? 0,
      pageSize: map['pageSize']?.toInt() ?? 0,
    );
  }
}
