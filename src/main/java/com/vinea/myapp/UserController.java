package com.vinea.myapp;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.vinea.dto.UserInfo;
import com.vinea.dto.UserVO;
import com.vinea.service.UserService;


@Controller
public class UserController {

	private final static Logger logger = Logger.getLogger(UserController.class);
	
	@Inject
    private UserService service;
	
	// 리디렉트 방지
	@RequestMapping(value="/doSignup",method=RequestMethod.GET)
	public void doSignupGET() {
		
	}
	// 회원가입 페이지로 이동
	@RequestMapping(value="/doSignup",method=RequestMethod.POST)
	public String doSignupPOST(UserInfo userInfo) {
		return "signup";
	}
	// 리디렉트 방지
	@RequestMapping(value="/signup",method=RequestMethod.GET)
	public void signupGET() {
		
	}
	
	// 회원가입 기능 수행
	@RequestMapping(value="/signup",method=RequestMethod.POST)
	public String signupPOST(UserVO vo) throws Exception {
		
		service.create(vo);
		
		return "redirect:/";
	}
	
	// 아이디 중복 확인
	@RequestMapping(value="/idCheck", method=RequestMethod.POST)
	
		@ResponseBody
		public Map<Object, Object> idcheck( @RequestParam("userId") String userId) throws Exception {
		         
	        int count = 0;
	        
	        Map<Object, Object> map = new HashMap<Object, Object>();
	        
	        //logger.info("\n\n>>>>>>>>> 유저 아이디 : "+userId);
	        
	        count = service.idCheck(userId);
	        
	        map.put("cnt", count);
	        
	        return map;
	    }
	
	// 로그인 페이지 이동 
	@RequestMapping(value="/signin",method=RequestMethod.GET)
	public String signinGET(@RequestParam(defaultValue="")String userId,HttpSession session, Model model) throws Exception {
		
		// 로그인 되어있을 경우 메인화면 이동
		if (session.getAttribute("user")!=null){
			
			 return "redirect:/";
			 
		}else{
			
			model.addAttribute("userId",userId);
			return null;
			
		}
	}
	
	// 로그인 기능 수행
	@RequestMapping(value="/signin",method=RequestMethod.POST)
	public String signinPOST(UserInfo userInfo,HttpSession session,HttpServletRequest request,Model model) throws Exception {
		
		
		UserVO vo = service.login(userInfo);
		
		if(vo==null) {
			
			model.addAttribute("userId",userInfo.getUserId());
			return "signin";
			
		}else{
		
			session.setAttribute("user",vo);
		
			String referer = request.getHeader("Referer");
		
			return "redirect:"+referer;
		
		}
	
	}
	
	// 로그아웃 기능 수행
	@RequestMapping("/signout")
	public String signout(HttpSession session) throws Exception{
		
		session.invalidate();
		
		return "redirect:/";
	}
	

	
}
