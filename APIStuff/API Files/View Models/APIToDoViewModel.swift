//
//  APIToDoViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/18/22.
//

import Foundation

class APIToDoViewModel {
    
    // Creating a type alias for this completion handler (closure) for better readability
    typealias Completion = ((Error?) -> Void)?
        
    // Optional array of APIToDoItems that we will attempt to populate by retrieving data from the APIHandler
    private var models: [APIToDoItem]?
    
    // Optional error we will always return when notifying the view controller (in this case, the delegate) that we have finished fetching data
    private var error: Error?
    
    // Shared instance of APIHandler (Singleton pattern)
    private let handler = APIHandler.shared
    
    // Delegate that we assign during initialization
    private weak var delegate: APIViewModelDelegate?
    
    // Computed variable to return the number of to do items in models array
    var getCount: Int {
        return models?.count ?? 0
    }
    
    init(delegate: APIViewModelDelegate) {
        self.delegate = delegate
    }
    
    
    // 1. Closure strategy: here we pass data from the APIHandler into this viewModel using a closure named "passResult", which is an instance variable belonging to the APIHandler
    func getDataFromAPIHandler() {
        handler.getDataFromAPI(urlString: URLString.todos, ofType: [APIToDoItem]())
        
        // Implementing closure from APIHandler
        handler.passResult = { [weak self] (result: Result<Codable, Error>) in
            switch result {
            case .success(let results):
                guard let results = results as? [APIToDoItem] else {
                    return
                }
                self?.models = results
            case .failure(let error):
                self?.error = error
            }
            
            // 1.1 Using delegation to update viewController (not used in APIToDoViewController)
            self?.delegate?.didGetData(error: self?.error)
        }
    }
    
    
    // 2. Completion handler strategy: here we pass data from the APIHandler into this viewModel using a completion handler, and then with another completion handler, we pass data to the viewController
    func getDataFromAPIHandler(completion: Completion) {
        handler.getDataFromAPI(urlString: URLString.todos) { [weak self] (result: Result<[APIToDoItem], Error>) in
            switch result {
            case .success(let models):
                self?.models = models
            case .failure(let failure):
                self?.error = failure
            }
            
            // 2.1 Another completion handler, to update ViewController (used in APToDoViewController)
            completion?(self?.error)
        }
    }
    
    func getID(forItemAt index: Int) -> Int {
        return models?[index].id ?? 0
    }
    
    func getTitle(forItemAt index: Int) -> String {
        return models?[index].title ?? ""
    }
    
    func getIsCompleted(forItemAt index: Int) -> Bool {
        return models?[index].completed ?? false
    }
}

