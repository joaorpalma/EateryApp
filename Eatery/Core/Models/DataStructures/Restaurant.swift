//
//  Restaurant.swift
//  Eatery
//
//  Created by João Palma on 17/11/2020.
//

import Foundation

struct Restaurant: Hashable {
    private let _restaurant: RestaurantObject
    private var _distance = ""
    private var _isFavorite = false

    init(_ restaurant: RestaurantObject, isFavorite: Bool = false, distance: String = "") {
        _restaurant = restaurant
        _isFavorite = isFavorite
        _distance = distance
    }
    
    init(_ favoriteRestaurant: Favorite) {
        _restaurant = RestaurantObject(id: favoriteRestaurant.getId(), name: favoriteRestaurant.getName(),
                                       cuisines: favoriteRestaurant.getCuisines(), thumb: "",
                                       location: LocationObject(address: "", latitude: "", longitude: ""),
                                       userRating: UserRatingObject(aggregateRating: AggregateRating.integer(0)),
                                       priceRange: 0, timings: favoriteRestaurant.getTiming())
    }
    
    func getId() -> String {
        _restaurant.id
    }
    
    func getName() -> String {
        _restaurant.name
    }
    
    func getRating() -> String? {
        let rating = _restaurant.userRating.aggregateRating
        
        switch rating {
        case .integer:
            return nil
        case .string(let val):
            return val
        }
    }
    
    func getPriceRange() -> String {
        switch _restaurant.priceRange {
        case 0, 1: return "$"
        case 2: return "$$"
        default: return "$$$"
        }
    }
    
    func getDistance() -> String {
        return _distance
    }
    
    func getThumbnail() -> String {
        let image = _restaurant.thumb.replacingOccurrences(of: "=200%", with: "=600%").replacingOccurrences(of: "A200%", with: "A800%")
                                     .replacingOccurrences(of: "C200%", with: "C600%").replacingOccurrences(of: "200&", with: "800&")
        
        return image
    }
    
    func getCuisines() -> String {
        _restaurant.cuisines.replacingOccurrences(of: ",", with: " ·")
    }
    
    func isFavorite() -> Bool {
        _isFavorite
    }
    
    mutating func tuggleFavorite() {
        _isFavorite = !_isFavorite
    }
    
    mutating func setFavorite(_ isFavorite: Bool) {
        _isFavorite = isFavorite
    }
    
    func getLocation() -> (lat: String, long: String) {
        (lat: _restaurant.location.latitude, long: _restaurant.location.longitude)
    }
    
    func getTiming() -> String {
        let timing = _restaurant.timings.split(separator: "(", maxSplits: 1, omittingEmptySubsequences: true).first
        
        guard let timeSafe = timing else { return ""}
        
        return String(timeSafe)
    }
    
    func containsSearch(_ value: String) -> Bool {
        _restaurant.name.lowercased().contains(value) || _restaurant.cuisines.lowercased().contains(value)
    }
}
