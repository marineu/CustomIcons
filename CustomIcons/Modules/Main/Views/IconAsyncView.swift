//
//  IconAsyncView.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class IconAsyncView: UIView {
    
    var url: URL? {
        didSet {
            imageView.image = nil
            activeTask?.cancel()
            
            if let url = url {
                loadImage(at: url)
            }
        }
    }
    
    var scaleSize: CGSize = .zero
    
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        
        return imageView
    }()
    
    private var activeTask: URLSessionTask?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setup UI
    
    private func addImageView() -> Void {
        addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.topAnchor.constraint(equalTo: topAnchor)
            .isActive = true
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor)
            .isActive = true
        
        bottomAnchor.constraint(equalTo: imageView.bottomAnchor)
            .isActive = true
        
        trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
            .isActive = true
    }
    
    //MARK: - Load image asynchronous
    
    private func loadImage(at url: URL) ->Void {
        activeTask = URLSession.shared.dataTask(with: url)
        { [weak self] data, _, _ in
            guard let self = self else { return }
            guard let imageData  = data else { return }
            let image = UIImage(data: imageData)
            let scaleSize = self.scaleSize
            
            let resizedImage =
                scaleSize != .zero ? image?.resized(to: scaleSize) : image
            
            DispatchQueue.main.async { [weak self] in
                self?.imageView.image = resizedImage
            }
        }
        activeTask?.resume()
    }

}
