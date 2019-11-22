package devTools;

import haxe.Constraints.Function;

class DevTools {
	public static function map(key:String, callback:Function) {
		if (untyped callback.length == 0) {
			var obj = {}
			untyped obj[key] = {
				get: callback
			}
			untyped Object.defineProperties(Window.prototype, obj);
		} else {
			Reflect.setProperty(js.Browser.window, key, callback);
		}
	}
}
/*@:enum abstract Accessor(String) from String to String {
	public var GETTER = "getter";
	public var SETTER = "setter";
	public var GETTER_SETTER = "getter_setter";
	public var METHOD = "method";
	public var OBJECT = "object";
}*/
