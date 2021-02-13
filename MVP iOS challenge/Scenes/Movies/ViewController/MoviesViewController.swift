//
//  MoviesViewController.swift
//  MVP iOS challenge
//
//  Created by Abdalla Shawky on 5/18/20.
//  Copyright © 2020 Abdalla Shawky. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController{
    
    var presenter: MoviesPresenter?
    
    //MARK:- Viewes
    lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = false
        return tableView
    }()
    
    private lazy var addedMoviesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .never
        return collectionView
    }()
    
    private lazy var myMoviesHeaderTitle: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray4
        label.textColor = .black
        label.text = "My movies"
        label.textAlignment = .center
        return label
    }()
    
    //MARK:- ViewController lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        addingSubViews()
        myMoviesHeaderTitleConstraints()
        moviesTableViewConstraints()
        addedMoviesCollectionViewConstraints()
        registerCells()
        configuringMoviesTableView()
        configuringCollectionView()
    }
    
    //MARK:- Constrains and view hierarchy
    private func addingSubViews(){
        view.addSubview(myMoviesHeaderTitle)
        view.addSubview(moviesTableView)
        view.addSubview(addedMoviesCollectionView)
        self.navigationItem.setRightBarButton(.some(.init(barButtonSystemItem: .add, target: self, action: #selector(addButtonClicked))), animated: true)
    }
    
    private func myMoviesHeaderTitleConstraints(){
        myMoviesHeaderTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        myMoviesHeaderTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        myMoviesHeaderTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        myMoviesHeaderTitle.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    private func moviesTableViewConstraints(){
        moviesTableView.topAnchor.constraint(equalTo: addedMoviesCollectionView.bottomAnchor, constant: 0).isActive = true
        moviesTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        moviesTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        moviesTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        moviesTableView.rowHeight = 100
    }
    
    private func addedMoviesCollectionViewConstraints() {
        addedMoviesCollectionView.topAnchor.constraint(equalTo: myMoviesHeaderTitle.bottomAnchor, constant: 0).isActive = true
        addedMoviesCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        addedMoviesCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        addedMoviesCollectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        if let layout = addedMoviesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = .init(width: 100, height: 180)
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 5
        }
    }
    
    private func registerCells(){
        moviesTableView.register(UINib(nibName: MoviesTableViewCell.nibName , bundle: nil), forCellReuseIdentifier: MoviesTableViewCell.cellIdentifier)
        addedMoviesCollectionView.register(UINib(nibName: AddedMoviesCollectionViewCell.cellNibName, bundle: nil), forCellWithReuseIdentifier: AddedMoviesCollectionViewCell.cellIdentifier)
    }
    
    @objc private func addButtonClicked(){
        presenter?.navigateToAddMovies()
    }
}

extension MoviesViewController: UITableViewDataSource, UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        presenter?.sectionNames[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
  
    func configuringMoviesTableView(){
        self.moviesTableView.dataSource = self
        self.moviesTableView.prefetchDataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.presenter?.numberOfRowsInSection(for: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoviesTableViewCell.cellIdentifier, for: indexPath) as? MoviesTableViewCell else {return UITableViewCell()}
        presenter?.configure(cell: cell, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        presenter?.fetchUpcomingCells(for: indexPaths)
    }
}

extension MoviesViewController: MoviesView{
    
    func reloadCollectionView() {
        self.addedMoviesCollectionView.reloadData()
    }
    
    func reloadTableView() {
        self.moviesTableView.reloadData()
    }
    
    func fetchingDataSuccess() {
        self.moviesTableView.reloadData()
    }
}

extension MoviesViewController: UICollectionViewDataSource{
    
    func configuringCollectionView(){
        addedMoviesCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.addedMoviesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AddedMoviesCollectionViewCell.cellIdentifier, for: indexPath) as? AddedMoviesCollectionViewCell else {return UICollectionViewCell()}
        presenter?.configure(cell: cell, for: indexPath)
        return cell
    }
}

