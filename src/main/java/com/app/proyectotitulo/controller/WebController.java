package com.app.proyectotitulo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Empleado;

@Controller
public class WebController {

	@RequestMapping(value = "/")
	public ModelAndView inicioAPP(ModelAndView vista) {
		vista.addObject("empleado", new Empleado());
		vista.setViewName("login");
		return vista;
	}

}
