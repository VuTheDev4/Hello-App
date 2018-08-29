//
//  HelloTableVC.swift
//  HelloApp
//
//  Created by Vu Duong on 8/29/18.
//  Copyright © 2018 Vu Duong. All rights reserved.
//

import UIKit

class HelloTableVC: UITableViewController {
    
    var hellos = [Hello]()
    
    override func viewWillAppear(_ animated: Bool) {
        getHellos()
    }
    
    func getHellos() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let helloFromCoreData = try? context.fetch(Hello.fetchRequest()) {
                if let hello = helloFromCoreData as? [Hello] {
                    hellos = hello
                    tableView.reloadData()
                }
            }
        }
    }

    @IBAction func addBtnPressed(_ sender: Any) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let newHappy = Hello(context: context)
            newHappy.name = "Hello"
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hellos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let currentHello = hellos[indexPath.row]
        cell.textLabel?.text = currentHello.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentHello = hellos[indexPath.row]
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(currentHello)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            getHellos()
        }
    }
}

