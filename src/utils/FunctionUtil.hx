package utils;

import haxe.Constraints.Function;

/**
 * ...
 * @author P.J.Shand
 */
class FunctionUtil
{
	public static function dispatch(callback:Function, params:Array<Dynamic>=null):Dynamic
	{
		if (params == null) {
			return callback();
		}
		switch (params.length) 
		{
			case 0 : return callback();
			case 1 : return callback(params[0]);
			case 2 : return callback(params[0], params[1]);
			case 3 : return callback(params[0], params[1], params[2]);
			case 4 : return callback(params[0], params[1], params[2], params[3]);
			case 5 : return callback(params[0], params[1], params[2], params[3], params[4]);
			case 6 : return callback(params[0], params[1], params[2], params[3], params[4], params[5]);
			case 7 : return callback(params[0], params[1], params[2], params[3], params[4], params[5], params[6]);
			case 8 : return callback(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7]);
			case 9 : return callback(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8]);
			case 10 : return callback(params[0], params[1], params[2], params[3], params[4], params[5], params[6], params[7], params[8], params[9]);
			default:
		}
		return null;
	}
}