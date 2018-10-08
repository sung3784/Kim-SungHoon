package com.book.sns.dao;

import java.util.HashMap;
import java.util.List;

public interface RankingMapper {
   public List<HashMap<String, Object>> getCategoryAmount();
   public List<String> getTags();
   public List<HashMap<String, Object>> getBuyCountDistribution();
   public int getUserCount();
      
}