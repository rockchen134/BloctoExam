//
//  MainViewController.swift
//  BloctoExam
//
//  Created by Rock Chen on 2023/8/11.
//

import UIKit
import Combine

protocol MainViewControllerDelegate: NSObjectProtocol {
    func mainViewControllerPushDetail(viewControoler: MainViewController, asset: Asset)
}

class MainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainCollectionView.self, forCellWithReuseIdentifier: "MainCollectionView")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    weak var delegate: MainViewControllerDelegate?
    private let viewModel: MainViewModel
    private var bag: Set<AnyCancellable> = []
    
    init(viewModel: MainViewModel) {
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
        title = "List"
        setupUI()
        configureCellSize()
        setupBinding()
        viewModel.fetch()
    }
}

private extension MainViewController {
    func configureCellSize() {
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.estimatedItemSize = .zero
        layout?.minimumInteritemSpacing = 0
        let width = floor(view.bounds.width / 2)
        layout?.itemSize = CGSize(width: width, height: width)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    func setupBinding() {
        viewModel.$state
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] in
                switch $0 {
                case .idle:
                    break
                case .isLoading:
                    break
                case .loaded:
                    collectionView.reloadData()
                case .error:
                    break
                }
            }
            .store(in: &bag)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MainCollectionView = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionView", for: indexPath) as! MainCollectionView
        cell.asset = viewModel.item(index: indexPath.item)
        if indexPath.item == viewModel.numberOfItems - 1 {
            viewModel.fetch()
        }
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let asset = viewModel.item(index: indexPath.item)
        delegate?.mainViewControllerPushDetail(viewControoler: self, asset: asset)
    }
}
