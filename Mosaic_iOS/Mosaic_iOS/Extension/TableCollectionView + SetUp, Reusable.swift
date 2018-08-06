import UIKit
extension UITableView  {
    func setUp(target: UITableViewDelegate & UITableViewDataSource, cell: UITableViewCell.Type? = nil) {
        self.delegate = target
        self.dataSource = target
        if let cell = cell {
            self.register(UINib(nibName: cell.id, bundle: nil), forCellReuseIdentifier: cell.id)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.id, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.id)")
        }
        return cell
    }
}
extension UICollectionView {
    func setUp(target: UICollectionViewDelegate & UICollectionViewDataSource, cell: UICollectionViewCell.Type? = nil){
        self.delegate = target
        self.dataSource = target
        if let cell = cell {
            self.register(UINib(nibName: cell.id, bundle: nil), forCellWithReuseIdentifier: cell.id)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.id, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.id)")
        }
        return cell
    }
}
