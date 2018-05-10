package com.app.proyectotitulo.controller;

import java.sql.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Actividad;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.service.ActividadService;
import com.app.proyectotitulo.service.PlanEjecucionService;

@Controller
public class PlanEjecucionController {

	@Autowired
	private PlanEjecucionService planEjecucionService;

	@Autowired
	private ActividadService actividadService;

	@RequestMapping(value = "agregarPlan")
	public ModelAndView agregarPlan(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {
			vista.setViewName("agregarPlan-Actividad");
		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}

	@RequestMapping(value = "agregarPlanYActividades")
	public @ResponseBody boolean agregarPlanYActividades(@RequestParam String nombrePlan, @RequestParam Date fecha,
			@RequestParam(value = "actividades[]") String[] actividades, HttpServletRequest request,
			HttpSession sesion) {

		if (!nombrePlan.equalsIgnoreCase("") && fecha != null && actividades.length > 0) {

			Empleado e = (Empleado) sesion.getAttribute("empleado");

			// Agregar Plan
			Plan_Ejecucion p = new Plan_Ejecucion();
			p.setEmpleado(e);
			p.setFechaCreacion(fecha);
			p.setNombre(nombrePlan);
			p.setPlanEliminado(false);

			// Guardar plan
			Plan_Ejecucion plan = planEjecucionService.saveAndFlush(p);

			// Agregar actividades
			for (int i = 0; i < actividades.length; i++) {
				Actividad a = new Actividad();
				a.setNombre(actividades[i]);
				a.setActividadEliminada(false);
				a.setPlanEjecucion(plan);

				// Guardar
				actividadService.save(a);
			}

			return true;
		}

		return false;
	}
}
