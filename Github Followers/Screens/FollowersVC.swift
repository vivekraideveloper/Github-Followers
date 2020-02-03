//
//  FollowersVC.swift
//  Github Followers
//
//  Created by Vivek Rai on 19/01/20.
//  Copyright © 2020 Vivek Rai. All rights reserved.
//

import UIKit

class FollowersVC: UIViewController {

    enum Section {
        case main
    }
    
    var followers: [Follower] =  []
    var filteredFollowers: [Follower] = []
    var page = 1
    var hasMoreFollowers = true
    var userName: String!
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCllectionView()
        getFollowers(username: userName, page: page)
        confiureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.setNavigationBarHidden(false, animated: true)
   }
       
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureCllectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowersCell.self, forCellWithReuseIdentifier: FollowersCell.reuseID)
    }
    
    func configureSearchController(){
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
    }
    
    
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self]result in
            guard let self = self else {return}
           switch result{
               case .success(let followers):
                #warning("Call activityIndicator dismiss")
                self.dismissLoadingView()

                if followers.count < 100 {
                    self.hasMoreFollowers = false
                    
                }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty{
                    let message = "This user doesn't have any followers. Go and follow them 😀"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers )
               case .failure(let error):
                   self.presentGFAlertOnMainThread(title: "Bad Stuff", message: error.rawValue, buttonTitle: "OK")
                   
           }
          
       }
               
    }
    
    func confiureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowersCell.reuseID, for: indexPath) as! FollowersCell
            cell.set(follower: follower)
            
            return cell
        })
    }
   
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
        
    }

}

extension FollowersVC: UICollectionViewDelegate{
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        
        if offsetY > (contentHeight-height){
            guard hasMoreFollowers else {
                return
            }
            page += 1
            getFollowers(username: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController , animated: true)
    }
}

extension FollowersVC: UISearchResultsUpdating,  UISearchBarDelegate{
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            return
        }
        isSearching = true
        filteredFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(on: followers)
        isSearching = false
    }
}
