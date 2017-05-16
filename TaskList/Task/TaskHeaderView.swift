//
//  TaskHeaderView.swift
//  TaskList
//
//  Created by Andrea Prearo on 4/17/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit
import GenericDataSource

class TaskHeaderView: UICollectionReusableView, ReusableCell {
    @IBOutlet weak var sectionLabel: UILabel!

    // MARK: - ReusableCell
    public static var height: CGFloat = 32.0
}
