//
//  MainViewController.swift
//  PhotoList
//
//  Created by Andrea Prearo on 5/5/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit
import GenericDataSource

// MARK: - View Controller
class MainViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var photosDataSource: PhotosDataSource?
    fileprivate var selectedIndexPath: IndexPath? = nil

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        photosDataSource = setUpDataSource()
    }

    // MARK: - Segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == SegueIdentifiers.showDetail.rawValue,
            let selectedIndexPath = selectedIndexPath,
            let viewModel = photosDataSource?.item(at: selectedIndexPath),
            let viewController = segue.destination as? DetailViewController else {
            return
        }
        viewController.viewModel = viewModel
    }
}

// MARK: - Data Source
class PhotosDataSource: CollectionArrayDataSource<PhotoViewModel, PhotoCell> {}

// MARK: - Private Methods
fileprivate extension MainViewController {
    func setUpDataSource() -> PhotosDataSource? {
        let viewModels = (0..<32).map {
            return PhotoViewModel(caption: "Image \($0)", imageName: String($0))
        }
        let dataSource = PhotosDataSource(collectionView: collectionView, array: viewModels)
        dataSource.collectionItemSelectionHandler = { [weak self] indexPath in
            guard let strongSelf = self else {
                return
            }
            strongSelf.selectedIndexPath = indexPath
            strongSelf.performSegue(withIdentifier: SegueIdentifiers.showDetail.rawValue, sender: strongSelf)
        }
        return dataSource
    }
}
