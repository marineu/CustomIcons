//
//  Constants.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import UIKit

class Constants {
    
    static let iconsDataStringUrl: String
        = "https://irapps.github.io/wzpsolutions/tests/ios-custom-icons/IconsData.json"
    
    static let iconSize =
        UIDevice.current.userInterfaceIdiom == .phone
        ? CGSize(width: 50, height: 50) : CGSize(width: 70, height: 70)
    static let mainStackSpacing: CGFloat =
        UIDevice.current.userInterfaceIdiom == .phone ? 5.0 : 10.0
    
}
