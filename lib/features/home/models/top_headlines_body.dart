class TopHeadlinesBody {
  final String country;
  final String? category;
  final String? sources;
  final String? q;
  final int? pageSize;
  final int? page;

  const TopHeadlinesBody({
    this.country = 'us',
    this.category,
    this.sources,
    this.q,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
  
    result.addAll({'country': country});
    if(category != null){
      result.addAll({'category': category});
    }
    if(sources != null){
      result.addAll({'sources': sources});
    }
    if(q != null){
      result.addAll({'q': q});
    }
    if(pageSize != null){
      result.addAll({'pageSize': pageSize});
    }
    if(page != null){
      result.addAll({'page': page});
    }
  
    return result;
  }

  factory TopHeadlinesBody.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesBody(
      country: map['country'] ?? '',
      category: map['category'],
      sources: map['sources'],
      q: map['q'],
      pageSize: map['pageSize']?.toInt(),
      page: map['page']?.toInt(),
    );
  }
}
