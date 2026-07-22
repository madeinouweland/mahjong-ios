class_name Lib

static func first_or_null(array: Array, predicate: Callable):
	for item in array:
		if predicate.call(item):
			return item
	return null
