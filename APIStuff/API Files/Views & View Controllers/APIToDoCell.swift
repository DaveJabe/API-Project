//
//  APIToDoCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APIToDoCell: UITableViewCell {
    
    // Static identifier for easy access and typo preventention
    static let identifier = "APIToDoCell"
    
    private let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.font = Constants.semibold
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let toDoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let completionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: SFSymbol.incomplete), for: .normal)
        button.tag = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // We don't intend to select these cells
        selectionStyle = .none
        
        // Using a handy UIView extension to add multiple views to the contentView with one line of code
        contentView.addSubviews(toDoLabel, idLabel, completionButton)
        
        // Activating constraints for the toDoLabel, idLabel, and completionButton
        NSLayoutConstraint.activate([idLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.padding),
                                     idLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.padding),
                                     idLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Constants.smallPadding),
                                     idLabel.layoutMarginsGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.smallWidth),
                                     
                                     toDoLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.padding),
                                     toDoLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.padding),
                                     toDoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                                     toDoLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: idLabel.layoutMarginsGuide.trailingAnchor, constant: Constants.padding),
                                     toDoLabel.layoutMarginsGuide.trailingAnchor.constraint(equalTo: completionButton.layoutMarginsGuide.leadingAnchor, constant: -Constants.padding),
                                     
                                     completionButton.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.smallPadding),
                                     completionButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                                     completionButton.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.topAnchor),
                                     completionButton.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                                     completionButton.layoutMarginsGuide.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.smallWidth)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to add text to both labels and indicate whether the to do item is completed
    func configure(title: String, id: Int, isCompleted: Bool) {
        idLabel.text = "\(id)"
        toDoLabel.text = title
        completionButton.tag = isCompleted ? 1 : 0
        setCompletionButtonImage()
    }
    
    // Method to determine what the background image for the button will be based on completion (useful if actually implementing the ability to mark items as complete/incomplete)
    private func setCompletionButtonImage() {
        switch completionButton.tag {
        case 0:
            completionButton.setImage(UIImage(systemName: SFSymbol.incomplete), for: .normal)
        case 1:
            completionButton.setImage(UIImage(systemName: SFSymbol.complete), for: .normal)
        default:
            print("error!")
        }
    }
}


