//
//  SearchTitleCell.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/10/25.
//

import UIKit

import ReactorKit

final class SearchTitleCell: BaseTableViewCell, View {
    static let identifier = "SearchTitleCell"
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
    }
    
    // MARK: Configuring
    
    func bind(reactor: SearchCellReactor) {
        guard let textLabel = self.textLabel else { return }
        reactor.state
            .map { $0.title }
            .bind(to: textLabel.rx.text)
            .disposed(by: self.disposeBag)
    }
}
