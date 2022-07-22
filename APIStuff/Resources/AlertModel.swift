//
//  AlertModel.swift
//  APIStuff
//
//  Created by David Jabech on 7/20/22.
//

import UIKit

// Basic model for alerts, intended for scalability

struct AlertModel {
    let title: String?
    let message: String?
    let style: UIAlertController.Style
}

struct AlertActionModel {
    let title: String
    let style: UIAlertAction.Style
    let handler: ((UIAlertAction) -> Void)?
}

struct Alert {
    static let errorFetchingData = AlertModel(title: "Sorry, there was an error fetching data",
                                              message: "Please try again later.",
                                              style: .alert)
}

struct AlertAction {
    static let ok = AlertActionModel(title: "Ok",
                                     style: .default,
                                     handler: nil)
}
