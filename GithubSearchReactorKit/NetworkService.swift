//
//  NetworkService.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/9/25.
//

import RxSwift
import Foundation

class NetworkService {
    func fetchSearchResult(keyword: String, page: Int) -> Observable<SearchResponse> {
        return Observable.create { observer in
            let url = URL(string: "https://api.github.com/search/repositories?q=\(keyword)&page=\(page)")!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601 // 날짜 형식 설정
                
                if let data = data, let searchResponse = try? decoder.decode(SearchResponse.self, from: data) {
                    observer.onNext(searchResponse)
                    observer.onCompleted()
                }
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}
