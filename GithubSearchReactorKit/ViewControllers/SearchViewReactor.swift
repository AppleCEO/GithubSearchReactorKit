//
//  SearchViewReactor.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/8/25.
//

import ReactorKit
import RxSwift

final class SearchViewReactor: Reactor {
    private let networkService = NetworkService()
    
    enum Action {
        case search(String)
//        case reload
//        case tabRepository(String)
    }
    
    enum Mutation {
        case setSearchResponse(SearchResponse)
//        case refresh
//        case tabRepository(String)
    }
    
    struct State {
        var keyword: String
        var searchResponse: SearchResponse?
    }
    
    let initialState: State
    
    init() {
        self.initialState = State(keyword: "")
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
//        case .reload: break
        case .search(let keyword):
            return networkService.fetchSearchResult(keyword: keyword, page: 0)
                .map(Mutation.setSearchResponse)
                .catch { error in
                    print("네트워크 요청 오류 : \(error)")
                    return .empty()
                }
//        case .tabRepository(_): break
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        switch mutation {
//        case .refresh: break
        case .setSearchResponse(let newSearchResponse):
            print("Received search response in reduce: \(newSearchResponse)")
            state.searchResponse = newSearchResponse
//        case .tabRepository(_): break
        }
        return state
    }
    
    private func fetchNetworkData(keyword: String, page: Int) -> Observable<SearchResponse> {
        return networkService.fetchSearchResult(keyword: keyword, page: page)
    }
}
