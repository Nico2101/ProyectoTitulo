package com.app.proyectotitulo.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.domain.Insumo;
import com.app.proyectotitulo.service.InsumoService;

@Controller
public class InsumoController {

	@Autowired
	private InsumoService insumoService;

	@RequestMapping(value = "ListarInsumos")
	public ModelAndView listarInsumos(ModelAndView vista, HttpServletRequest request, HttpSession sesion) {

		sesion = request.getSession(true);
		Empleado e = (Empleado) sesion.getAttribute("empleado");

		if (e != null) {

			List<Insumo> listaInsumos = insumoService.listarTodosLosInsumos(false);
			vista.addObject("listaInsumos", listaInsumos);
			vista.setViewName("listarInsumos");

		} else {
			vista.setViewName("login");
			vista.addObject("empleado", new Empleado());
			vista.addObject("sesionExpirada", "Su sesión ha expirado");

		}
		return vista;
	}

	@RequestMapping(value = "agregarInsumo")
	public @ResponseBody Insumo agregarInsumo(@RequestParam String nombre, @RequestParam String tipo,
			@RequestParam String um, @RequestParam String marca) {

		System.out.println(nombre);
		System.out.println(tipo);
		System.out.println(um);
		System.out.println(marca);
		Insumo i = new Insumo();
		Insumo insumo = new Insumo();

		if (!nombre.equalsIgnoreCase("") && !tipo.equalsIgnoreCase("") && !um.equalsIgnoreCase("")) {
			i.setNombre(nombre);
			i.setTipo(tipo);
			i.setUnidadMedida(um);
			i.setMarca(marca);

			// Guardar
			insumo = insumoService.saveAndFlush(i);
			return insumo;

		}

		return insumo;

	}

	@RequestMapping(value = "obtenerListaInsumos")
	public @ResponseBody List<Insumo> obtenerListaInsumos() {

		List<Insumo> lista = insumoService.listarTodosLosInsumos(false);

		return lista;
	}

	@RequestMapping(value = "eliminarInsumo")
	public @ResponseBody boolean eliminarInsumo(@RequestParam int idInsumo) {

		Insumo i = insumoService.findByIdInsumo(idInsumo);
		if (i != null) {
			i.setInsumoEliminado(true);

			insumoService.eliminarInsumo(i);
			return true;
		}

		return false;
	}

	@RequestMapping(value = "obtenerInsumoAEditar")
	public @ResponseBody Insumo obtenerInsumoAEditar(@RequestParam int idInsumo) {

		Insumo i = insumoService.findByIdInsumo(idInsumo);
		if (i != null) {
			return i;
		} else {
			return new Insumo();
		}

	}

	@RequestMapping(value = "editarInsumo")
	public @ResponseBody boolean editar(@RequestParam int idInsumo, @RequestParam String nombre,
			@RequestParam String tipo, @RequestParam String um, @RequestParam String marca) {

		System.out.println(nombre);
		System.out.println(tipo);
		System.out.println(um);
		System.out.println(marca);

		Insumo i = new Insumo();

		if (!nombre.equalsIgnoreCase("") && !tipo.equalsIgnoreCase("") && !um.equalsIgnoreCase("") && idInsumo > 0) {

			// Buscar el insumo
			i = insumoService.findByIdInsumo(idInsumo);
			i.setNombre(nombre);
			i.setTipo(tipo);
			i.setUnidadMedida(um);
			i.setMarca(marca);

			// Guardar
			insumoService.editarInsumo(i);
			return true;

		}

		return false;

	}

}
