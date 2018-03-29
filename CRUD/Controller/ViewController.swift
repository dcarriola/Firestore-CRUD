//
//  ViewController.swift
//  CRUD
//
//  Created by Daniel Alejandro Carriola on 3/29/18.
//  Copyright © 2018 Daniel Alejandro Carriola. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // Variables
    var users = [User]()

    override func viewDidLoad() {
        super.viewDidLoad()

        FirestoreService.instance.read(from: .users, returning: User.self) { (users) in
            self.users = users
            self.tableView.reloadData()
        }
    }

    @IBAction func addTapped(_ sender: Any) {
        AlertService.addUser(in: self) { (user) in
            FirestoreService.instance.create(for: user, in: .users)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        let user = users[indexPath.row]
        
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = String(user.age)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        AlertService.update(user, in: self) { (updatedUser) in
            FirestoreService.instance.update(for: updatedUser, in: .users)
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        let user = users[indexPath.row]
        FirestoreService.instance.delete(user, in: .users)
    }

}
