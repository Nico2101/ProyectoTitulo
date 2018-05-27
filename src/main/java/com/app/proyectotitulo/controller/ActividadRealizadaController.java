package com.app.proyectotitulo.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Actividad;
import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.domain.Temporada;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.ActividadService;
import com.app.proyectotitulo.service.PlanEjecucionService;
import com.app.proyectotitulo.service.PredioService;
import com.app.proyectotitulo.service.SectorService;
import com.app.proyectotitulo.service.TemporadaService;

@Controller
public class ActividadRealizadaController {

	@Autowired
	private ActividadRealizadaService actividadRealizadaService;

	@Autowired
	private PlanEjecucionService planEjecucionService;

	@Autowired
	private SectorService sectorService;

	@Autowired
	private TemporadaService temporadaService;

	@Autowired
	private PredioService predioService;

	@Autowired
	private ActividadService actividadService;

	@RequestMapping(value = "asignarPlan")
	public ModelAndView asignarPlan(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			List<Sector> sectores = sectorService.listarSectores(false);
			List<Plan_Ejecucion> listaPlanes = planEjecucionService.listaPlanes(false);
			List<Temporada> listaTemporadasActivas = temporadaService.listarTemporadasActivas();
			vista.addObject("sectores", sectores);
			vista.addObject("listaPlanes", listaPlanes);
			vista.addObject("listaTemporadasActivas", listaTemporadasActivas);
			vista.setViewName("asignarPlan");
		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}

	@RequestMapping(value = "obtenerPrediosDeUnSector")
	public @ResponseBody List<Predio> obtenerPrediosDeUnSector(@RequestParam int idSector) {

		List<Predio> listaPrediosDeUnSector = predioService.listarPrediosDeUnSector(idSector);

		return listaPrediosDeUnSector;
	}

	@RequestMapping(value = "obtenerListaActididadesPlan")
	public @ResponseBody List<Actividad> obtenerListaActididadesPlan(@RequestParam int idPlan) {

		List<Actividad> listaActividades = actividadService.listaActividadesPlan(idPlan, false);

		return listaActividades;
	}

	@RequestMapping(value = "agregarPlanAPredio")
	public @ResponseBody boolean agregarPlanAPredio(@RequestParam int idPredio, @RequestParam int idTemporada,

			@RequestParam(value = "actividades[]") String[] actividades,
			@RequestParam(value = "actividadesFecha[]") Date[] actividadesFecha) throws ParseException {

		if (idPredio > 0 && idTemporada > 0 && actividades.length > 0 && actividadesFecha.length > 0) {

			Actividad_Realizada ar = new Actividad_Realizada();
			Actividad_Realizada actividadRealizada = new Actividad_Realizada();
		

			for (int i = 0; i < actividades.length; i++) {
				for (int j = 0; j < actividadesFecha.length; i++) {
					Predio predio = predioService.findByIdPredio(idPredio);
					String ids=actividades[i];
					int IDS= Integer.parseInt(ids);

					Actividad actividad = actividadService.findByIdActividad(IDS);
					Temporada temporada = temporadaService.buscarTemporada(idTemporada);
					ar.setPredio(predio);
					ar.setFechaEstimada(actividadesFecha[i]);
					ar.setTemporada(temporada);
					ar.setActividad(actividad);

					// Guardar
					actividadRealizada = actividadRealizadaService.saveAndFlush(ar);

				}
			}

			return true;
		}

		return false;
	}

}
