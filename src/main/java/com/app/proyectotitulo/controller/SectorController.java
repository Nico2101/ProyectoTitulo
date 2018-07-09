package com.app.proyectotitulo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.service.SectorService;

@Controller
public class SectorController {

	@Autowired
	private SectorService sectorService;

	@RequestMapping(value = "listaSectores")
	public ModelAndView listarInsumos(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			if (e.getCargo().equalsIgnoreCase("Administrador")) {

				List<Sector> sectores = sectorService.listarSectores(false);
				vista.addObject("sectores", sectores);
				vista.setViewName("listarSectores");

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

	@RequestMapping(value = "agregarSector")
	public @ResponseBody Sector agregarSector(@RequestParam String nombre, @RequestParam int superficie) {

		System.out.println(nombre);
		System.out.println(superficie);
		Sector s = new Sector();
		Sector sector = new Sector();

		if (!nombre.equalsIgnoreCase("") && !(superficie == (0))) {
			s.setNombre(nombre);
			s.setSuperficie(superficie);
			// Guardar
			sector = sectorService.saveAndFlush(s);
			return sector;

		}

		return sector;

	}

	@RequestMapping(value = "obtenerListaSectores")
	public @ResponseBody List<Sector> obtenerListaSectores() {

		List<Sector> lista = sectorService.listarSectores(false);

		return lista;
	}

	@RequestMapping(value = "eliminarSector")
	public @ResponseBody boolean eliminarSector(@RequestParam int idSector) {

		Sector s = sectorService.findByIdSector(idSector);
		if (s != null) {
			s.setSectorEliminado(true);

			sectorService.eliminarSector(s);
			return true;
		}

		return false;
	}

	@RequestMapping(value = "obtenerSectorAEditar")
	public @ResponseBody Sector obtenerSectorAEditar(@RequestParam int idSector) {

		Sector s = sectorService.findByIdSector(idSector);
		if (s != null) {
			return s;
		} else {
			return new Sector();
		}

	}

	@RequestMapping(value = "editarSector")
	public @ResponseBody boolean editar(@RequestParam int idSector, @RequestParam String nombre,
			@RequestParam int superficie) {

		System.out.println(nombre);
		System.out.println(superficie);

		Sector s = new Sector();

		if (!nombre.equalsIgnoreCase("") && !(superficie == (0)) && idSector > 0) {

			// Buscar el sector
			s = sectorService.findByIdSector(idSector);
			s.setNombre(nombre);
			s.setSuperficie(superficie);

			// Guardar
			sectorService.editarSector(s);
			return true;

		}

		return false;

	}

	@RequestMapping(value = "obtenerTotalSuperficeSector")
	public @ResponseBody Integer obtieneTotalSuperficieSector(@RequestParam int idSector) {

		Integer TotalSuperficieSector = sectorService.TotalSuperficieSector(idSector);
		return TotalSuperficieSector;

	}

	@RequestMapping(value = "getSectoresConPrediosConPlanes")
	public @ResponseBody List<Sector> getSectoresConPrediosConPlanes(@RequestParam int idTemporada) {

		List<Sector> lista = sectorService.listaSectoresConPrediosConPlanes(idTemporada);
		return lista;

	}

}
