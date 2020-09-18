package com.kh.tickets.log4j;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Slf4j
 * 
 * Simple Logging Facade For Java
 * 
 * PSA Portable Service Abstraction
 * 구현 라이브러리를 추상레이어에 특정 라이브러리로 제어하는 것
 *	- 추상체 : slf4j
 *	- 구현체 : log4j, java.util.logging, apache.commons.logging, LogBack
 */
public class Slf4jTest {

	private Logger logger = LoggerFactory.getLogger(Slf4jTest.class);
	
	public static void main(String[] args) {
		new Slf4jTest().test();
	}
	
	private void test() {
//		logger.fatal();	//존재X
		logger.error("ERROR");
		logger.warn("WARN");
		logger.info("INFO");
		logger.debug("DEBUG");
		logger.trace("TRACE");
	}
	
	

}
