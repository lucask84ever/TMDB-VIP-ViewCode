//
//  WatchListFactory.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

class WatchListFactory {
    static func make() -> WatchListViewController {
        let service = WatchListService()
        let presenter = WatchListPresenter()
        let interactor = WatchListInteractor(service: service, presenter: presenter)
        let viewController = WatchListViewController(interactor: interactor)
        return viewController
    }
}
