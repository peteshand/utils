## Overview

## FunctionUtil

This is a small utility class that adds functionality for dispatching functions where the structure of the function is not defined at compile time.

```
import haxe.Constraints.Function;

using utils.FunctionUtil;

function somefunction(callback:Function, params:Array<Dynamic>) 
{
	callback.dispatch(params);
}
```

It should be noted that that if the function structure and the length of the array do not match an error will be thrown.