//
//  SearchListSection.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/9/25.
//

import RxDataSources

enum SearchListSection {
  case shotTile([SearchListSectionItem])
}

extension SearchListSection: SectionModelType {
  var items: [SearchListSectionItem] {
    switch self {
    case .shotTile(let items): return items
    }
  }

  init(original: SearchListSection, items: [SearchListSectionItem]) {
    switch original {
    case .shotTile: self = .shotTile(items)
    }
  }
}

enum SearchListSectionItem {
  case shotTile(SearchCellReactor)
}
