package com.book.sns;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.book.sns.dao.TestMapper;

@Controller
public class TestController {
	
	@Autowired SqlSession sqlSession;

	// 저장된 책 중 작가 컬럼의 첫 글자가 공백일 경우 제거하도록
	@RequestMapping(value = "/trimAuthors", method = RequestMethod.GET)
	public String trimAuthors() {
		TestMapper mapper = sqlSession.getMapper(TestMapper.class);
		List<Integer> totalBookNums = mapper.getTotalBookNum();
		System.out.println("변경해야할 책 번호 : " + totalBookNums);
		
		int count = 0;
		for (int bookNum : totalBookNums) {
			int result = mapper.trimAuthorSpace(bookNum);
			if(result == 1) {
				count += result;
				System.out.println(bookNum + "  업데이트 성공");
			} else {
				System.out.println(bookNum + " 업데이트 실패");
			}
		}
		System.out.println("총 " + count + "　변경되었습니다.");
		
		return "redirect:/";
	}
}
