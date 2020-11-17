//
//  MainViewController.swift
//  Eatery
//
//  Created by João Palma on 17/11/2020.
//

import UIKit

final class MainViewController: BaseTabBarController<MainViewModel> {
    private let _greenColor = UIColor.Theme.mainGreen
    private let _redColor = UIColor.Theme.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _createTabBarController()
    }
    
    private func _createTabBarController() {
        self.viewControllers = [
            _createViewTab(RestaurantsViewModel.self, "Restaurants",  UIImage(systemName: "leaf")!, selectedColor: _greenColor),
            _createViewTab(FavoritesViewModel.self, "Favorites", UIImage(systemName: "heart.circle")!, selectedColor: UIColor.Theme.red)
        ]
        
        _changeTabBarTitleColors()
    }
    
    private func _createViewTab<TViewModel : ViewModel>(_ vm : TViewModel.Type, _ title : String, _ image : UIImage, selectedColor: UIColor) -> UIViewController{
        let viewController: BaseViewController<TViewModel> = DiContainer.resolveViewController(name: String(describing: vm.self))
        
        viewController.tabBarItem = UITabBarItem(title: title, image: image.withTintColor(UIColor.Theme.darkGrey, renderingMode: .alwaysOriginal),
                                                 selectedImage: image.withTintColor(selectedColor, renderingMode: .alwaysOriginal))
        
        let navigationController = UINavigationController()
        navigationController.pushViewController(viewController, animated: false)
        return navigationController
    }
    
    private func _changeTabBarTitleColors() {
        self.tabBar.items!.first!.setTitleTextAttributes([.foregroundColor: _greenColor], for: .selected)
        self.tabBar.items!.last!.setTitleTextAttributes([.foregroundColor: _redColor], for: .selected)
    }
}