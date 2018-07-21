package com.app.proyectotitulo.controller;


import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.EmpleadoService;
import com.app.proyectotitulo.service.PredioService;

import java.text.SimpleDateFormat;
import java.util.Date;

@Controller
public class WebController {

	@Autowired
	private ActividadRealizadaService actividadRealizadaService;
	
	@Autowired
	private PredioService predioService;

	@RequestMapping(value = "/")
	public ModelAndView inicioAPP(ModelAndView vista) {
		vista.setViewName("inicioPagina");
		return vista;
	}

	@RequestMapping(value = "login")
	public ModelAndView login(ModelAndView vista) {
		vista.addObject("empleado", new Empleado());
		vista.setViewName("login");
		return vista;
	}

	@RequestMapping(value = "index")
	public ModelAndView inicio(ModelAndView vista) {
		List<Actividad_Realizada> listaActividades = actividadRealizadaService.totalActividadesRealizadas();
		List<Actividad_Realizada> listaActividadesAtrasadas = actividadRealizadaService.totalActividadesAtrasadas();
		int totalPredios= predioService.totalPredios();
		int totalPrediosEnProceso= predioService.totalPrediosEnProceso();
		int totalPrediosCosechados= predioService.totalPrediosCosechados();
		int totalPrediosSinPlanAsignado= totalPredios-totalPrediosEnProceso-totalPrediosCosechados;
		vista.addObject("listaActividades", listaActividades);
		vista.addObject("listaActividadesAtrasadas", listaActividadesAtrasadas);
		vista.addObject("totalPredios", totalPredios);
		vista.addObject("totalPrediosEnProceso",totalPrediosEnProceso);
		vista.addObject("totalPrediosCosechados",totalPrediosCosechados);
		vista.addObject("totalPrediosSinPlanAsignado",totalPrediosSinPlanAsignado);
		vista.setViewName("inicio");
		return vista;
	}

}
