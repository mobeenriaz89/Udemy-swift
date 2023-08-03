//
//  ViewController.swift
//  Todo
//
//  Created by Mubeen Riaz on 21/07/2023.
//

import UIKit
import CoreData
import RealmSwift
import ChameleonFramework

class TodoListVC: SwipeTableViewController {
            
    let realm = try! Realm()
    var itemsList: Results<Item>?
    
    var selectedCategory : Category? {
        didSet{
            fetchData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        //fetchData()
        tableView.separatorStyle = .none
    }


    @IBAction func AddItem(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new TODO item", message: "", preferredStyle: .alert)
        alert.addTextField{ alertTF in
            alertTF.placeholder = "Create new item"
            textField = alertTF
        }
        let alertAction = UIAlertAction(title: "Done", style: .default) {_ in
            
            if let currentCategory = self.selectedCategory {
                do{
                    try self.realm.write{
                        let newItem = Item()
                        newItem.name = textField.text!
                        newItem.isChecked = false
                        newItem.dateCreated = Date()
                        currentCategory.items.append(newItem)
                    }
                } catch {
                    print("Error adding new item \(error)")
                }
            }
            self.tableView.reloadData()
        }
        alert.addAction(alertAction)
        
        present(alert,animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let item = itemsList?[indexPath.row]{
            cell.textLabel?.text = item.name
            if let colour = UIColor(hexString: selectedCategory!.color)?.darken(byPercentage:
                                                    CGFloat(indexPath.row)/CGFloat(itemsList!.count)) {
                cell.backgroundColor = colour
                cell.textLabel?.textColor = ContrastColorOf(colour, returnFlat: true)
            }
            
            cell.accessoryType = item.isChecked ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No items added yet"
        }
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let item = self.itemsList?[indexPath.row] {
            do{
                try realm.write{
                    item.isChecked = !item.isChecked
                }
            } catch {
                print("Error updating item value: \(error)")
            }
        }
        //itemsList[indexPath.row].isChecked = !itemsList[indexPath.row].isChecked
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func fetchData(with request: NSFetchRequest<Item> = Item.fetchRequest(), predicate: NSPredicate? = nil) {
//
//        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", self.selectedCategory!.name!)
//        if let safePredicate = predicate {
//            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [safePredicate, categoryPredicate])
//        } else {
//            request.predicate = categoryPredicate
//        }
//
//        do{
//            itemsList = try context.fetch(request)
//        } catch {
//            print("Error fetching data: \(error)")
//        }
//        tableView.reloadData()
//    }
    
    func fetchData() {
        itemsList = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        tableView.reloadData()
    }
    
    override func updateDataModel(indexPath: IndexPath) {
        do{
            if let item = itemsList?[indexPath.row]{
                try realm.write({
                    realm.delete(item)
                })
            }
            
        } catch {
            print(error)
        }
    }
    
}

extension TodoListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        itemsList = itemsList?.filter("name CONTAINS[cd] %@", searchBar.text!)
            .sorted(byKeyPath: "dateCreated",ascending: true)
        tableView.reloadData()
//        let request: NSFetchRequest<Item> = Item.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "text", ascending: true)]
//        let predicate = NSPredicate(format: "text CONTAINS[cd] %@", searchBar.text!)
//        fetchData(with: request,predicate: predicate)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text!.count == 0 {
            fetchData()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}
