//
//  AddEventCoordinator.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 20/02/22.
//

import Foundation
import UIKit

final class AddEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var modalNavigationController: UINavigationController?
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventListCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // create add event view controller
        // create add event view model
        // present modally controller using navigation controller
        self.modalNavigationController = UINavigationController()
        let addEventViewController: AddEventViewController = .instantiate()
        modalNavigationController?.setViewControllers([addEventViewController], animated: false)
        let addEventViewModel = AddEventViewModel(cellBuilder: EventsCellBuilder())
        addEventViewModel.coordinator = self
        addEventViewController.viewModel = addEventViewModel
        
        if let modalNavigationController = modalNavigationController {
            navigationController.present(modalNavigationController, animated: true, completion: nil)
        }
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishSaveEvent() {
        parentCoordinator?.onSaveEvent()
        navigationController.dismiss(animated: true, completion: nil)
    }
    
    deinit {
        print("deinit from add event coordinator")
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        guard let modalNavigationController = modalNavigationController else {
            return
        }
        
        self.completion = completion

        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: modalNavigationController)
        imagePickerCoordinator.parentCoordinator = self
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func didFinishPicking(_ image:UIImage) {
        completion(image)
        modalNavigationController?.dismiss(animated: true, completion: nil)
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}