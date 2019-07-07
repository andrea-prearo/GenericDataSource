//
//  TasksDataSource.swift
//  GenericDataSource
//
//  Created by Andrea Prearo on 5/1/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit
import GenericDataSource

typealias OnTaskDataSourceItemSelectionHandlerType = (IndexPath, Bool) -> Void

class TasksDataSource: CollectionArrayDataSource<TaskViewModel, TaskCell> {
    var isGrouped: Bool = false
    var onTaskDataSourceItemSelectionHandler: OnTaskDataSourceItemSelectionHandlerType?

    fileprivate var headerViewModels: [TaskHeaderViewModel] = Priority.allValues().map {
        return TaskHeaderViewModel(sectionText: $0.asString)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
        if let taskCell = cell as? TaskCell {
            taskCell.onTaskCheckboxToggleHandler = { [weak self] checked in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.updateTaskViewModel(at: indexPath, checked: checked)
                strongSelf.onTaskDataSourceItemSelectionHandler?(indexPath, checked)
            }
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TaskHeaderView.reuseIdentifier, for: indexPath)
            if let header = header as? TaskHeaderView {
                header.sectionLabel.text = headerViewModels[indexPath.section].sectionText ?? ""
            }
            return header
        default:
            fatalError("Could not find supplementary view of \(kind)!")
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        guard isGrouped else {
            return CGSize.zero
        }
        return CGSize(width: collectionView.frame.size.width, height: TaskHeaderView.height)
    }
}

// MARK: - Private Methods
fileprivate extension TasksDataSource {
    func updateTaskViewModel(at indexPath: IndexPath, checked: Bool) {
        guard let viewModel = item(at: indexPath) else {
            return
        }
        let originalTask = viewModel.task
        let updatedTask = Task(name: originalTask.name, priority: originalTask.priority, completed: checked)
        let value = TaskViewModel(task: updatedTask)
        updateItem(at: indexPath, value: value)
    }
}
