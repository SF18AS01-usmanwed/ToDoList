//
//  ToDoTableViewController.swift
//  ToDoList
//
//  Created by Ousmane Ouedraogo on 3/22/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//
import UIKit;

class ToDoTableViewController: UITableViewController,
    ToDoCellDelegate {
    
    var todos: [ToDo] = [ToDo]();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        if let savedToDos: [ToDo] = ToDo.loadToDos() {   //p. 735
            todos = savedToDos;
        } else {
            todos = ToDo.loadSampleToDos()
        }

      
        navigationItem.leftBarButtonItem = editButtonItem;   //p. 740
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;   //p. 733
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return todos.count;   //p. 733
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //pp. 733, 762
        guard let cell: ToDoCell = tableView.dequeueReusableCell(withIdentifier: "ToDoCellIdentifier") as? ToDoCell else {
            fatalError("Could not dequeue a ToDoCell");
        }

        // Configure the cell...
        let todo: ToDo = todos[indexPath.row];
       
        cell.titleLabel?.text = todo.title;
        cell.isCompleteButton.isSelected = todo.isComplete; //p. 764
        cell.delegate = self;                               //p. 766
        return cell;
    }

   

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true;
    }

    // Override to support editing the table view, p. 739.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            todos.remove(at: indexPath.row);
            tableView.deleteRows(at: [indexPath], with: .fade);
            ToDo.saveToDos(todos);   //p. 769
        }
    }
    
    // MARK: - ToDoCellDelegate
    
    func checkmarkTapped(sender: ToDoCell) {   //p. 766
        if let indexPath: IndexPath = tableView.indexPath(for: sender) {   //p. 767
            var todo: ToDo = todos[indexPath.row];
            todo.isComplete = !todo.isComplete;
            todos[indexPath.row] = todo;
            tableView.reloadRows(at: [indexPath], with: .automatic);
            ToDo.saveToDos(todos);   //p. 770
        }
    }
  
    override func prepare(for segue: UIStoryboardSegue,
                             sender: Any?) {
        if segue.identifier == "showDetails" {
            let todoViewController = segue.destination
                as! ToDoViewController
            let indexPath = tableView.indexPathForSelectedRow!
            let selectedTodo = todos[indexPath.row]
            todoViewController.todo = selectedTodo
        }
    }
   
    
    @IBAction func unwindToToDoList(segue: UIStoryboardSegue) { //p. 741
        guard segue.identifier == "saveUnwind" else { return }
        let sourceViewController = segue.source as!
        ToDoViewController
        if let todo = sourceViewController.todo {
            if let selectedIndexPath =
                tableView.indexPathForSelectedRow {
                todos[selectedIndexPath.row] = todo
                tableView.reloadRows(at: [selectedIndexPath],
                                     with: .none)
            } else {
                let newIndexPath = IndexPath(row: todos.count,
                                             section: 0)
                todos.append(todo)
                tableView.insertRows(at: [newIndexPath],
                                     with: .automatic)
            }
        }
        ToDo.saveToDos(todos)
    }
   
}
