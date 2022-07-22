//
//  APIViewModelDelegate.swift
//  APIStuff
//
//  Created by David Jabech on 7/20/22.
//

import Foundation

// The APIViewControllers conform to this protocol so that their respective viewModels can notify them when data has been successfully fetched from the APIHandler
    // This protocol conforms to AnyObject so that we can create a weak reference to delegate (and prevent a potential memory leak)
protocol APIViewModelDelegate: AnyObject {
    func didGetData(error: Error?)

}
