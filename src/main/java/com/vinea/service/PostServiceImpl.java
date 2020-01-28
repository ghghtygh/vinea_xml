package com.vinea.service;



import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.vinea.common.FileUtils;
import com.vinea.dao.PostDAO;
import com.vinea.dto.PostVO;
 


@Service
public class PostServiceImpl implements PostService {
 
    @Inject
    private PostDAO dao;
    
    @Autowired
    @Resource(name="fileUtils")
    private FileUtils fileUtils;
    
    
    private final static Logger logger = Logger.getLogger(PostServiceImpl.class);
    
    @Override
    public List<PostVO> selectPost() throws Exception {
 
        return dao.selectPost();
    }
    
    
    
    @Override
    public void create(PostVO vo, HttpServletRequest request) throws Exception{
    	
    	vo.setTitle(checkTitle(vo.getTitle()));
    	
    	dao.create(vo);
    	
    	
    	List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(vo,request);
    	
    	for (int i =0,size=list.size();i<size;i++){
    		dao.insertFile(list.get(i));
    	}
    	
    	
    }
    
    
    @Override
    public int countPost(String searchOption,String keyword) throws Exception{
    	
    	return dao.countPost(searchOption,keyword);
    }
    
    @Override
    public List<PostVO> listPost(int start, int pageSize, String searchOption, String keyword) throws Exception{
    	
    	List<PostVO> list =  dao.listPost(start,pageSize,searchOption,keyword);
    	
    	for (int i =0,size=list.size();i<size;i++){
    		PostVO vo = list.get(i);
    		vo.setCountFiles(dao.countFile(vo.getPostNum()));
    	}
    	return list;
    }
    
    
    @Override
	public void viewCntPost(Integer postNo) throws Exception {
		
    	dao.viewCntPost(postNo);
    	
	}
    
    
    @Override
    public void modifyPost(PostVO vo, HttpServletRequest request) throws Exception{
    	
    	vo.setTitle(checkTitle(vo.getTitle()));
    	
    	dao.modifyPost(vo);
    	
    	vo = read(vo.getPostNum());
    	
    	List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(vo,request);
    	
    	for (int i =0,size=list.size();i<size;i++){
    		
    		logger.info(list.get(i));
    		
    		dao.insertFile(list.get(i));
    	}
    }
    
    @Override
    public void deletePost(Integer postNo) throws Exception{
    	
    	dao.deletePost(postNo);
    	dao.deleteFiles(postNo);
    	
    }
    
    @Override
    public void deletePosts(List<String> postNoList) throws Exception{
    	
    	for (int i =0,size=postNoList.size();i<size;i++){
    		
    		int postNo = Integer.parseInt(postNoList.get(i));
    		
    		dao.deletePost(postNo);
    		
        	dao.deleteFiles(postNo);
    	}
    	
    }
    @Override
    public PostVO read(Integer postNo)throws Exception{
    	return dao.read(postNo);
    }
    
    @Override
    public List<Map<String,Object>> selectFileList(Integer postNo) throws Exception{
    	
    	return dao.selectFileList(postNo);
    }
    
    @Override
    public Map<String,Object> selectFile(Integer fileNo) throws Exception{
    	
    	return dao.selectFile(fileNo);
    }
    
    @Override
    public void deleteFile(Integer fileNo) throws Exception{
    	
    	dao.deleteFile(fileNo);
    }
    
    
	public String checkTitle(String title) throws Exception{
	   if (title.equals("")){
		   return "제목 없음";
	   }
		   
	   title = title.replace("<", "&lt;");
	   title = title.replace(">", "&gt;");
	   title = title.replace("  ", "&nbsp;&nbsp");
	   
	   return title;
	}
 
}
 
