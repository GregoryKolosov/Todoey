//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Gregory Kolosov on 26/04/2018.
//  Copyright © 2018 Gregory Kolosov. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    //MARK: - TableView Datasourse Method
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        let item = categoryArray[indexPath.row]
        
        cell.textLabel?.text = item.name
        
        return cell
        
    }
    
    //MARK: - Data Manipulation Methods
    func saveCategories(){
        
        do {
            try context.save()
        } catch {
            print("Error saving category \(error)")
        }
        
        self.tableView.reloadData()
    }
    
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        
        do {
            categoryArray = try context.fetch(request)
        } catch {
            print("Eroor fetching data from categories, \(error)")
        }
        
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
                let newCategory = Category(context: self.context)
                
                newCategory.name = textField.text!
                
                self.categoryArray.append(newCategory)
                
                self.saveCategories()
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
            
            destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
        
    }
    
    
    //DELETE
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
