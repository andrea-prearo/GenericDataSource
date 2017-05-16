//
//  PhotoViewModel.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 5/5/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import Foundation

struct PhotoViewModel {
    public let caption: String
    public let imageName: String

    public init(caption: String, imageName: String) {
        self.caption = caption
        self.imageName = imageName
    }
}
