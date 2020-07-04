package com.game.luckyGame.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.game.luckyGame.vo.Player;

public @Service interface RankingService {
	public List<Player> getRankingList(Map<String, Object> param);
	
	public Long getNextPlayerId();	
	
	public String getStageDescription(Player player);
	
	public Map<String, Object> getRankInfo(Player player);
	
	public void insertPlayerInfo(Player player);
	
	public void updatelayerInfo(Player player);
}
