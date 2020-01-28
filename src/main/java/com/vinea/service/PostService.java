package com.vinea.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.vinea.dto.PostVO;
 
public interface PostService {
    
    public List<PostVO> selectPost() throws Exception;
    
    public List<PostVO> listPost(int start, int end, String searchOption, String keyword) throws Exception;
    
    public void viewCntPost(Integer postNo) throws Exception;
    
    public void modifyPost(PostVO vo, HttpServletRequest request) throws Exception;
    
    public void deletePost(Integer postNo) throws Exception;
 
    public void deletePosts(List<String> postNoList) throws Exception;
    
    public PostVO read(Integer postNo) throws Exception;
    
    public void create(PostVO vo, HttpServletRequest request) throws Exception;

    public int countPost(String searchOption,String keyword) throws Exception;

    public List<Map<String,Object>> selectFileList(Integer postNo) throws Exception;

    public Map<String, Object> selectFile(Integer fileNo) throws Exception;
    
    public void deleteFile(Integer fileNo) throws Exception;


}
 

