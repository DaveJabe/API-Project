//
//  APICommentModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import Foundation

// When we fetch data (Comments) using URLSession.shared.dataTask(), this is the model we will decode that data into

struct APIComment: Codable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
}
