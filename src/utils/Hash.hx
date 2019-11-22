package utils;

class Hash {
	public static function compute(s:String):Float {
		var p:Int = 31;
		var m:Int = 1000000009;
		var hash_value:Float = 0;
		var p_pow:Float = 1;
		for (i in 0...s.length) {
			var c:Int = s.charCodeAt(i);
			hash_value = (hash_value + (c + 1) * p_pow) % m;
			p_pow = (p_pow * p) % m;
		}
		return hash_value;
	}
}
