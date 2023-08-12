//
//  DetailViewModel.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/12.
//

import Foundation

final class DetailViewModel {
    
    weak var coordinator: DetailCoordinator?
    
    private(set) var asset: Asset
    
    init(asset: Asset) {
        self.asset = asset
    }
}
