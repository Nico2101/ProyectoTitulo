package com.app.proyectotitulo.controller;

import java.sql.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Temporada;
import com.app.proyectotitulo.service.TemporadaService;

@Controller
public class TemporadaController {

	@Autowired
	private TemporadaService temporadaService;

	@RequestMapping(value = "ListaTemporadas")
	public ModelAndView listarTemporadas(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {
			List<Temporada> listaTemporadas = temporadaService.listaTemporadas(false);

			vista.addObject("listaTemporadas", listaTemporadas);
			vista.setViewName("listarTemporadas");

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");
		}

		return vista;

	}

	@RequestMapping(value = "agregarTemporada")
	public @ResponseBody Temporada agregarInsumo(@RequestParam String nombreTemporada, @RequestParam Date fechaInicio,
			@RequestParam Date fechaTermino) {

		System.out.println(nombreTemporada);
		System.out.println(fechaInicio);
		System.out.println(fechaTermino);

		if (!nombreTemporada.equalsIgnoreCase("") && fechaInicio != null && fechaTermino != null) {
			// Guardar la temporada
			Temporada t = new Temporada();
			t.setEstado(true);
			t.setFechaInicio(fechaInicio);
			t.setFechaTermino(fechaTermino);
			t.setNombre(nombreTemporada);

			Temporada temporada = temporadaService.saveTemporada(t);

			return temporada;
		} else {
			return new Temporada();
		}

	}

	@RequestMapping(value = "obtenerTemporadaAEditar")
	public @ResponseBody Temporada obtenerTemporadaAEditar(@RequestParam int idTemporada) {

		if (idTemporada > 0) {
			// Buscar temporada
			Temporada t = temporadaService.buscarTemporada(idTemporada);
			if (t != null) {
				return t;
			}
		}

		return new Temporada();

	}

	@RequestMapping(value = "editarTemporada")
	public @ResponseBody boolean editarTemporada(@RequestParam int idTemporada, @RequestParam String nombreTemporada,
			@RequestParam Date fechaInicio, @RequestParam Date fechaTermino) {

		if (idTemporada > 0 && !nombreTemporada.equalsIgnoreCase("") && fechaInicio != null && fechaTermino != null) {

			// Buscar la temporada
			Temporada t = temporadaService.buscarTemporada(idTemporada);
			if (t != null) {
				// Actualizar temporada
				t.setFechaInicio(fechaInicio);
				t.setFechaTermino(fechaTermino);
				t.setNombre(nombreTemporada);

				temporadaService.saveTemporada(t);

				return true;
			}
		}

		return false;

	}

	@RequestMapping(value = "obtenerListaTemporadas")
	public @ResponseBody List<Temporada> obtenerListaTemporadas() {

		List<Temporada> lista = temporadaService.listaTemporadas(false);

		return lista;

	}

	@RequestMapping(value = "eliminarTemporada")
	public @ResponseBody boolean eliminarTemporada(@RequestParam int idTemporada) {

		// Buscar temporada
		Temporada t = temporadaService.buscarTemporada(idTemporada);

		if (t != null) {

			// Eliminar la temporada
			t.setTemporadaEliminada(true);

			temporadaService.saveTemporada(t);

			return true;
		}

		return false;
	}

	@RequestMapping(value = "finalizarTemporada")
	public @ResponseBody boolean finalizarTemporada(@RequestParam int idTemporada) {

		// Buscar temporada
		Temporada t = temporadaService.buscarTemporada(idTemporada);

		if (t != null) {

			// Eliminar la temporada
			t.setEstado(false);

			temporadaService.saveTemporada(t);

			return true;
		}

		return false;
	}

}
