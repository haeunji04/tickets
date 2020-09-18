package com.kh.tickets.common.aop;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

@Component
@Aspect
@Slf4j
public class LoggerAspect {
	
	@Pointcut("execution(* com.kh.spring.memo..*(..))")
	public void loggerPointcut() {
		
	}
	
	@Around("loggerPointcut()")
	public Object loggerAdvice(ProceedingJoinPoint joinPoint)
							throws Throwable {
		
		//joinPoint 메소드 시그니쳐 확인
		Signature signature = joinPoint.getSignature();
		String type = signature.getDeclaringTypeName();
		String methodName = signature.getName();
		
		log.debug("[Before] {}.{}", type, methodName);
		Object obj = joinPoint.proceed();
		log.debug("[After] {}.{}", type, methodName);
	
		
		return obj;
	};
	
}
