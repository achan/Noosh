extension Dictionary {
	public func merge(_ dict: Dictionary<Key,Value>) -> Dictionary<Key,Value> {
		return reduce(dict) { (acc, current) in var acc = acc
			let (key, value) = current
			acc[key] = value
			return acc
		}
	}
}
