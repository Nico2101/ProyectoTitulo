package com.app.proyectotitulo.controller;

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

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.service.PredioService;
import com.app.proyectotitulo.service.SectorService;

@Controller
public class PredioController {

	@Autowired
	private PredioService PredioService;

	@Autowired
	private SectorService sectorService;

	@RequestMapping(value = "ListarPredios")
	public ModelAndView listarPredios(ModelAndView vista, @Valid @ModelAttribute("predio") Predio predio,
			HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			List<Predio> listaPredios = PredioService.listarTodosLosPredios(false);
			List<Sector> sectores = sectorService.listarSectores(false);
			vista.addObject("listaPredios", listaPredios);
			vista.addObject("sectores", sectores);
			vista.setViewName("listarPredios");

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
			predio = PredioService.saveAndFlush(p);
			return predio;

		}

		return predio;

	}

	@RequestMapping(value = "obtenerTotalSuperficePrediosSector")
	public @ResponseBody Integer obtenerTotalSuperficie(@RequestParam int idSector) {

		Integer TotalSuperficieAcomulado = PredioService.TotalSuperficiePredios(idSector);
		if (TotalSuperficieAcomulado != null) {
			return TotalSuperficieAcomulado;
		} else {
			return 0;
		}

	}

	@RequestMapping(value = "obtenerListaPredios")
	public @ResponseBody List<Predio> obtenerListaPredios() {

		List<Predio> lista = PredioService.listarTodosLosPredios(false);

		return lista;
	}

	@RequestMapping(value = "eliminarPredio")
	public @ResponseBody boolean eliminarPredio(@RequestParam int idPredio) {

		Predio p = PredioService.findByIdPredio(idPredio);
		if (p != null) {
			p.setPredioEliminado(true);

			PredioService.eliminarPredio(p);
			return true;
		}

		return false;
	}

	
	//cuando se elimnina un sector permite eliminar los predios asociados a el 
	@RequestMapping(value = "eliminarPrediosDeUnSector")
	public @ResponseBody boolean eliminarPrediosDeUnSector(@RequestParam int idSector) {
           
		
		if (PredioService.eliminarPrediosSector(idSector)==true) {
			return true;
		}else {
			return false;
			
		}
	}
	
	@RequestMapping(value = "obtenerPredioAEditar")
	public @ResponseBody Predio obtenerPredioAEditar(@RequestParam int idPredio) {

		Predio p = PredioService.findByIdPredio(idPredio);
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
			p = PredioService.findByIdPredio(idPredio);
			p.setNombre(nombre);
			p.setSuperficie(superficie);
			p.setSector(sector);

			// Guardar el predio editado
			PredioService.editarPredio(p);
			return true;

		}

		return false;

	}
}
