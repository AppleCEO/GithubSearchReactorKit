//
//  BaseTableViewCell.swift
//  GithubSearchReactorKit
//
//  Created by 도미닉 on 8/10/25.
//

import UIKit

import RxSwift

class BaseTableViewCell: UITableViewCell {

  var disposeBag = DisposeBag()
  

  // MARK: Initializing

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }

  required convenience init?(coder aDecoder: NSCoder) {
    self.init(style: .default, reuseIdentifier: nil)
  }

}
