//
//  ToDoViewController.swift
//  ToDoList
//
//  Created by Created by Ousmane Ouedraogo on 3/22/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//

import UIKit;

class ToDoViewController: UITableViewController {
    
    var todo: ToDo? = nil
    var isPickerHidden: Bool = true

    @IBOutlet weak var titleTextField: UITextField!   
    @IBOutlet weak var isCompleteButton: UIButton!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dueDatePickerView: UIDatePicker!;
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!  
    
    override func viewDidLoad() {
        super.viewDidLoad();

        if let todo: ToDo = todo {
            navigationItem.title = "To-Do";
            titleTextField.text = todo.title;
            isCompleteButton.isSelected = todo.isComplete;
            dueDatePickerView.date = todo.dueDate;
            notesTextView.text = todo.notes;
        } else {
            dueDatePickerView.date = Date().addingTimeInterval(60 * 60 * 24);
        }
        
        updateDueDateLabel(date: dueDatePickerView.date);
        updateSaveButtonState();
    }
    

    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState();
    }
    
    @IBAction func returnPressed(_ sender: UITextField) {
        titleTextField.resignFirstResponder();
    }
    
    @IBAction func isCompleteButtonTapped(_ sender: UIButton) {
        isCompleteButton.isSelected = !isCompleteButton.isSelected;
    }

    @IBAction func datePickerChanged(_ sender: UIDatePicker) {
        updateDueDateLabel(date: dueDatePickerView.date);
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let normalCellHeight: CGFloat = 44;
        let largeCellHeight: CGFloat = 200;
        
        switch indexPath {
        case [1, 0]:
            return isPickerHidden ? normalCellHeight : largeCellHeight;
            
        case [2, 0]:
            return largeCellHeight;
            
        default:
            return normalCellHeight
        }
    }
    

    func updateSaveButtonState() {
        let text: String = titleTextField.text ?? "";
        saveButton.isEnabled = !text.isEmpty;
    }
    
    func updateDueDateLabel(date: Date) {
        dueDateLabel.text = ToDo.dueDateFormatter.string(from: date);
    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case [1, 0]:
            isPickerHidden = !isPickerHidden;
            dueDateLabel.textColor = isPickerHidden ? .black : tableView.tintColor;
            tableView.beginUpdates();
            tableView.endUpdates();
        default:
            break;
        }
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender);
        
        guard segue.identifier == "saveUnwind" else {
            return;
        }
        
        let title: String = titleTextField.text!;
        let isComplete: Bool = isCompleteButton.isSelected;
        let dueDate: Date = dueDatePickerView.date;
        let notes: String = notesTextView.text;
        
        todo = ToDo(title: title, isComplete: isComplete, dueDate: dueDate, notes: notes);
    }

}
