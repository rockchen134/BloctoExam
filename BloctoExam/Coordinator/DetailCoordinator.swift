//
//  DetailCoordinator.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import UIKit

protocol DetailCoordinatorDelegate: NSObjectProtocol {
    func popToMainPage(detailCoordinator: DetailCoordinator)
}

class DetailCoordinator: NSObject, Coordinator {
    
    var children: [Coordinator] = []
    var asset: Asset?
    weak var delegate: DetailCoordinatorDelegate?
    
    private var parentViewController: UIViewController
    
    init(parentViewController: UIViewController) {
        self.parentViewController = parentViewController
    }
    
    func start() {
        guard let asset = asset else { return }
        let viewModel = DetailViewModel(asset: asset)
        let detailViewController = DetailViewController(viewModel: viewModel)
        detailViewController.delegate = self
        parentViewController.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension DetailCoordinator: DetailViewControllerDelegate {
    func detailViewControllerPopMainPage() {
        delegate?.popToMainPage(detailCoordinator: self)
    }
    
    func detailViewControllerPresentWebView(url: URL) {
        let webViewController = WebViewController()
        let webNavigationController = UINavigationController(rootViewController: webViewController)
        webViewController.delegate = self
        
        parentViewController.present(webNavigationController, animated: true) {
            webViewController.load(url: url)
        }
    }
}

extension DetailCoordinator: WebViewControllerDelegate {
    func webViewControllerDismiss(viewController: WebViewController) {
        viewController.dismiss(animated: true)
    }
}
