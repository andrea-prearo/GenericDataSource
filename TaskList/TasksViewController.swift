//
//  TasksViewController.swift
//  TaskList
//
//  Created by Andrea Prearo on 4/28/17.
//  Copyright © 2017 Andrea Prearo. All rights reserved.
//

import UIKit

class TasksViewController: UIViewController {
    @IBOutlet weak var groupButton: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate var tasks: [Task]?
    fileprivate var taskViewModels: [[TaskViewModel]]?
    fileprivate var tasksDataSource: TasksDataSource?
    fileprivate var isGrouped: Bool = false {
        didSet {
            tasksDataSource = setUpDataSource(isGrouped: isGrouped)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = setUpTasks()
        tasksDataSource = setUpDataSource(isGrouped: isGrouped)
    }
    
    @IBAction func group(_ sender: UIBarButtonItem) {
        isGrouped = !isGrouped
        groupButton.title = isGrouped ? "Ungroup" : "Group"
        collectionView.reloadData()
    }
}

// MARK: - Private Methods
extension TasksViewController {
    func setUpTasks() -> [Task]? {
        return (1...50).map {
            return Task(name: "Task #\($0)", priority: Priority.random(), completed: false)
        }
    }

    func setUpDataSource(isGrouped: Bool) -> TasksDataSource? {
        guard let tasks = tasks else {
            return nil
        }
        if isGrouped {
            var unknownPriorities = [TaskViewModel]()
            var highPriorities = [TaskViewModel]()
            var mediumPriorities = [TaskViewModel]()
            var lowPriorities = [TaskViewModel]()
            for task in tasks {
                switch task.priority {
                case .unknown:
                    unknownPriorities.append(TaskViewModel(task: task))
                case .high:
                    highPriorities.append(TaskViewModel(task: task))
                case .medium:
                    mediumPriorities.append(TaskViewModel(task: task))
                case .low:
                    lowPriorities.append(TaskViewModel(task: task))
                }
            }
            taskViewModels = [
                unknownPriorities,
                highPriorities,
                mediumPriorities,
                lowPriorities
            ]
        } else {
            taskViewModels = [tasks.map {
                return TaskViewModel(task: $0)
            }]
        }
        guard let taskViewModels = taskViewModels else {
            return nil
        }
        let dataSource = TasksDataSource(collectionView: collectionView, array: taskViewModels)
        dataSource.isGrouped = isGrouped
        dataSource.onTaskDataSourceItemSelectionHandler = { [weak self] (indexPath, checked) in
            self?.updateItem(at: indexPath, checked: checked)
        }
        return dataSource
    }

    func updateItem(at indexPath: IndexPath, checked: Bool) {
        updateTask(at: indexPath, checked: checked)
    }
    
    func updateTask(at indexPath: IndexPath, checked: Bool) {
        guard let taskViewModels = taskViewModels else {
            return
        }
        let originalTask =  taskViewModels[indexPath.section][indexPath.row].task
        let taskIndex: Int?
        if isGrouped {
            taskIndex = tasks?.firstIndex {
                return $0 == originalTask
            }
        } else {
            taskIndex = indexPath.row
        }
        guard let index = taskIndex else {
            return
        }
        let updatedTask = Task(name: originalTask.name, priority: originalTask.priority, completed: checked)
        tasks?[index] = updatedTask
    }
}
