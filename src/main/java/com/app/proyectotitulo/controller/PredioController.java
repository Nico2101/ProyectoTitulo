package com.app.proyectotitulo.controller;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.DAO.DetallesCostosDAO;
import com.app.proyectotitulo.DAO.ReporteProductoDAO;
import com.app.proyectotitulo.TO.ActividadInsumoTO;
import com.app.proyectotitulo.TO.DatosCosechaTO;
import com.app.proyectotitulo.TO.PlanTO;
import com.app.proyectotitulo.domain.Actividad_Insumo;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Plan_Ejecucion;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.domain.Temporada;
import com.app.proyectotitulo.service.ActividadInsumoService;
import com.app.proyectotitulo.service.PredioService;
import com.app.proyectotitulo.service.SectorService;
import com.app.proyectotitulo.service.TemporadaService;

@Controller
public class PredioController {

	@Autowired
	private PredioService predioService;

	@Autowired
	private SectorService sectorService;

	@Autowired
	private TemporadaService temporadaService;

	@Autowired
	private ActividadInsumoService actividadInsumoService;

	@RequestMapping(value = "ListarPredios")
	public ModelAndView listarPredios(ModelAndView vista, @Valid @ModelAttribute("predio") Predio predio,
			HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			if (e.getCargo().equalsIgnoreCase("Administrador")) {

				List<Predio> listaPredios = predioService.listarTodosLosPredios(false, false);
				List<Sector> sectores = sectorService.listarSectores(false);
				vista.addObject("listaPredios", listaPredios);
				vista.addObject("sectores", sectores);
				vista.setViewName("listarPredios");

			} else {
				vista.setViewName("login");
				vista.addObject("empleado", new Empleado());
				vista.addObject("accesoNoAutorizado", "No tiene acceso a esta funcionalidad");
			}

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;

	}

	@RequestMapping(value = "agregarPredio")
	public @ResponseBody Predio agregarPredio(@RequestParam String nombre, @RequestParam int superficie,
			@RequestParam int idSector) {

		System.out.println(nombre);
		System.out.println(superficie);
		System.out.println(idSector);
		Predio p = new Predio();
		Predio predio = new Predio();
		Sector sector = sectorService.findByIdSector(idSector);
		if (!nombre.equalsIgnoreCase("") && superficie > 0 && sector != null) {
			p.setNombre(nombre);
			p.setSuperficie(superficie);
			p.setSector(sector);// quiero guardar el id del sector que estoy agregando
			// Guardar
			predio = predioService.saveAndFlush(p);
			return predio;

		}

		return predio;

	}

