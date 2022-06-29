//
//  ViewController.swift
//  PhotoSearch
//
//  Created by deniss.lobacs on 16/05/2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let myView = MyView()
    var viewModel: ViewModel?
    var results: [Hit] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configItems()
    }
    
    func configure(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    private func configView() {
        view.addSubview(myView)
        
        myView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            myView.topAnchor.constraint(equalTo: view.topAnchor),
            myView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            myView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            myView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configItems() {
        myView.searchBar.delegate = self
        myView.collectionView.dataSource = self
        myView.collectionView.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: ImageCollectionViewCell.identifier)
    }

}

extension ViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return results.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageURLString = results[indexPath.row].webformatURL
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.identifier, for: indexPath) as? ImageCollectionViewCell else { return .init() }
        
        cell.configure(with: imageURLString)
        
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text {
            results = []
            myView.collectionView?.reloadData()
            NetworkManager.fetchPhoto(for: text) { [weak self] result in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    switch(result) {
                        
                    case .success(let photo):
                        self.results = photo
                        self.myView.collectionView?.reloadData()
                        print("Results: \(self.results.count)")
                    case .failure(let error):
                        print(error)
                    }
                }
                
            }
        }
    }
}
