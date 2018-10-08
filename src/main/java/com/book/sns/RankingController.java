package com.book.sns;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.book.sns.dao.RankingMapper;

@Controller
public class RankingController {
	
	@Autowired SqlSession sqlsession;

	/**
	 * 이 달의 랭킹 페이지로 이동
	 * @author MinJeJung
	 */
	@RequestMapping(value = "/ranking", method = RequestMethod.GET)
	public String ranking() {
		return "monthlyRanking";
	}
	
	/**
	 * sns 사용자가 소지하고 있는 책 전체에서 가장 많이 보유한 카테고리 top 10 검색
	 * @author MinJeJung
	 * @return
	 */
	@RequestMapping(value = "/getCategoryAmount", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<List<HashMap<String, Object>>> getCategoryFrequency() {
		RankingMapper mapper = sqlsession.getMapper(RankingMapper.class);
		List<HashMap<String, Object>> result = mapper.getCategoryAmount();
		
		return new ResponseEntity<List<HashMap<String, Object>>> (result, HttpStatus.CREATED);
	}
	
	/**
	 * 가장 많이 사용된 태그 가져오기
	 * @author MinJeJung
	 * @return
	 */
	@RequestMapping(value = "/getTagFrequency", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<List<HashMap<String, Object>>> getTagFrequency() {
		RankingMapper mapper = sqlsession.getMapper(RankingMapper.class);
		List<String> result = mapper.getTags();
		
		List<HashMap<String, Object>> bindData = new ArrayList<HashMap<String, Object>>();
		for(String bundleTags : result) {
			String[] tags = bundleTags.substring(1).split("#");
			
			boolean isEqual = false;
			for(String tag : tags) {
				for(HashMap<String, Object> data: bindData) {
					String content = (String)data.get("x");
					if(content.equals(tag)) {
						isEqual = true;
						data.put("value", ((int)data.get("value")) + 1);
						break;
					}
				}
				
				if(!isEqual) {
					HashMap<String, Object> map = new HashMap<String, Object>();
					map.put("x", tag);
					map.put("value", 1);
					bindData.add(map);
				}
			}
		}
		
		System.out.println(bindData);
		
		return new ResponseEntity<List<HashMap<String, Object>>> (bindData, HttpStatus.CREATED);
	}
	
	/**
	 * 가장 많이 사용된 테그 가져오기
	 * @author MinJeJung
	 * @return
	 */
	@RequestMapping(value = "/getBuyCountDistribution", method = RequestMethod.GET)
	public @ResponseBody ResponseEntity<List<HashMap<String, Object>>> getBookCountDistribution() {
		RankingMapper mapper = sqlsession.getMapper(RankingMapper.class);
		List<HashMap<String, Object>> result = mapper.getBuyCountDistribution();
		System.out.println(result);
		
		for(HashMap<String, Object> map: result) {
			//Map으로 받아오면 키값이 전부 대문자이므로 소문자로 변환해 차트에 바인딩할 수 있도록 넣어줌
			map.put("x", map.get("BOOKCOUNT"));
			map.put("value", map.get("USERCOUNT"));
			
			map.remove("BOOKCOUNT");
			map.remove("USERCOUNT");
		}
		
		return new ResponseEntity<List<HashMap<String, Object>>> (result, HttpStatus.CREATED);
	}
	
}