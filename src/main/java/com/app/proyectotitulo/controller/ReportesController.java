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

import com.app.proyectotitulo.DAO.ReporteProductoDAO;
import com.app.proyectotitulo.TO.DatosCosechaTO;
import com.app.proyectotitulo.TO.PlanTO;
import com.app.proyectotitulo.TO.ReporteProductoTO;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.service.PlanEjecucionService;

@Controller
public class ReportesController {

	@Autowired
	private PlanEjecucionService planEjecucionService;

	@RequestMapping(value = "rendimientoProducto")
	public ModelAndView rendimientoSector(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			vista.setViewName("rendimientoProducto");

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;
	}

	@RequestMapping(value = "obtenerDatosRendimientoProductos")
	public @ResponseBody LinkedList<DatosCosechaTO> obtenerDatosRendimientoProductos() {

		// Obtener planes
		ReporteProductoDAO reporteProductoDAO = new ReporteProductoDAO();
		LinkedList<PlanTO> listaPlanes = reporteProductoDAO.planes();

		LinkedList<ReporteProductoTO> lista = new LinkedList<>();
		LinkedList<DatosCosechaTO> datos = new LinkedList<>();
		DatosCosechaTO result = null;
		if (!listaPlanes.isEmpty()) {
			for (int i = 0; i < listaPlanes.size(); i++) {
				result = new DatosCosechaTO();
				lista = reporteProductoDAO.getDatosCosechaProducto(listaPlanes.get(i).getId());
				if (!lista.isEmpty()) {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(lista);
					datos.add(result);
				} else {
					result.setNombrePlan(listaPlanes.get(i).getNombre());
					result.setDatos(new LinkedList<>());
					datos.add(result);
				}
			}

		}

		return datos;

	}
}
