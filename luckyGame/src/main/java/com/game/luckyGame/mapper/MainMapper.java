package com.game.luckyGame.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.game.luckyGame.vo.Player;

public @Mapper interface MainMapper {
	public List<Player> selectRankingList(Map<String, Object> param);
	
	public Long selectNextPlayerId();
	
	public String selectStageDescription(Player player);
	
	public Map<String, Object> selectRankInfo(Player player);
	
	public void insertPlayerInfo(Player player);
		
	public void updatelayerInfo(Player player);
	
}
