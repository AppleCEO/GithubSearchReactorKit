//
//  ViewController.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/8/25.
//

import UIKit
import Then
import SnapKit
import ReactorKit
import RxCocoa
import RxDataSources

class SearchViewController: UIViewController, StoryboardView {
    var disposeBag = DisposeBag()
    
    private let searchBar = UISearchBar()
    private let tableView = UITableView().then {
        $0.register(SearchTitleCell.self, forCellReuseIdentifier: "SearchTitleCell")
    }
    private let dataSource = RxTableViewSectionedReloadDataSource<SearchListSection>.init(configureCell: { dataSource, tableView, indexPath, sectionItem in
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTitleCell") as? SearchTitleCell else { return UITableViewCell() }
        switch sectionItem {
        case .shotTile(let searchCellReactor):
            cell.reactor = searchCellReactor
        }
        return cell
    })
    
    func bind(reactor: SearchViewReactor) {
        searchBar.rx.text
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .map { SearchViewReactor.Action.search($0 ?? "")}
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.searchResponse }
            .compactMap { $0 }
            .map { response -> [SearchListSection] in
                // [Item] 배열을 [SearchListSectionItem] 배열로 변환하는 과정
                let searchListSectionItems: [SearchListSectionItem] = response.items.map { item in
                    // 각 `Item` 객체를 사용하여 `SearchCellReactor`를 생성
                    let reactor = SearchCellReactor(item: item)
                    // `SearchCellReactor`를 SearchListSectionItem의 케이스로 래핑
                    return .shotTile(reactor)
                }
                
                // 변환된 아이템 배열을 섹션 모델에 담아 반환
                let section = SearchListSection.shotTile(searchListSectionItems)
                return [section]
            }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
          
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    private func configureUI() {
        [searchBar, tableView].forEach {
            view.addSubview($0)
        }
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

