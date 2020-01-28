package com.vinea.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.vinea.dto.UserInfo;
import com.vinea.dto.UserVO;

@Repository
public class UserDAOImpl implements UserDAO {

	@Inject
	private SqlSession sqlSession;
	
	private static final String Namespace="com.vinea.mapper.userMapper";
	
	
	@Override
	public List<UserVO> selectUser() throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList(Namespace+".selectUser");
	}

	@Override
	public void create(UserVO vo) throws Exception {
		// TODO Auto-generated method stub
		
		sqlSession.insert(Namespace+".create",vo);

	}
	
	@Override
	public int idCheck(String userId) throws Exception{
		
		return sqlSession.selectOne(Namespace+".idCheck",userId);
		
	}
	
	@Override
	public UserVO login(UserInfo userInfo) throws Exception{
		
		return sqlSession.selectOne(Namespace+".login",userInfo);
	}

}
