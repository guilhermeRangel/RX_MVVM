//
//  ViewModel.swift
//  example_RX_MVVM
//
//  Created by Guilherme Rangel on 24/07/22.
//


import UIKit
import RxSwift
import RxCocoa

class ViewModel {
    var users = BehaviorSubject(value: [User]())
    
    func fetchUsers(){
        let typyCodeURL = "https://jsonplaceholder.typicode.com/posts"
        let url = URL(string: typyCodeURL)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            do {
                let responseData = try JSONDecoder().decode([User].self, from: data)
                print(responseData)
                self.users.on(.next(responseData))
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
