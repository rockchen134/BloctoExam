//
//  AppCoordinator.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import UIKit

class AppCoordinator: NSObject, Coordinator {
    
    var children: [Coordinator] = []
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let interactor = MainInteractor()
        let viewModel = MainViewModel(interactor: interactor)
        viewModel.coordinator = self
        let mainViewController = MainViewController(viewModel: viewModel)
        mainViewController.delegate = self
        navigationController.viewControllers = [mainViewController]
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func mainViewControllerPushDetail(viewControoler: MainViewController, asset: Asset) {
        let detailCoorinator = DetailCoordinator(parentViewController: viewControoler)
        detailCoorinator.delegate = self
        detailCoorinator.asset = asset
        children.append(detailCoorinator)
        detailCoorinator.start()
    }
}

extension AppCoordinator: DetailCoordinatorDelegate {
    func popToMainPage(detailCoordinator: DetailCoordinator) {
        navigationController.popViewController(animated: true)
        children.removeLast()
    }
}
