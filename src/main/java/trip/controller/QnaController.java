package trip.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import trip.service.QnaService;

@Controller
public class QnaController {
	@Autowired
	private QnaService service;
	
	
}
