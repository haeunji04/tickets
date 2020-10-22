package com.kh.tickets.customerService.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Faq {
	
	private int faqNo;
	private String faqKind;
	private String faqTitle;
	private String faqContent;

}
