package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MyProfileController {

	/**
	 * myprofile ù ������
	 * */
	@RequestMapping("/myprofile.do")
	public String myprofilePage() {
		
		return "my_profile";
	}
}
