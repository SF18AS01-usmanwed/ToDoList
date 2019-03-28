//
//  ToDo.swift
//  To Do List
//
//  Created by Ousmane Ouedraogo on 3/22/19.
//  Copyright © 2019 Aseel Alshohatee. All rights reserved.
//
import Foundation;

struct ToDo: Codable {
    var title: String
    var isComplete: Bool
    var dueDate: Date
    var notes: String?
    
    static func loadToDos() -> [ToDo]?  {
        guard let codedToDos: Data = try? Data(contentsOf: archiveURL) else {
            return nil
        }
        
        let propertyListDecoder: PropertyListDecoder = PropertyListDecoder();
        return try? propertyListDecoder.decode([ToDo].self, from: codedToDos);
    }
    
    static func saveToDos(_ todos: [ToDo]) {
        let propertyListEncoder: PropertyListEncoder = PropertyListEncoder();
        guard let codedToDos: Data = try? propertyListEncoder.encode(todos) else {
            fatalError("could not encode ToDos");
        }
        
        if (try? codedToDos.write(to: archiveURL, options: .noFileProtection)) == nil {
            fatalError("could not save encoded ToDos");
        }
    }
    
    
    static let dueDateFormatter: DateFormatter = {
        let formatter: DateFormatter = DateFormatter();
        formatter.dateStyle = .short;
        formatter.timeStyle = .short;
        return formatter;
    }();
    
    static func loadSampleToDos() -> [ToDo] {
        let todo1 = ToDo(title: "ToDo One", isComplete: false,
                         dueDate: Date(), notes: "Notes 1")
        let todo2 = ToDo(title: "ToDo Two", isComplete: false,
                         dueDate: Date(), notes: "Notes 2")
        let todo3 = ToDo(title: "ToDo Three", isComplete: false,
                         dueDate: Date(), notes: "Notes 3")
        return [todo1, todo2, todo3]
    }
    
    static let documentsDirectory: URL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!;
    static let archiveURL: URL = documentsDirectory.appendingPathComponent("todos").appendingPathExtension("plist");
}