	@RequestMapping(value = "obtenerTotalSuperficePrediosSector")
	public @ResponseBody Integer obtenerTotalSuperficie(@RequestParam int idSector) {

		Integer TotalSuperficieAcomulado = predioService.TotalSuperficiePredios(idSector);
		if (TotalSuperficieAcomulado != null) {
			return TotalSuperficieAcomulado;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "obtenerListaPredios")
	public @ResponseBody List<Predio> obtenerListaPredios() {

		List<Predio> lista = predioService.listarTodosLosPredios(false, false);

		return lista;
	}

	@RequestMapping(value = "eliminarPredio")
	public @ResponseBody boolean eliminarPredio(@RequestParam int idPredio) {

		Predio p = predioService.findByIdPredio(idPredio);
		if (p != null) {
			p.setPredioEliminado(true);

			predioService.eliminarPredio(p);
			return true;
		}

		return false;
	}

	// Permite eliminar los predios asociados a un sector
	@RequestMapping(value = "eliminarPrediosDeUnSector")
	public @ResponseBody boolean eliminarPrediosDeUnSector(@RequestParam int idSector) {

		List<Predio> lista1 = predioService.listarTodosLosPredios(false, false);
		Sector s = sectorService.findByIdSector(idSector);

		if (s != null) {
			for (int i = 0; i < lista1.size(); i++) {
				Predio p = predioService.findByIdPredio(lista1.get(i).getIdPredio());
				if (lista1.get(i).getSector().equals(s)) {
					p.setPredioEliminado(true);
					predioService.eliminarPredio(p);

				}

			}
		}
		return true;
	}

	@RequestMapping(value = "obtenerPredioAEditar")
	public @ResponseBody Predio obtenerPredioAEditar(@RequestParam int idPredio) {

		Predio p = predioService.findByIdPredio(idPredio);
		if (p != null) {
			return p;
		} else {
			return new Predio();
		}

	}

	@RequestMapping(value = "editarPredio")
	public @ResponseBody boolean editar(@RequestParam int idPredio, @RequestParam String nombre,
			@RequestParam int superficie, @RequestParam int idSector) {

		System.out.println(nombre);
		System.out.println(superficie);
		System.out.println(idSector);

		Predio p = new Predio();

		// busca el sector
		Sector sector = sectorService.findByIdSector(idSector);

		if (!nombre.equalsIgnoreCase("") && !(superficie == (0)) && idSector > 0 && sector != null) {

			// Buscar el predio
			p = predioService.findByIdPredio(idPredio);
			p.setNombre(nombre);
			p.setSuperficie(superficie);
			p.setSector(sector);

			// Guardar el predio editado
			predioService.editarPredio(p);
			return true;

		}

		return false;

	}

	@RequestMapping(value = "obtenerPrediosDelSectorConPlanAsignado")
	public @ResponseBody List<Predio> obtenerPrediosDelSectorConPlanAsignado(@RequestParam int idSector) {

		if (idSector > 0) {
			// Buscar Sector
			Sector s = sectorService.findByIdSector(idSector);

			if (s != null) {
				// Obtener los predios con plan asignado del sector
				List<Predio> listaPredio = predioService.getListaPrediosConPlanesAsignados(idSector);
				return listaPredio;
			}
		}

		return new LinkedList<Predio>();

	}

	@RequestMapping(value = "MostrarEstadoPredios")
	public ModelAndView mostrarEstadoPredios(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			List<Sector> listaSectores = sectorService.listarSectores(false);
			vista.addObject("listaSectores", listaSectores);
			vista.setViewName("mostrarEstadoPredios");

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;

	}

	@RequestMapping(value = "obtenerEstadoDeLosPredios")
	public @ResponseBody List<Predio> obtenerEstadoDeLosPredios(@RequestParam int idSector) {

		List<Predio> lista = predioService.obtenerEstadoPredios(idSector);

		return lista;
	}

	@RequestMapping(value = "obtenerPrediosDelSectorConPlanAsignaParaComparacion")
	public @ResponseBody List<Predio> obtenerPrediosDelSectorConPlanAsignaParaComparacion(@RequestParam int idSector,
			@RequestParam int idTemporada) {

		if (idSector > 0 && idTemporada > 0) {
			// Buscar Sector
			Sector s = sectorService.findByIdSector(idSector);

			if (s != null) {
				// Obtener los predios con plan asignado del sector
				List<Predio> listaPredio = predioService.listaPrediosConPlanesAsigandosParaComparacion(idTemporada,
						idSector);
				return listaPredio;
			}
		}

		return new LinkedList<Predio>();

	}

	@RequestMapping(value = "ListarCostosTotalesPorPredio")
	public ModelAndView listarCostosTotalesPorPredio(ModelAndView vista, HttpServletRequest request,
			HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			if (e.getCargo().equalsIgnoreCase("Administrador") || e.getCargo().equalsIgnoreCase("Gerente")) {

				List<Temporada> listaTemporadas = temporadaService.listaTemporadas(false);
				vista.addObject("listaTemporadas", listaTemporadas);

				// Get Sectores
				List<Sector> listaSectores = sectorService.listarSectores(false);
				vista.addObject("listaSectores", listaSectores);
				vista.setViewName("costosTotalesPredio");

			} else {
				vista.setViewName("login");
				vista.addObject("empleado", new Empleado());
				vista.addObject("accesoNoAutorizado", "No tiene acceso a esta funcionalidad");
			}

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}

		return vista;

	}

	@RequestMapping(value = "costosPorPredio")
	public @ResponseBody Integer costosPorPredio(@RequestParam int idPredio, @RequestParam int idTemporada) {

		Integer costos = actividadInsumoService.obtenerCostosTotales(idPredio, idTemporada);
		if (costos != null) {

			return costos;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "obtenerDetalles")
	public @ResponseBody LinkedList<ActividadInsumoTO> obtenerDetallesDeLosCostos(@RequestParam int idPredio,
			@RequestParam int idTemporada) {

		// Obtengo los detalles del costo total
		DetallesCostosDAO detallesCostosDAO = new DetallesCostosDAO();
		LinkedList<ActividadInsumoTO> listaDetalles = detallesCostosDAO.detallesCostos(idPredio, idTemporada);

		// System.out.print(listaDetalles);
		return listaDetalles;

	}

	@RequestMapping(value = "obtenerPrediosDelSectorYTemporadaSeleccionada")
	public @ResponseBody List<Predio> obtenerPrediosDelSectorYTemporadaSeleccionada(@RequestParam int idSector,
			@RequestParam int idTemporada) {

		List<Predio> lista = predioService.getPrediosParaCostos(idTemporada, idSector);
		return lista;

	}

	@RequestMapping(value = "verificarNombreRepetidoPredio")
	public @ResponseBody boolean verificarNombreRepedtidoPredio(@RequestParam String nombre) {

		List<Predio> predio = predioService.findByNombre(nombre);
		if (!predio.isEmpty()) {
			return true;
		}
		return false;
	}

}
