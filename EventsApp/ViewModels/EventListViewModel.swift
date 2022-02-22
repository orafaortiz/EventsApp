//
//  EventListViewModel.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 20/02/22.
//

import Foundation

final class EventListViewModel {
    
    enum Cell {
        case event(EventCellViewModel)
    }
    
    private(set) var cells: [Cell] = []
    let title = "Events"
    var coordinator: EventListCoordinator?
    var onUpdate = {}
    private let coreDataManager: CoreDataManager
    
    
    init (coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
    }
    
    func viewDidLoad() {
        
        reload()
    }
    
    func reload() {
        let events = coreDataManager.fetchEvents()
        
        cells = events.map {
            .event(EventCellViewModel($0))
        }
        
        onUpdate()
    }
    
    func tappedAddEvent() {
        coordinator?.startAddEvent()
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cell(at indexPath: IndexPath) -> Cell {
        return cells[indexPath.row]
    }
}
