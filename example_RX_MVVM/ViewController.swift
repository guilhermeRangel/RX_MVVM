//
//  ViewController.swift
//  example_RX_MVVM
//
//  Created by Guilherme Rangel on 24/07/22.
//

import UIKit
import RxSwift
import RxCocoa


class ViewController: UIViewController {
    
    var viewModel = ViewModel()
    private var bag = DisposeBag()
     var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.view.addSubview(tableView)
        viewModel.fetchUsers()
        bindTableView()
    }
    
    func bindTableView(){
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.users.bind(to: tableView.rx.items(cellIdentifier: "UserTableViewCell", cellType: UserTableViewCell.self)) { (row, item, cell) in
            var context = cell.defaultContentConfiguration()
            context.text = item.title
            context.secondaryText = "\(item.id)"
            cell.contentConfiguration = context
        }.disposed(by: bag)
    }

    func setupTableView(){
        tableView = {
            lazy var tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
            return tableView
        }()
    }
}

