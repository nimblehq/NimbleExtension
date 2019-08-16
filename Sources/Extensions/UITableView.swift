extension UITableView {
    public func dequeue<T: UITableViewCell>(_ name: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name)) as! T
    }

    public func dequeue<T: UITableViewCell>(_ name: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as! T
    }

    public func dequeue<T: UITableViewHeaderFooterView>(_ name: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: String(describing: name)) as! T
    }

    public func register<T: UITableViewHeaderFooterView>(_ name: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: String(describing: name))
    }

    public func register<T: UITableViewCell>(_ name: T.Type) {
        register(T.self, forCellReuseIdentifier: String(describing: name))
    }
}
