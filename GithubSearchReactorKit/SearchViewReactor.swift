//
//  SearchViewReactor.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/8/25.
//

import ReactorKit
import RxSwift

final class SearchViewReactor: Reactor {
    enum Action {
        case search(String)
        case reload
        case tabRepository(String)
    }
    
    enum Mutation {
        case searchKeyword(String)
        case refresh
        case tabRepository(String)
    }
    
    struct State {
        var keyword: String
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(keyword: "")
    }
}
