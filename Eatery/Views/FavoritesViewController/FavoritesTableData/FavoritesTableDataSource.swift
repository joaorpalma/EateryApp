//
//  FavoritesTableDataSource.swift
//  Eatery
//
//  Created by João Palma on 20/11/2020.
//

import UIKit

final class FavoritesDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let _tableView: UITableView
    private let _favoriteHandler: CompletionHandlerWithParam<String>
    private let _selectHandler: CompletionHandlerWithParam<String>
    
    var favoriteList = [Favorite]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?._tableView.reloadData()
            }
        }
    }
    
    init(_ tableView: UITableView, selectHandler: @escaping CompletionHandlerWithParam<String>, unfavoriteHandler: @escaping CompletionHandlerWithParam<String>) {
        _tableView = tableView
        _selectHandler = selectHandler
        _favoriteHandler = unfavoriteHandler
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseId)
        tableView.separatorStyle = .none
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favoriteRestaurant = favoriteList[indexPath.row]
        _selectHandler(favoriteRestaurant.getId())
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseId, for: indexPath) as! FavoriteCell
        cell.selectionStyle = .none
        cell.configure(with: favoriteList[indexPath.row], favoriteHandler: _favoriteHandler)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        168
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        16
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        UIView()
    }
}
