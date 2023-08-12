//
//  WebViewController.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/12.
//

import UIKit
import WebKit

protocol WebViewControllerDelegate: NSObjectProtocol {
    func webViewControllerDismiss(viewController: WebViewController)
}

class WebViewController: UIViewController {

    weak var delegate: WebViewControllerDelegate?
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = "Permalink"
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        setupUI()
    }
    
    func load(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

private extension WebViewController {
    func setupUI() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    @objc func backAction(){
        delegate?.webViewControllerDismiss(viewController: self)
    }
}
