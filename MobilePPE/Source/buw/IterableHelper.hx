package buw;

/**
 * helper class for Listview & Table
 * it is usefull because their real source Iterable type (List or Array) is unknown (generic)
 */
class IterableHelper {
	/**
	 * add the item to the collection
	 * @param collection an Array or a List of T class objects
	 * @param item an object of class T
	 */
	public static function add(collection : Iterable<Dynamic>, item : Dynamic) : Iterable<Dynamic> {
		if (Std.is(collection, List)) {
			(cast collection).add(item);
		} else if (Std.is(collection, Array)) {
			(cast collection).push(item);
		} else {
			throw "collection is not an Array nor a List";
		}
		return collection;
	}

	/**
	 * get the n'th item from the collection
	 * @param collection an Array or a List of T class objects
	 * @param itemPos the position of the item to retrieve ([0..collection.length[)
	 * @return an object of class T
	 */
	public static function get(collection : Iterable<Dynamic>, itemPos : Int) : Dynamic {
		var item : Dynamic = null;
		if (Std.is(collection, List)) {
			var iterator = collection.iterator();
			for (i in 0...itemPos) {
				iterator.next();
			}
			item = iterator.next();
		} else if (Std.is(collection, Array)) {
			item = (cast collection)[itemPos];
		} else {
			throw "collection is not an Array nor a List";
		}
		return item;
	}
}
