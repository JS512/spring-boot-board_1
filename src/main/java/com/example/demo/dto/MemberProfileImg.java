package com.example.demo.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberProfileImg {
	private int id;
	private String regDate;
	private int memberId;
	private String fileName;	
}
