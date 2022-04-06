//
//  EditEventCoordinator.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 24/02/22.
//

import UIKit

final class EditEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var completion: (UIImage) -> Void = { _ in }
    
    var parentCoordinator: EventDetailCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        // create add event view controller
        // create add event view model
        // present modally controller using navigation controller
        
        let editEventViewController: AddEventViewController = .instantiate()
        let editEventViewModel = EditEventViewModel(cellBuilder: EventsCellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
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
