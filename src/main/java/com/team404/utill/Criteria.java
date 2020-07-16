package com.team404.utill;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
public class Criteria {	
	private int pageNum;
	private int amount;
	
	
//	//검색에 필요한 데이터를 변수로 선언 
	private String searchType;
	private String searchName;
	
	
	
	
	public Criteria() {
		this(1,10);
	}

	public Criteria(int pageNum, int amount) {
		super();
		this.pageNum = pageNum;
		this.amount = amount;
	}
}
