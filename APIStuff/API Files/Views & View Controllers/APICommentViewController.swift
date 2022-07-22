//
//  APICommentViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APICommentViewController: UIViewController {
    
    // Instance viewModel variable is optional so that we can assign delegate to self in viewDidLoad (when self is initialized/available)
    private var viewModel: APICommentViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(APICommentCell.self, forCellReuseIdentifier: APICommentCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = APICommentViewModel(delegate: self)
        
        // Using the viewModel to fetch the data that will populate the cells; because this view controller class conforms to the APIViewModelDelegate protocol, the viewModel can notify when data has been successfully fetched. Then we can reload the tableView cells present that data.
        viewModel?.getDataFromAPIHandler()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension APICommentViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "API Comments"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.getCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let viewModel = viewModel else {
            return UITableViewCell()
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APICommentCell.identifier, for: indexPath) as? APICommentCell else {
            return UITableViewCell()
        }
        
        cell.configure(text: viewModel.getBody(forItemAt: indexPath.row))
        return cell
    }
}

extension APICommentViewController: APIViewModelDelegate {
    
    // This function is called within the viewModel to notify this viewController that data has been successfully (or unsuccessfully) fetched
    func didGetData(error: Error?) {
        
        // ALL UI updates MUST be executed on the main thread
            // Referencing weak self to prevent any strong references to self (and preventing a potential memory leak)
        DispatchQueue.main.async { [weak self] in
            
            // Error condition
            if let error = error {
                print(error.localizedDescription)
                
                // See Extensions.swift to checkout this method's definition
                self?.presentAlert(alert: Alert.errorFetchingData, actions: [AlertAction.ok])
            }
            
            // The "happy path"
            else {
                self?.tableView.reloadData()
            }
        }
    }
}
