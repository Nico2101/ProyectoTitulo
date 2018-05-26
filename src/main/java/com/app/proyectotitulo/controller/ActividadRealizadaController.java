package com.app.proyectotitulo.controller;

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

import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.PredioService;
import com.app.proyectotitulo.service.SectorService;

@Controller
public class ActividadRealizadaController {

	@Autowired
	private PredioService predioService;

	@Autowired
	private SectorService sectorService;

	@Autowired
	private ActividadRealizadaService actividadRealizadaService;

	@RequestMapping(value = "registrarActividadRealizada")
	public ModelAndView registrarActividadRealizada(ModelAndView vista, HttpServletRequest request,
			HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {
			// Get Sectores
			List<Sector> listaSectores = sectorService.listarSectores(false);
			vista.addObject("listaSectores", listaSectores);

			vista.setViewName("registrarActividadRealizada");
		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}

	@RequestMapping(value = "obtenerActividadesDelPlanAsignadoAlPredio")
	public @ResponseBody List<Actividad_Realizada> obtenerActividadesDelPlanAsignadoAlPredio(
			@RequestParam int idPredio) {

		if (idPredio > 0) {
			// Buscar Predio
			Predio p = predioService.findByIdPredio(idPredio);
			if (p != null) {
				// Obtener las actividades
				List<Actividad_Realizada> listaActividades = actividadRealizadaService
						.listaActividadesAsignadasAPredio(idPredio);

				return listaActividades;
			}
		}

		return new LinkedList<Actividad_Realizada>();

	}

}
