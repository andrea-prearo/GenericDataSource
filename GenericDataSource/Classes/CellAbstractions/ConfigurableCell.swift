//
//  ConfigurableCell.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 4/20/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

public protocol ConfigurableCell: ReusableCell {
    associatedtype T

    func configure(_ item: T, at indexPath: IndexPath)
}
