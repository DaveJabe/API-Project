//
//  APIToDoItem.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

// When we fetch data (ToDo items) using URLSession.shared.dataTask(), this is the model we will decode that data into 

struct APIToDoItem: Codable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
