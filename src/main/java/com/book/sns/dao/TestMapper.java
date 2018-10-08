package com.book.sns.dao;

import java.util.List;

public interface TestMapper {
	public List<Integer> getTotalBookNum();
	public int trimAuthorSpace(int bookNum);
}
