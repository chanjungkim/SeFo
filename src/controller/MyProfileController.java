package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyProfileController {

	/**
	 * myprofile 첫 페이지
	 * */
	@RequestMapping("/myprofile.do")
	public String myprofilePage() {
		
		return "my_profile";
	}
}
