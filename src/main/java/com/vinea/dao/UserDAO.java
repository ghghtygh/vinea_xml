package com.vinea.dao;

import java.util.List;

import com.vinea.dto.UserInfo;
import com.vinea.dto.UserVO;

public interface UserDAO {
	
	public List<UserVO> selectUser() throws Exception;
	public void create(UserVO vo)throws Exception;
	public UserVO login(UserInfo userInfo) throws Exception;
	public int idCheck(String userId) throws Exception;
}
