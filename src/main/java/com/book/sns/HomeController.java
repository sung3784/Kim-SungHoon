package com.book.sns;

import java.io.File;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.book.sns.dao.AlarmMapper;


@Controller
public class HomeController {
	
	private static final String UPLOADPATH = "C:\\sh\\Booksns\\src\\main\\webapp\\resources\\images\\FileRepo";
	@Autowired
	SqlSession sqlSession;
	
	//메인페이지
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home() {
		AlarmMapper mapper=sqlSession.getMapper(AlarmMapper.class);
		mapper.updateBookReading();
		
		//폴더 크리에이트는 워크스페이스 안에 이미지 위치.
		File file = new File(UPLOADPATH);
	    if (!file.exists()) {
            if (file.mkdir()) {
                System.out.println("Directory is created!");
            } else {
                System.out.println("Failed to create directory!");
            }
        }
		
		return "index";
	}
	

}
