//
//  SearchCellReactor.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/10/25.
//

import ReactorKit
import RxCocoa
import RxSwift

final class SearchCellReactor: Reactor {
  typealias Action = NoAction

  struct State {
    var title: String
  }

  let item: Item
  let initialState: State

  init(item: Item) {
    self.item = item
    self.initialState = State(
        title: item.name
    )
    _ = self.state
  }
}
