//
//  CategoryVC.swift
//  MakeIt
//
//  Created by Dave on 6/21/20.
//  Copyright © 2020 BroScience. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UITableViewController {

    
    var categoryArrays = [Category]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArrays.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categoryArrays[indexPath.row].name
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToItems", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! MakeItVC
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categoryArrays[indexPath.row]
            
        }
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var categoryTextField = UITextField()
        let alert = UIAlertController(title: "Add Category", message:"", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add new category", style: .default) { (alert) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = categoryTextField.text!
            self.categoryArrays.append(newCategory)
            self.saveData()
            self.tableView.reloadData()
            
        }
        alert.addTextField { (textfield) in
            textfield.placeholder = "Category Name"
            categoryTextField = textfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func saveData() {
           
           do {
               try context.save()
           } catch  {
               print("Saving Error")
           }
           
       }
       
       func loadData(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
           do {
               try categoryArrays = context.fetch(request)
           } catch  {
               print("Load Error")
           }
           tableView.reloadData()
       }
}
