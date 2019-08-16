extension UITableView {
    public func register<T: UITableViewCell>(_ classType: T.Type) {
        register(classType, forCellReuseIdentifier: String(describing: T.self))
    }

    public func register<T: UITableViewHeaderFooterView>(_ classType: T.Type) {
        register(classType, forCellReuseIdentifier: String(describing: T.self))
    }

    public func registerNib<T: UITableViewCell>(_ classType: T.Type) {
        let className = String(describing: T.self)
        register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
    }

    public func registerNib<T: UITableViewHeaderFooterView>(_ classType: T.Type) {
        let className = String(describing: T.self)
        register(UINib(nibName: className, bundle: nil), forHeaderFooterViewReuseIdentifier: className)
    }

    public func dequeue<T: UITableViewCell>(_ classType: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self), for: indexPath) as! T
    }

    public func dequeue<T: UITableViewHeaderFooterView>(_ classType: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: T.self)) as! T
    }
}
