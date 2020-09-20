package com.kh.tickets.common;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.text.SimpleDateFormat;

import com.oreilly.servlet.multipart.FileRenamePolicy;

public class MvcFileRenamePolicy implements FileRenamePolicy {

	/**
	 * 새 파일명 (날짜_시간_번호)
	 * 20200626_103210111_123.jpg
	 */
	@Override
	public File rename(File oldFile) {
		File newFile = null;
		
		do {
			SimpleDateFormat sdf 
				= new SimpleDateFormat("yyyyMMdd_HHmmssSSS_");
			int rndNum = (int)(Math.random()*1000); //0~999
			//확장자
			String oldName = oldFile.getName();
			String ext = "";
			int dotIndex = oldName.lastIndexOf("."); //마지막에 위치한 .의 인덱스
			if(dotIndex > -1)	//.이 존재하면
				ext = oldName.substring(dotIndex); //.jpg
			
			String newName = sdf.format(new Date()) + rndNum + ext;
			newFile = new File(oldFile.getParent(), newName);	
			
		} while(!createNewFile(newFile));
		
		System.out.println("newFile@mvcRenamePolicy = " + newFile);
		
		
		
		return newFile;
	}
	
	/**
	 * 파일이 존재하지 않으면, 파일을 생성하고, true 리턴
	 * 파일이 존재하면, 파일을 생성하지 않고, false 리턴
	 */
	private boolean createNewFile(File f) {
	    try {
	      return f.createNewFile();
	    }
	    catch (IOException ignored) {
	      return false;
	    }
	  }

}
