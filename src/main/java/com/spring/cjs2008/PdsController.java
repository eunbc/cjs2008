package com.spring.cjs2008;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/pds")
public class PdsController {
	@RequestMapping(value="/pList", method=RequestMethod.GET)
	public String pListGet() {
		return "pds/pList";
	}
	@RequestMapping(value="/pUpload", method=RequestMethod.GET)
	public String pUploadGet() {
		return "pds/pUpload";
	}
}
