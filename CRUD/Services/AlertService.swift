//
//  AlertService.swift
//  CRUD
//
//  Created by Daniel Alejandro Carriola on 3/29/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class AlertService {
    private init() {}
    
    static func addUser(in vc: UIViewController, _ completion: @escaping (_ user: User) -> ()) {
        let alert = UIAlertController(title: "Add User", message: nil, preferredStyle: .alert)
        alert.addTextField { (nameTxt) in
            nameTxt.placeholder = "Name"
        }
        alert.addTextField { (ageTxt) in
            ageTxt.placeholder = "Age"
            ageTxt.keyboardType = .numberPad
        }
        let add = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let name = alert.textFields?.first?.text, let ageStr = alert.textFields?.last?.text, let age = Int(ageStr) else { return }
            let user = User(name: name, age: age)
            completion(user)
        }
        alert.addAction(add)
        vc.present(alert, animated: true, completion: nil)
    }
    
    static func update(_ user: User, in vc: UIViewController, _ completion: @escaping (_ user: User) -> ()) {
        let alert = UIAlertController(title: "Update \(user.name)", message: nil, preferredStyle: .alert)
        alert.addTextField { (ageTxt) in
            ageTxt.placeholder = "Age"
            ageTxt.keyboardType = .numberPad
            ageTxt.text = String(user.age)
        }
        let add = UIAlertAction(title: "Update", style: .default) { (_) in
            guard let ageStr = alert.textFields?.last?.text, let age = Int(ageStr) else { return }
            var updatedUser = user
            updatedUser.age = age
            completion(updatedUser)
        }
        alert.addAction(add)
        vc.present(alert, animated: true, completion: nil)
    }
}
