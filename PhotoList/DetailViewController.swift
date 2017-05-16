//
//  DetailViewController.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 5/5/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!

    var viewModel: PhotoViewModel?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let viewModel = viewModel else {
            return
        }
        title = viewModel.caption
        imageView.image = UIImage(named: viewModel.imageName)
    }
}
