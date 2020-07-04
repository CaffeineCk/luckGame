package com.game.luckyGame.serviceImpl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.game.luckyGame.mapper.MainMapper;
import com.game.luckyGame.service.RankingService;
import com.game.luckyGame.vo.Player;


public @Service class RankingServiceImpl implements RankingService {
	
	@Autowired
	MainMapper mainMapper;
	
	@Override
	public List<Player> getRankingList(Map<String, Object> param) {
		List<Player> result = mainMapper.selectRankingList(param);
		return result;
	}
	
	@Override
	public Long getNextPlayerId() {	
		return mainMapper.selectNextPlayerId();
	}
	
	@Override
	public String getStageDescription(Player player) {
		return mainMapper.selectStageDescription(player);
	}
	
	@Override
	public Map<String, Object> getRankInfo(Player player) {
		return mainMapper.selectRankInfo(player);
	}
	
	@Override
	public void insertPlayerInfo(Player player) {	
		mainMapper.insertPlayerInfo(player);
	}
		
	@Override
	public void updatelayerInfo(Player player) {
		mainMapper.updatelayerInfo(player);
	}
}
