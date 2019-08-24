package com.example.demo.dto;

import java.util.Map;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Letter {
	private int id;
	private String regDate;
	private int fromMemberId;
	private int toMemberId;
	private String body;
	private Map<String, Object> extra;
}
