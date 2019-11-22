package utils;

import info.Info;
#if ((air || electron) && !mobile)
import mantle.definitions.Storage;
import openfl.filesystem.File;
import openfl.filesystem.FileMode;
import openfl.filesystem.FileStream;
import haxe.Json;

/**
 * ...
 * @author P.J.Shand
 */
class DocStore {
	static var _appStorageDir:File;
	@:isVar public static var appStorageDir(get, null):File;

	static function get_appStorageDir():File {
		if (_appStorageDir == null) {
			var appId = Info.appId;

			var storageRootDir = File.documentsDirectory.resolvePath(".appStorage");
			if (!storageRootDir.exists)
				storageRootDir.createDirectory();

			_appStorageDir = storageRootDir.resolvePath(appId);
			if (!_appStorageDir.exists)
				_appStorageDir.createDirectory();
		}
		return _appStorageDir;
	}

	public var data:Dynamic = {};

	var id:String;
	var file:File;
	var fileStream:FileStream;

	function new(id:String) {
		this.id = id;

		id = id.split("\\").join("/");
		var split:Array<String> = id.split("/");
		var dir = appStorageDir;
		if (split.length > 1) {
			for (i in 0...split.length - 1) {
				dir = dir.resolvePath(split[i]);
				if (!dir.exists)
					dir.createDirectory();
			}
			id = split[split.length - 1];
		}
		file = dir.resolvePath(id + ".json");

		if (file.exists) {
			fileStream = new FileStream();
			fileStream.open(file, FileMode.READ);
			var str:String = fileStream.readUTFBytes(Math.floor(file.size));
			fileStream.close();
			try {
				data = Json.parse(str);
			} catch (e:Dynamic) {
				trace('error parsing ' + id + ', data: ' + str);
			}
		}
	}

	static public function getLocal(id:String) {
		return new DocStore(id);
	}

	public function setProperty(key:String, value:Dynamic) {
		Reflect.setProperty(data, key, value);
	}

	public function flush() {
		var str:String = Json.stringify(data);
		try {
			var checkIsValid = Json.parse(str);
			fileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(str);
			fileStream.close();
		} catch (e:Dynamic) {
			trace('abort save: error parsing ' + id);
			trace(data);
		}
	}

	public function clear() {
		data = {};
		if (file.exists)
			file.deleteFile();
	}
}
#else
import openfl.net.SharedObject;

typedef DocStore = SharedObject;
#end
