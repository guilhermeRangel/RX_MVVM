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
    
    private var viewModel = ViewModel()
    private var bag = DisposeBag()
     var tableView: UITableView!
    let ob = Observable.from([1,2,3])
    
    let subject = PublishSubject<String>()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.view.addSubview(tableView)
        viewModel.fetchUsers()
        bindTableView()
//        observable1()
        subjectsPublish(subject: subject)
        
        
        
    }//end
    func subjectsPublish(subject: PublishSubject<String>){
        subject.on(.next("is anyone listening?"))
        
        let subscriptionOne = subject
            .subscribe(onNext: { string in
                print(string)
            })
        subject.on(.next("subscribe_1"))
        subject.onNext("subscribe_2")
        
        let subcribeTwo = subject
            .subscribe{ event in
            print("2)", event.element ?? event)
        }
        
        subject.onNext("3")
        subscriptionOne.dispose()
        subject.onNext("4")
        
        subject.onCompleted()
        subject.onNext("5")
        subcribeTwo.dispose()
        
        subject.subscribe{
            print("3)", $0.element ?? $0)
        }.disposed(by: bag)
        subject.onNext("???")
    }
    
    func observable1(){
        let observable = Observable<String>.create { obs in
            obs.onNext("1")
            obs.onNext("2")
            obs.onCompleted()
            obs.onNext("?")
            
            return Disposables.create()
        }
        observable.subscribe(onNext: {print($0)},
                      onError: {print($0)},
                      onCompleted: {print("completed")},
                      onDisposed: {print("disposed")}
        ).disposed(by:bag)
        
        
        ob.subscribe(onNext: { element in
            print(element)
        },onCompleted: {
            print("completed")
        })
    
    }
}

extension ViewController: UITableViewDelegate{
    
    func setupTableView(){
        tableView = {
            lazy var tableView = UITableView(frame: self.view.frame, style: .insetGrouped)
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(UserTableViewCell.self, forCellReuseIdentifier: "UserTableViewCell")
            return tableView
        }()
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

}
