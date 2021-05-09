//
//  Icon.swift
//  CustomIcons
//
//  Created by Marin Ipati on 09/05/2021.
//

import Foundation

typealias Icons = [Icon]

struct Icon: Decodable {
    
    var title: String
    var subtitle: String
    var image: URL
    
}
