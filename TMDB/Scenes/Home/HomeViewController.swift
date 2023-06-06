//
//  HomeViewController.swift
//  TMDB
//
//  Created by Lucas Lima on 05/06/23.
//

import UIKit

protocol HomeDisplaying {
    
}

final class HomeViewController: BaseViewController<HomeInteracting, HomeView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
}

extension HomeViewController: HomeDisplaying {
    
}
