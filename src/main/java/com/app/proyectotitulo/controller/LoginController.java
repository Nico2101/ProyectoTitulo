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
import org.springframework.web.servlet.ModelAndView;

import com.app.proyectotitulo.domain.Empleado;
import com.app.proyectotitulo.service.EmpleadoService;

@Controller
public class LoginController {

	@Autowired
	private EmpleadoService empleadoService;

	@RequestMapping(value = "inicio")
	public ModelAndView login(ModelAndView vista, @Valid @ModelAttribute("empleado") Empleado empleado,
			BindingResult result, HttpServletRequest request, HttpSession sesion) {

		if (result.hasErrors()) {
			vista.setViewName("login");
		}

		if (!result.hasErrors()) {
			if (!validarRut(empleado.getRut())) {
				result.rejectValue("rut", "messageCode", "El Rut ingresado es inválido");
				vista.setViewName("login");
			}
			if (empleado.getClave().length() != 8) {
				result.rejectValue("clave", "messageCode", "Recuerde que la contraseña tiene 8 carácteres");
				vista.setViewName("login");
			}

			if (validarRut(empleado.getRut()) && empleado.getClave().length() == 8) {
				Empleado e = empleadoService.buscarEmpleado(empleado.getRut(), empleado.getClave());

				if (e != null) {

					// Guardar los datos del usuario en sesion
					sesion = request.getSession(true);
					sesion.setAttribute("empleado", e);
					vista.addObject("empleado", e);

					vista.setViewName("inicio");
				} else {
					// el usuario no existe o hay error
					vista.setViewName("login");
					vista.addObject("errorUsuario", "Usuario o Contraseña incorrectos");
					System.out.println("Usuario no esta en la bbdd");
				}
			}

		}

		return vista;
	}

	public static boolean validarRut(String rut) {

		boolean validacion = false;
		try {
			rut = rut.toUpperCase();
			rut = rut.replace(".", "");
			rut = rut.replace("-", "");
			int rutAux = Integer.parseInt(rut.substring(0, rut.length() - 1));

			char dv = rut.charAt(rut.length() - 1);

			int m = 0, s = 1;
			for (; rutAux != 0; rutAux /= 10) {
				s = (s + rutAux % 10 * (9 - m++ % 6)) % 11;
			}
			if (dv == (char) (s != 0 ? s + 47 : 75)) {
				validacion = true;
			}

		} catch (java.lang.NumberFormatException e) {
		} catch (Exception e) {
		}
		return validacion;
	}

	@RequestMapping(value = "logout")
	public ModelAndView cerrarSesion(ModelAndView vista, HttpSession sesion, HttpServletRequest request) {
		sesion = request.getSession(true);
		sesion.removeAttribute("empleado");
		sesion.invalidate();
		vista.setViewName("inicioPagina");
		return vista;
	}

}