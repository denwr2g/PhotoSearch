//
//  ImageCollectionViewCell.swift
//  PhotoSearch
//
//  Created by deniss.lobacs on 16/05/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ImageCollectionViewCell"
    
    private let imageView = UIImageView()
    private let indicator = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addImage()
        addIndicator()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addImage() {
        contentView.addSubview(imageView)
        
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = contentView.bounds
    }
    
    func addIndicator() {
        contentView.addSubview(indicator)
        
        indicator.style = .large
        indicator.frame = CGRect(x: 0, y: 0, width: 64, height: 64)
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        imageView.image = nil
        indicator.startAnimating()
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil, let self = self else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.imageView.image = image
                self.indicator.stopAnimating()
            }
        }.resume()
        
    }
}
