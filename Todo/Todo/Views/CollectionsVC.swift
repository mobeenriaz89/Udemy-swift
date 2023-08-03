//
//  CollectionsVC.swift
//  Todo
//
//  Created by Mubeen Riaz on 25/07/2023.
//

import UIKit
import CoreData
import RealmSwift
import SwipeCellKit
import ChameleonFramework

class CollectionsVC: SwipeTableViewController {
    
    var collectionsList: Results<Category>?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList()
        tableView.separatorStyle = .none
    }

    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { _ in
            let cat = Category()
            cat.name = textField.text ?? ""
            cat.color = UIColor.randomFlat().hexValue()
            self.saveList(newCategory: cat)
            self.tableView.reloadData()
        }
        alert.addAction(action)
        alert.addTextField() { tf in
            tf.placeholder = "Enter category name"
            textField = tf
        }
        present(alert, animated: true)
    }
    
    //MARK: - CRUD
    
    private func saveList(newCategory cat: Category){
        do{
            try realm.write({
                realm.add(cat)
            })
        } catch {
            print("Error saving collection list: \(error)")
        }
    }
    
    private func fetchList(){
        collectionsList = realm.objects(Category.self)
            tableView.reloadData()
    }
    
    override func updateDataModel(indexPath: IndexPath) {
        if let cat = self.collectionsList?[indexPath.row] {
             do{
                 try self.realm.write({
                     self.realm.delete(cat)
                 })
             } catch {
                 print(error)
             }

             //tableView.reloadData()
         }
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collectionsList?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.textLabel?.text = collectionsList?[indexPath.row].name ?? "No Categories added yet"
        if let color = collectionsList?[indexPath.row].color{
            cell.backgroundColor = UIColor(hexString: color)
        }
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TodoListVC
        
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.selectedCategory = collectionsList?[indexPath.row]
        }
    }
}
