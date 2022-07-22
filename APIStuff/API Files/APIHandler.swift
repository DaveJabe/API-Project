//
//  APIHandler.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

class APIHandler {
    
    // Creating a type alias for this completion handler (closure) for better readability
    typealias Completion<T: Codable> = ((Result<T, Error>) -> Void)?
    
    // Closures don't work with generic types, so to we have to pass Result<Codable, Error>, instead of Result<T, Error>
        // Note: this would also work with Decodable; Codable is just the combined implementation of Decoable & Encodable
    var passResult: ((Result<Codable, Error>) -> Void)?
        
    // Shared instance of APIHandler (Singleton pattern)
    static let shared = APIHandler()
        
    // Creating a URLSession property so that we can inject a custom URLSession during init for testing
    let session: URLSession
        
    // Default session is .shared, during testing we customize it to .ephemeral
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // 1. Closure strategy
    func getDataFromAPI<T: Codable>(urlString: String, ofType: T) {
                
        // Check that URL is valid
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return
        }
        
        // Create a data task from which we will parse data and evaluate both the URLResponse and potential error
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            // Single guard statement to ensure all conditions are met before moving forward
                // i. data is not nil
                // ii. error is nil
                // iii. the response status code == 200
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error fetching data from API... status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            // In both the success and failure condition, we call the "passResult" closure, which is then implemented in the viewModel
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                self?.passResult?(.success(decodedData)) // Success; note that the success is just passing Codable, we will have to typecast to the type we included as T in the function call
            }
            catch(let decodingError) {
                self?.passResult?(.failure(decodingError)) // Failure
            }
        }
        
        // Resume task
        task.resume()
    }
    
    
    // 2. Completion handler strategy
    func getDataFromAPI<T: Codable>(urlString: String, completion: Completion<T>) {
                
        // Check that URL is valid
        guard let url = URL(string: urlString) else {
            print("Failed to create URL")
            return
        }
        
        // Create a data task from which we will parse data and evaluate both the URLResponse and potential error
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // Single guard statement to ensure all conditions are met before moving forward
            guard let data = data, error == nil, (response as? HTTPURLResponse)?.statusCode == 200 else {
                print("Error fetching data from API... status code: \(String(describing: (response as? HTTPURLResponse)?.statusCode))")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion?(.success(decodedData)) // Success; here we're passing T directly
            }
            catch(let decodingError) {
                completion?(.failure(decodingError)) // Failure
            }
        }
        
        // Resume task
        task.resume()
    }
}
