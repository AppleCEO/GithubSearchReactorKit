//
//  ViewController.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/8/25.
//

import UIKit
import Then
import SnapKit

class ViewController: UIViewController {
    private let searchBar = UISearchBar()
    private let tableView = UITableView()
    
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

