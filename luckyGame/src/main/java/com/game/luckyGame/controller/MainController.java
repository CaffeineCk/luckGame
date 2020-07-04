package com.game.luckyGame.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.game.luckyGame.serviceImpl.RankingServiceImpl;
import com.game.luckyGame.vo.Player;

@Controller
public class MainController {
	@Autowired
	RankingServiceImpl rankingService;
	
	@RequestMapping("/")
	public String main() {
		return "main";
	}
	
	@RequestMapping("/ranking")
	public String ranking(Model model) {
		Map<String, Object> param = new HashMap<String, Object>();
		List<Player> resultList = rankingService.getRankingList(param);
		for(int i = 0 ; i < 2 ; i++) {
			resultList.get(i).setPossibility("???");
		}
		model.addAttribute("resultList", resultList);
		return "ranking";
	}
	
	@RequestMapping(value="/save", method=RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> save(@RequestBody Player player) {
        HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("playerId", player.getPlayerId());
        List<Player> resultList = rankingService.getRankingList(param);
        if(resultList.isEmpty()) {
        	rankingService.insertPlayerInfo(player);
        } else {
        	if (Long.parseLong(resultList.get(0).getStage()) < Long.parseLong(player.getStage()))
        		rankingService.updatelayerInfo(player);
        }    
        
        String stageDescription = rankingService.getStageDescription(player);
        Map<String,Object> playerStageInfo = rankingService.getRankInfo(player);
        playerStageInfo.put("stageDescription", stageDescription);
        return playerStageInfo;
    }
	
	@RequestMapping(value="/getId", method=RequestMethod.POST)
    @ResponseBody
    public Long getId() {
        Long nextUserId = rankingService.getNextPlayerId();
        return nextUserId;
    }
}
