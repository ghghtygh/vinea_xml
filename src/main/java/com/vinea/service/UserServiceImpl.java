package com.vinea.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.vinea.dao.UserDAO;
import com.vinea.dto.UserInfo;
import com.vinea.dto.UserVO;


@Service
public class UserServiceImpl implements UserService {

	@Inject
	private UserDAO dao;
	
	@Inject
	PasswordEncoder pwEncoder;
	
	@Override
	public List<UserVO> selectUser() throws Exception {
		// TODO Auto-generated method stub
		return dao.selectUser();
	}

	@Override
	public void create(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		String encPw = pwEncoder.encode(vo.getUserPw());
		vo.setUserPw(encPw);
		
		dao.create(vo);
	}
	@Override
	public int idCheck(String userId) throws Exception{
		
		return dao.idCheck(userId);
	}
	
	@Override
	public UserVO login(UserInfo userInfo) throws Exception{
		
		UserVO vo = dao.login(userInfo);
		
		if(vo==null){
			return null;
		}
		
		if(pwEncoder.matches(userInfo.getUserPw(), vo.getUserPw())){
			return vo;
		}else{
			return null;
		}
		
		
	}
	
}


