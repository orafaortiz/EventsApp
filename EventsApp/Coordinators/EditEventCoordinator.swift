//
//  EditEventCoordinator.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 24/02/22.
//

import UIKit

protocol EventUpdatingCoordinator {
    func onUpdateEvent()
}

final class EditEventCoordinator: Coordinator {
    private(set) var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private var completion: (UIImage) -> Void = { _ in }
    private let event: Event
    
    var parentCoordinator: (EventUpdatingCoordinator & Coordinator)?
    
    init(event: Event, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.event = event
    }
    
    func start() {
        print("start Edit")
        let editEventViewController: EditEventViewController = .instantiate()
        let editEventViewModel = EditEventViewModel(event: event, cellBuilder: EventsCellBuilder())
        editEventViewModel.coordinator = self
        editEventViewController.viewModel = editEventViewModel
        navigationController.pushViewController(editEventViewController, animated: true)
        
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func didFinishUpdateEvent() {
        parentCoordinator?.onUpdateEvent()
        navigationController.popViewController(animated: true)
    }
    
    deinit {
        print("deinit from add event coordinator")
    }
    
    func showImagePicker(completion: @escaping (UIImage) -> Void) {
        
        self.completion = completion

        let imagePickerCoordinator = ImagePickerCoordinator(navigationController: navigationController)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.onFinishingPicking = { image in
            completion(image)
            self.navigationController.dismiss(animated: true, completion: nil)
        }
        childCoordinators.append(imagePickerCoordinator)
        imagePickerCoordinator.start()
    }
    
    func childDidFinish(_ childCoordinator: Coordinator) {
        
        if let index = childCoordinators.firstIndex(where: { coordinator -> Bool in
            return childCoordinator === coordinator
        }) {
            childCoordinators.remove(at: index)
        }
    }
}
