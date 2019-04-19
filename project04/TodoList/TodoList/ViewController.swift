//
//  ViewController.swift
//  TodoList
//
//  Created by Seoyoung on 12/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

var todos = [TodoItem]()

class ViewController: UIViewController {
    @IBOutlet weak var todoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        
        todos = [TodoItem(id: "1", title: "Go to LotteWorld", date: dateFromString("2019-05-05")! , image: "child-selected"),
               TodoItem(id: "2", title: "Go to Shopping At StarField", date: dateFromString("2019-04-20")! , image: "shopping-cart-selected"),
               TodoItem(id: "3", title: "Phone to Jobs", date: dateFromString("2019-05-15")! , image: "phone-selected"),
               TodoItem(id: "4", title: "Nagoya Travel :)", date: dateFromString("2019-05-10")! , image: "travel-selected")]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        todoTableView.reloadData()
    }
    
//    func setTableViewCell(_ cell: UITableViewCell, todo: TodoItem){
//        let imageView: UIImageView = cell.viewWithTag(101) as! UIImageView
//        let titleLabel: UILabel = cell.viewWithTag(102) as! UILabel
//        let dateLabel: UILabel = cell.viewWithTag(103) as! UILabel
//
//        imageView.image = UIImage(named: todo.image)
//        titleLabel.text = todo.title
//        dateLabel.text = stringFromDate(todo.date) // label.text에 string값으로 변환해서 넣어줌
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue_detail" {
            let indexPath = todoTableView.indexPathForSelectedRow
            if let indexPath = indexPath {
            (segue.destination as! DetailViewController).todo = todos[(indexPath as NSIndexPath).row]
            }
        }
        
    }

}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath) as! TodoCell
        let path = todos[(indexPath as NSIndexPath).row]
        cell.img.image = UIImage(named: path.image)
        cell.titleLabel.text = path.title
        cell.dateLabel.text = stringFromDate(path.date)
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    // Edit Button
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        todoTableView.setEditing(editing, animated: true)
    }
    
    // Cell delete
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            todos.remove(at: (indexPath as NSIndexPath).row)
            todoTableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    // Cell Move
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return self.isEditing
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: (sourceIndexPath as NSIndexPath).row)
        todos.insert(todo, at: (destinationIndexPath as NSIndexPath).row)
    }
}

