package com.app.proyectotitulo.controller;

import java.sql.Date;
import java.util.LinkedList;
import java.util.List;

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

			if (plan != null) {
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

		}

		return false;
	}

	@RequestMapping(value = "listarPlanes")
	public ModelAndView listarPlanes(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			List<Plan_Ejecucion> lista = planEjecucionService.listaPlanes(false);

			if (!lista.isEmpty()) {
				vista.setViewName("listarPlanes");
				vista.addObject("listaPlanes", lista);
			}

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}

	@RequestMapping(value = "obtenerActividadesPlan")
	public @ResponseBody List<Actividad> obtenerActividadesPlan(@RequestParam int idPlan) {

		if (idPlan > 0) {
			List<Actividad> listaActividades = actividadService.listaActividadesPlan(idPlan);
			return listaActividades;
		} else {
			return new LinkedList<Actividad>();
		}
	}

	@RequestMapping(value = "obtenerListaPlanes")
	public @ResponseBody List<Plan_Ejecucion> obtenerListaPlanes() {

		List<Plan_Ejecucion> lista = planEjecucionService.listaPlanes(false);

		return lista;
	}

	@RequestMapping(value = "eliminarPlan")
	public @ResponseBody boolean eliminarPlan(@RequestParam int idPlan) {

		if (idPlan > 0) {
			// Buscar Plan
			Plan_Ejecucion p = planEjecucionService.buscarPlan(idPlan);
			if (p != null) {

				// Eliminar actividades pertenecientes al plan
				List<Actividad> actividades = p.getActividads();

				for (int i = 0; i < actividades.size(); i++) {
					Actividad a = actividadService.findByIdActividad(actividades.get(i).getIdActividad());

					if (a != null) {
						// Eliminar Actividad
						a.setActividadEliminada(true);
						actividadService.save(a);
					}
				}

				// Eliminar plan
				p.setPlanEliminado(true);
				planEjecucionService.eliminarPlan(p);

				return true;
			}
			return false;
		} else {
			return false;
		}
	}

	@RequestMapping(value = "obtenerDatosPlan")
	public @ResponseBody Plan_Ejecucion obtenerDatosPlan(@RequestParam int idPlan) {

		// Buscar el plan
		Plan_Ejecucion p = planEjecucionService.buscarPlan(idPlan);
		if (p != null) {
			System.out.println(p.getFechaCreacion());
			return p;
		} else {
			return new Plan_Ejecucion();
		}

	}

	@RequestMapping(value = "actualizarDatosPlan")
	public @ResponseBody boolean actualizarDatosPlan(@RequestParam int idPlan, @RequestParam String nombre,
			@RequestParam Date fecha) {

		// Buscar el plan
		Plan_Ejecucion p = planEjecucionService.buscarPlan(idPlan);
		if (p != null) {
			p.setFechaCreacion(fecha);
			p.setNombre(nombre);

			planEjecucionService.actualizarPlan(p);

			return true;

		}
		return false;

	}

}
