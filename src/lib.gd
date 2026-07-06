class_name Lib

static func first(array: Array, predicate: Callable):
	for item in array:
		if predicate.call(item):
			return item
	return null
