//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gregory Kolosov on 26/04/2018.
//  Copyright © 2018 Gregory Kolosov. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    
    let realm = try! Realm()

    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    //MARK: - TableView Datasourse Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No categories added yet"

        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    func save(category: Category){
        
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
        categories = realm.objects(Category.self)
        
        self.tableView.reloadData()
   }
    
    
    //MARK: - Add new Categories
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .default) { (actionCancel) in
            //Cancel!
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //what will happen once the user clicks the Add button on our UIAlert
            
            if textField.text != "" {
                
                let newCategory = Category()
                newCategory.name = textField.text!
                
                self.save(category: newCategory)
            }
            
            
        }
        
        //Set UI properties
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new name of category"
            textField = alertTextField
        }
        
        alert.addAction(actionCancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
   
    //MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! TodoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            
            destinationVC.selectedCategory = categories?[indexPath.row]
        }
        
    }
    
    
    //DELETE Categories
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        context.delete(categoryArray[indexPath.row])
//        categoryArray.remove(at: indexPath.row)
//
//        saveCategories()
//
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
}
