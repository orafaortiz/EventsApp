//
//  EventDetailCoordinator.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 22/02/22.
//

import UIKit
import CoreData

final class EventDetailCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController : UINavigationController
    private let eventID: NSManagedObjectID
    var parentCoordinator: EventListCoordinator?
    
    init(eventID: NSManagedObjectID, navigationController: UINavigationController) {
        self.eventID = eventID
        self.navigationController = navigationController
    }
    
    func start() {
        // create event detail view controller
        // event detail view model
        // push it onto navigation controller
        let detailViewController : EventDetailViewController = .instantiate()
        let eventDetailViewModel = EventDetailViewModel(eventID: eventID)
        eventDetailViewModel.coordinator = self
        //detailViewController.viewModel = eventDetailViewModel
        detailViewController.viewModel = EventDetailViewModel(eventID: eventID)
        navigationController.pushViewController(detailViewController, animated: true)
    }
    
    func didFinish() {
        parentCoordinator?.childDidFinish(self)
    }
    
    func onEditEvent(event: Event) {
        
    }
}
