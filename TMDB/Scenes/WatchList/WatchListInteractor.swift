//
//  WatchListInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol WatchListInteractiog {
    var service: WatchListServicing { get set }
    var presenter: WatchListPresenting { get set }
}

final class WatchListInteractor: WatchListInteractiog {
    var service: WatchListServicing
    var presenter: WatchListPresenting
    
    init(service: WatchListServicing, presenter: WatchListPresenting) {
        self.service = service
        self.presenter = presenter
    }
    
}
