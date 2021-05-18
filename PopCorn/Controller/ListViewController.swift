//
//  ListViewController.swift
//  PopCorn
//
//  Created by Baptiste POLLET on 26/04/2021.
//  Copyright © 2021 Baptiste POLLET. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [Movie] = []
    var category: Category?
    private var page = 1
    private var moreData = true
    
    private let movieRepository = MovieRepo()
    private let imageManager = ImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
        getData()
    }
    
    func configuration() {
        tableView.delegate = self
        tableView.dataSource = self
        self.title = category?.name
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func getData(){
        movieRepository.getMoviesByCategory(page: self.page, categoryId: self.category?.id, completion: { response in
            if let movies = response {
                let data = movies.toMovieByCategory()
                
                self.movies += data

                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.page += 1
            }
        })
    }
}

extension ListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        cell.prepareForReuse()
        
        let movie = movies[indexPath.item]
        cell.setInformation(movie: movie)
        
        guard let url = movie.toUrlImageUrl() else {
            return cell
        }
        
        imageManager.getImageInCache(url: url) { image, imageUrl in
            DispatchQueue.main.async() {
                if imageUrl ==  url.absoluteString {
                    cell.setImage(image)
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.alpha = 0
        
        UIView.animate(
            withDuration: 0.3,
            delay: 0.2,
            animations: {
                cell.alpha = 1
        })
        
        if indexPath.row == movies.count - 1 {
            getData()
        }
    }
    
}

extension ListViewController: UITableViewDelegate {

}
