//
//  EventCellViewModel.swift
//  EventsApp
//
//  Created by Rafael Ortiz on 21/02/22.
//

import UIKit

struct EventCellViewModel {
    
    let date = Date()
    private static let imageCache = NSCache<NSString, UIImage>()
    private let imageQueue = DispatchQueue(label: "imageQueue", qos: .background)
    
    private var cacheKey: String {
        event.objectID.description
    }
    
    var timeRemainingStrings: [String] {
        guard let eventDate = event.date else { return [] }
        return date.timeRemaining(until: eventDate)?.components(separatedBy: ",") ?? []
    }
    
    var dateText: String? {
        guard let eventDate = event.date else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName: String? {
        event.name
    }
    
//    var backgroundImage: UIImage? {
//        UIImage(named: "karina-halley")
//    }
    
    private let event: Event
    
    init (_ event: Event) {
        self.event = event
    }
    
    func loadImage(completion: @escaping(UIImage?) -> Void) {
        // check image cache for a value of the cache key and complete with this image value
        if let image = Self.imageCache.object(forKey: cacheKey as NSString) {
            completion(image)
        } else {
            imageQueue.async {
                
                guard let imageData = self.event.image, let image = UIImage(data: imageData) else {
                    completion(nil)
                    return
                }
                Self.imageCache.setObject(image, forKey: self.cacheKey as NSString)
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
        
    }
}
