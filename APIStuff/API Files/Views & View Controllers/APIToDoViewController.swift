//
//  APIToDoViewController.swift
//  ToDoList
//
//  Created by David Jabech on 7/16/22.
//

import UIKit

class APIToDoViewController: UIViewController {
    
    // Instance viewModel variable is optional so that we can assign delegate to self in viewDidLoad (when self is initialized/available)
    private var viewModel: APIToDoViewModel?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(APIToDoCell.self, forCellReuseIdentifier: APIToDoCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("SEE COMMENTS", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        // See Extensions.swift to see this method's definition
        view.addSubviews(tableView, commentButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = APIToDoViewModel(delegate: self)
        
        /* Although we can use the same pattern of data passing as in the APICommentViewController (because we conform to the same protocol and our viewModel has the same method as APICommentViewModel), here is the implementation of a completion handler using the other implementation of our overloaded getDataFromAPIHandler() method in the viewModel */
        
        viewModel?.getDataFromAPIHandler { [weak self] error in
            
            // ALL UI updates MUST be executed on the main thread
            DispatchQueue.main.async {
                if let error = error {
                    print(error.localizedDescription)
                    self?.presentAlert(alert: Alert.errorFetchingData, actions: [AlertAction.ok])
                }
                else {
                    self?.tableView.reloadData()
                }
            }
        }
        
        // Adding target to commentButton so that we can present the APICommentViewController
        commentButton.addTarget(self,
                                action: #selector(didTapComments),
                                for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0,
                                 y: 0,
                                 width: view.width,
                                 height: view.height-Constants.width)
        
        commentButton.frame = CGRect(x: 0,
                                     y: tableView.bottom+Constants.padding,
                                     width: Constants.width,
                                     height: Constants.height)
        
        // See Extensions.swift for definition of centerX()
        commentButton.centerX(in: view)
    }
    
    @objc private func didTapComments() {
        let vc = APICommentViewController()
        present(vc, animated: true)
    }
}

extension APIToDoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "API To Do Items"
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: APIToDoCell.identifier, for: indexPath) as? APIToDoCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: viewModel.getTitle(forItemAt: indexPath.row),
                       id: viewModel.getID(forItemAt: indexPath.row),
                       isCompleted: viewModel.getIsCompleted(forItemAt: indexPath.row))
        
        return cell
    }
}

// This delegate implementation is unused in this class (because we opted for the completion handler method instead)
    // See APICommentViewController for the implementation of this protocol
extension APIToDoViewController: APIViewModelDelegate {
    func didGetData(error: Error?) {
        DispatchQueue.main.async { [weak self] in
            if let error = error {
                print(error.localizedDescription)
                self?.presentAlert(alert: Alert.errorFetchingData, actions: [AlertAction.ok])
            }
            else {
                self?.tableView.reloadData()
            }
        }
    }
}
