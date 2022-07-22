//
//  APICommentCell.swift
//  ToDoList
//
//  Created by David Jabech on 7/19/22.
//

import UIKit

class APICommentCell: UITableViewCell {
    
    // Static identifier for easy access and typo preventention
    static let identifier = "APICommentCell"
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = Constants.smallFont
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // We don't intend to select these cells
        selectionStyle = .none
        
        // Adding bodyLabel to the contentView, as opposed to adding it to the UITableViewCell itself (which is possible but leads to undesireable outcomes)
        contentView.addSubview(bodyLabel)
        
        // Activating constraints for the bodyLabel so that it's centered within the cell with sufficient padding (so it doesn't touch borders)
        NSLayoutConstraint.activate([bodyLabel.layoutMarginsGuide.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: Constants.smallPadding),
                                     bodyLabel.layoutMarginsGuide.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor, constant: -Constants.smallPadding)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Method to populate the bodyLabel with text (used in cellForRowAt)
    func configure(text: String) {
        bodyLabel.text = text
    }
}
