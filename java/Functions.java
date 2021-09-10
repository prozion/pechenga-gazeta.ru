package ru.ds.common;

import ru.ds.pac.common.Constants;

public class Functions {

	public static String crop(String text) {
		String cropped = text;
		if(text.length() > Constants.PAC_STRING_MAX_SYMBOLS) {
			int spacepos=0; int newpos = 0;
			while(newpos <= Constants.PAC_STRING_MAX_SYMBOLS) {
				spacepos = newpos;
				newpos = cropped.indexOf(' ', newpos+1);
				if(newpos == -1) break;
			}
			cropped = cropped.substring(0, spacepos);
			cropped = cropped + "..";
		}
		return cropped;
	}

	public static String crop(String text, int len) {
		String cropped = text;
		if(text.length() > len) {
			int spacepos=0; int newpos = 0;
			while(newpos <= len) {
				spacepos = newpos;
				newpos = cropped.indexOf(' ', newpos+1);
				if(newpos == -1) break;
			}
			cropped = cropped.substring(0, spacepos);
		}
		cropped = cropped + "..";
		return cropped;
	}
}