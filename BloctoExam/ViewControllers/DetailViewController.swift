//
//  DetailViewController.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import UIKit

protocol DetailViewControllerDelegate: NSObjectProtocol {
    func detailViewControllerPopMainPage()
    func detailViewControllerPresentWebView(url: URL)
}

class DetailViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(DetailCollectionView.self, forCellWithReuseIdentifier: "DetailCollectionView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var bottomButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("permalink", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(bottomButtonAction), for: .touchUpInside)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let viewModel: DetailViewModel
    weak var delegate: DetailViewControllerDelegate?
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        title = viewModel.asset.collection.name
        view.backgroundColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backAction))
        setupUI()
        configureCellSize()
    }
}

private extension DetailViewController {
    func configureCellSize() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        layout?.minimumInteritemSpacing = 0
        let width = floor(view.bounds.width)
        layout?.itemSize = CGSize(width: width, height: width)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        view.addSubview(bottomButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 60.0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            bottomButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            bottomButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            bottomButton.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
    
    @objc func backAction(){
        delegate?.detailViewControllerPopMainPage()
    }
    
    @objc func bottomButtonAction() {
        delegate?.detailViewControllerPresentWebView(url: viewModel.asset.permalink)
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: DetailCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailCollectionView", for: indexPath) as! DetailCollectionView
        cell.asset = viewModel.asset
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
