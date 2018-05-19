package com.app.proyectotitulo.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.app.proyectotitulo.domain.Actividad;
import com.app.proyectotitulo.service.ActividadService;

@Controller
public class ActividadController {

	@Autowired
	private ActividadService actividadService;

	@RequestMapping(value = "obtenerDatosActividad")
	public @ResponseBody Actividad obtenerDatosActividad(@RequestParam int idActividad) {

		// Buscar actividad
		Actividad a = actividadService.findByIdActividad(idActividad);
		if (a != null) {
			return a;
		} else {
			return new Actividad();
		}

	}

	@RequestMapping(value = "actualizarActividad")
	public @ResponseBody boolean actualizarActividad(@RequestParam int idActividad,
			@RequestParam String nombreActividad) {

		// Buscar actividad
		Actividad a = actividadService.findByIdActividad(idActividad);
		if (a != null) {
			a.setNombre(nombreActividad);
			actividadService.save(a);
			return true;
		}
		return false;

	}

	@RequestMapping(value = "eliminarActividad")
	public @ResponseBody boolean eliminarActividad(@RequestParam int idActividad) {

		// Buscar actividad
		Actividad a = actividadService.findByIdActividad(idActividad);
		if (a != null) {
			a.setActividadEliminada(true);
			actividadService.save(a);
			return true;
		}
		return false;

	}

}
