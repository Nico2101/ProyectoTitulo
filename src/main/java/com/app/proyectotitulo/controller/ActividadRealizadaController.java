
package com.app.proyectotitulo.controller;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.LinkedList;
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
import com.app.proyectotitulo.domain.Actividad_Insumo;
import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.service.ActividadInsumoService;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.InsumoService;
import com.app.proyectotitulo.service.PredioService;
import com.app.proyectotitulo.service.SectorService;

@Controller
public class ActividadRealizadaController {

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
	
	@Autowired
	private InsumoService insumoService;

	@Autowired
	private ActividadRealizadaService actividadRealizadaService;

	@Autowired
	private ActividadInsumoService actividadInsumoService;

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

	@RequestMapping(value = "registrarActividadRealizada")
	public ModelAndView registrarActividadRealizada(ModelAndView vista, HttpServletRequest request,
			HttpSession sesion) {

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
			@RequestParam(value = "actividadesFecha[]") String[] actividadesFecha) {

		if (idPredio > 0 && idTemporada > 0 && actividades.length > 0 && actividadesFecha.length > 0) {

			for (int j = 0; j < actividadesFecha.length; j++) {

				Actividad_Realizada ar = new Actividad_Realizada();
				Predio predio = predioService.findByIdPredio(idPredio);

				Actividad actividad = actividadService.findByIdActividad(Integer.parseInt(actividades[j]));
				Temporada temporada = temporadaService.buscarTemporada(idTemporada);

				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
				LocalDate date = LocalDate.parse(actividadesFecha[j], formatter);
				Date fechaESTIMADA = java.sql.Date.valueOf(date);

				ar.setPredio(predio);
				ar.setFechaEstimada(fechaESTIMADA);
				ar.setTemporada(temporada);
				ar.setActividad(actividad);

				// Guardar
				actividadRealizadaService.save(ar);

			}
		}

		return true;
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

	@RequestMapping(value = "guardarDatosInsumoUtilizado")
	public @ResponseBody boolean guardarDatosInsumoUtilizado(@RequestParam int idActividadRealizada,
			@RequestParam int idInsumo, @RequestParam int cantidad, @RequestParam int costo) {

		if (idActividadRealizada > 0 && idInsumo > 0 && cantidad > 0 && costo > 0) {
			// Buscar Insumo
			Insumo i = insumoService.findByIdInsumo(idInsumo);

			// Buscar Actividad Relizada
			Actividad_Realizada ar = actividadRealizadaService.buscarActividad(idActividadRealizada);

			if (i != null && ar != null) {
				// Guardar los datos en la tabla intermedia entre Insumo y Actividad_Realizada
				Actividad_Insumo ai = new Actividad_Insumo();

				ai.setActividadRealizada(ar);
				ai.setInsumo(i);
				ai.setCantidad(cantidad);
				ai.setCosto(costo);

				// Guardar
				actividadInsumoService.save(ai);
				return true;

			} else {
				return false;
			}
		}

		return false;

	}

	@RequestMapping(value = "obtenerInsumosUtilizadosEnLaActividad")
	public @ResponseBody List<Actividad_Insumo> obtenerInsumosUtilizadosEnLaActividad(@RequestParam int idActividad) {

		if (idActividad > 0) {
			// Buscar actividad realizada
			Actividad_Realizada ar = actividadRealizadaService.buscarActividad(idActividad);
			if (ar != null) {
				// Obtener lista de insumos utilizados en la actividad
				List<Actividad_Insumo> listaInsumosUtilizados = actividadInsumoService
						.listaInsumosActividadRealizada(idActividad);

				return listaInsumosUtilizados;
			} else {
				return new LinkedList<Actividad_Insumo>();
			}
		} else {
			return new LinkedList<Actividad_Insumo>();
		}

	}

	@RequestMapping(value = "eliminarInsumoUtilizadoEnLaActividad")
	public @ResponseBody boolean eliminarInsumoUtilizadoEnLaActividad(@RequestParam int idActividadInsumo) {

		if (idActividadInsumo > 0) {
			// Buscar actividad insumo
			Actividad_Insumo ai = actividadInsumoService.buscarActividadInsumo(idActividadInsumo);
			if (ai != null) {
				actividadInsumoService.delete(ai);
				return true;
			} else {
				return false;
			}
		} else {
			return false;
		}

	}

	@RequestMapping(value = "obtenerDatosActividadInsumo")
	public @ResponseBody Actividad_Insumo obtenerDatosActividadInsumo(@RequestParam int idActividadInsumo) {

		if (idActividadInsumo > 0) {
			// Buscar
			Actividad_Insumo ai = actividadInsumoService.buscarActividadInsumo(idActividadInsumo);
			if (ai != null) {
				return ai;
			} else {
				return new Actividad_Insumo();
			}
		} else {
			return new Actividad_Insumo();
		}

	}

	@RequestMapping(value = "actualizarInsumoUtilizadoEnActividad")
	public @ResponseBody boolean actualizarInsumoUtilizadoEnActividad(@RequestParam int idActividadInsumo,
			@RequestParam int cantidad, @RequestParam int costo) {

		if (idActividadInsumo > 0 && cantidad > 0 && costo > 0) {
			// Buscar la actividad insumo
			Actividad_Insumo ai = actividadInsumoService.buscarActividadInsumo(idActividadInsumo);
			if (ai != null) {
				ai.setCantidad(cantidad);
				ai.setCosto(costo);

				// Guardar
				actividadInsumoService.save(ai);
				return true;
			}
		}

		return false;
	}

	@RequestMapping(value = "verificarActividadInsumo")
	public @ResponseBody boolean verificarActividadInsumo(@RequestParam int idActividadRealizada) {

		if (idActividadRealizada > 0) {
			// Verificar si la actividad tiene insumos agregados
			List<Actividad_Insumo> listaInsumosActividad = actividadInsumoService
					.listaInsumosActividadRealizada(idActividadRealizada);

			if (listaInsumosActividad.size() > 0) {
				return true;
			} else {
				return false;
			}
		}

		return false;
	}

	@RequestMapping(value = "obtenerDatosActividadRealizada")
	public @ResponseBody Actividad_Realizada obtenerDatosActividadRealizada(@RequestParam int idActividadRealizada) {

		if (idActividadRealizada > 0) {
			// obtener datos
			Actividad_Realizada ar = actividadRealizadaService.buscarActividad(idActividadRealizada);
			if (ar != null) {
				return ar;
			} else {
				return new Actividad_Realizada();
			}

		} else {
			return new Actividad_Realizada();
		}

	}

	@RequestMapping(value = "guardarDatosActividadRealizadaCosecha")
	public @ResponseBody boolean guardarDatosActividadRealizadaCosecha(
			@RequestParam(value = "datos[]") String[] datos) {

		if (datos.length > 0) {
			for (int i = 0; i < datos.length / 3; i++) {
				// Buscar Actividad
				Actividad_Realizada ar = actividadRealizadaService.buscarActividad(Integer.parseInt(datos[i]));
				if (ar != null) {
					// DateFormat dt=new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
					LocalDate date = LocalDate.parse(datos[i + 1], formatter);

					Date dateInicio = java.sql.Date.valueOf(date);

					ar.setFechaEjecucionReal(dateInicio);
					ar.setCantidadCosechada(Integer.parseInt(datos[i + 2]));

					// Guardar
					actividadRealizadaService.save(ar);
				}

				i += 3;
			}
			return true;

		}

		return false;
	}

	@RequestMapping(value = "guardarDatosActividadRealizada")
	public @ResponseBody boolean guardarDatosActividadRealizada(@RequestParam(value = "datos[]") String[] datos) {

		if (datos.length > 0) {
			for (int i = 0; i < datos.length / 2; i++) {
				// Buscar Actividad
				Actividad_Realizada ar = actividadRealizadaService.buscarActividad(Integer.parseInt(datos[i]));
				if (ar != null) {
					// DateFormat dt=new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy", Locale.ENGLISH);
					LocalDate date = LocalDate.parse(datos[i + 1], formatter);

					Date dateInicio = java.sql.Date.valueOf(date);

					ar.setFechaEjecucionReal(dateInicio);

					// Guardar
					actividadRealizadaService.save(ar);

				}

				i += 2;
			}
			return true;
		}

		return false;

	}

	@RequestMapping(value = "reprogramarActividades")
	public ModelAndView reprogramarActividades(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {
			// Get Sectores
			List<Sector> listaSectores = sectorService.listarSectores(false);
			vista.addObject("listaSectores", listaSectores);

			vista.setViewName("reprogramarActividades");

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}
}
