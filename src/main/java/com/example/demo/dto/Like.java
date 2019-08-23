package com.example.demo.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Like {
	private int id;
	private String regDate;
	private String relType;
	private int relId;
	private int memberId;
	private byte val;
}
