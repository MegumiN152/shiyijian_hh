package restful.utils;

import net.sf.json.JSONArray;

public class JSONStringToJSONArray {

	static public JSONArray getJSONArray(String jsonStr) {
		StringBuffer jsonBuffer = new StringBuffer(jsonStr);
		if (jsonStr.charAt(0) != '[') {
			jsonBuffer.insert(0, '[');
			jsonBuffer.append(']');
		}
		return JSONArray.fromObject(jsonBuffer.toString());
	}
}
