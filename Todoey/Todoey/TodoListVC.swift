//
//  ViewController.swift
//  Todoey
//
//  Created by Mobeen Riaz on 23/07/2023.
//

import UIKit
import CoreData

class TodoListVC: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemsList = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
    }

    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
        
        var textView = UITextField()
        let alertDialog = UIAlertController(title: "Add new Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { completion in
            let item = Item(context: self.context)
            item.title = textView.text!
            item.isChecked = false
            self.itemsList.append(item)
            self.saveList()
            self.tableView.reloadData()
        }
        alertDialog.addAction(action)
        alertDialog.addTextField { textField in
            textField.placeholder = "Create new item"
            textView = textField
        }
        
        present(alertDialog,animated:true)
    }
    
    func saveList(){
        do{
            try context.save()
        } catch {
            print("Error saving items: \(error)")
        }
    }
    
    func fetchList(with request: NSFetchRequest<Item> = Item.fetchRequest()){
            do {
                itemsList = try context.fetch(request)
            } catch {
                print("Error Fetching items : \(error)")
            }
        self.tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = self.itemsList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemIdentifier", for: indexPath)
        cell.textLabel?.text = item.title
        cell.accessoryType = item.isChecked ? .checkmark : .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemsList[indexPath.row].isChecked = !itemsList[indexPath.row].isChecked
        tableView.reloadData()
        self.saveList()
    }
}

