//
//  MainViewModel.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import Foundation
import Combine

enum MainViewModelState {
    case idle
    case loaded
    case isLoading
    case error
}

final class MainViewModel {
    private enum Constants {
        static let owner = "0x85fD692D2a075908079261F5E351e7fE0267dB02"
        static let limit = 20
    }
    
    weak var coordinator: AppCoordinator?
    
    private let interactor: MainInteractorProtocol
    private var assets = [Asset]()
    private var hasMore: Bool = true
    private var offset: Int = 0
    
    var numberOfItems: Int {
        return assets.count
    }
    
    @Published var state: MainViewModelState = .idle
    
    init(interactor: MainInteractorProtocol) {
        self.interactor = interactor
    }
    
    func fetch() {
        guard state != .isLoading, hasMore else { return }
        
        let request = AssetsRequest(owner: Constants.owner, offset: offset, limit: Constants.limit)
        state = .isLoading
        interactor.getAssets(parameters: request) { [weak self] responsse in
            guard let self = self else { return }
            self.hasMore = responsse.assets.count >= Constants.limit
            self.offset+=Constants.limit
            self.assets.append(contentsOf: responsse.assets)
            self.state = .loaded
        } failure: { [weak self] error in
            guard let self = self else { return }
            self.state = .loaded
        }
    }
    
    func item(index: Int) -> Asset {
        return assets[index]
    }
}
