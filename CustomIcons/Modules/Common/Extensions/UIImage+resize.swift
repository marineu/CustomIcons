//
//  UIImage+resize.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

extension UIImage {
    
    public func resized(to size: CGSize, opaque: Bool = true) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, opaque, 0.0)
        
        let rect = CGRect(origin: .zero, size: size)
        draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
}
