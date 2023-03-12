package common;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

public class teset {

	public static void main(String[] args) {
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 E요일");
		System.out.println(sdf.format(date));
		
		
	}

}
