package common;

import java.sql.Date;

import lombok.Data;

@Data
public class ListVO {
	private String list;
	private String id;
	private int listNo;
	private int state;
	private Date reg_date;
	private String todo_time;
	
}
