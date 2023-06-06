//
//  HomeInteractor.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import Foundation

protocol HomeInteracting {
    var servicing: HomeServicing { get set }
    var presenter: HomePresenting { get set }
}

final class HomeInteractor: HomeInteracting {
    var servicing: HomeServicing
    
    var presenter: HomePresenting
    
    init(servicing: HomeServicing, presenter: HomePresenting) {
        self.servicing = servicing
        self.presenter = presenter
    }
}
