//
//  APICommentViewModel.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import Foundation

class APICommentViewModel {
    
    // Creating a type alias for this completion handler (closure) for better readability
    typealias Completion = ((Error?) -> Void)?
    
    // Optional array of APIToDoItems that we will attempt to populate by retrieving data from the APIHandler
    private var models: [APIComment]?
    
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
        handler.getDataFromAPI(urlString: URLString.comments, ofType: [APIComment]())
        
        handler.passResult = { [weak self] (result: Result<Codable, Error>) in
            switch result {
            case .success(let results):
                guard let results = results as? [APIComment] else {
                    return
                }
                self?.models = results
            case .failure(let error):
                self?.error = error
            }
            
            // 1.1 Delegation to update ViewController (used in APICommentViewController)
            self?.delegate?.didGetData(error: self?.error)
        }
    }
    
    // 2. Completion handler strategy: here we pass data from the APIHandler into this viewModel using a completion handler, and then with another completion handler, we pass data to the viewController
    func getDataFromAPIHandler(completion: Completion) {
        handler.getDataFromAPI(urlString: URLString.comments) { [weak self] (result: Result<[APIComment], Error>) in
            switch result {
            case .success(let models):
                self?.models = models
            case .failure(let failure):
                self?.error = failure
            }
            
            // 2.1 Another completion handler, to update ViewController (not used in APICommentViewController)
            completion?(self?.error)
        }
    }
    
    func getBody(forItemAt index: Int) -> String {
        return models?[index].body ?? ""
    }
}
