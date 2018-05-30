package com.app.proyectotitulo.controller;

import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
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
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Reprogramacion;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.domain.Temporada;
import com.app.proyectotitulo.service.ActividadRealizadaService;
import com.app.proyectotitulo.service.ReprogramacionService;
import com.app.proyectotitulo.service.SectorService;

@Controller
public class ReprogramacionController {

	@Autowired
	private SectorService sectorService;

	@Autowired
	private ReprogramacionService reprogramacionService;

	@Autowired
	private ActividadRealizadaService actividad_realizadaService;

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

	@RequestMapping(value = "guardarReprogramacionDeActividades")
	public @ResponseBody boolean reprogramarActividades(@RequestParam String motivo,

			@RequestParam(value = "fechasEstimadas[]") String[] fechasEstimadas,
			@RequestParam(value = "fechasRealesReprogramadas[]") String[] fechasRealesReprogramadas,
			@RequestParam(value = "Ids[]") String[] Ids) throws ParseException {

		if (!motivo.equalsIgnoreCase("") && fechasEstimadas.length > 0 && fechasRealesReprogramadas.length > 0
				&& Ids.length > 0) {

			for (int j = 0; j < fechasEstimadas.length; j++) {
				Reprogramacion r = new Reprogramacion();
				// DateFormat dt=new SimpleDateFormat("dd-MM-yyyy", Locale.ENGLISH);
				DateTimeFormatter forma = DateTimeFormatter.ofPattern("dd-MM-yyyy");
				LocalDate date = LocalDate.parse(fechasEstimadas[j], forma);
				Date fechaEstimada = java.sql.Date.valueOf(date);
                
				DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd", Locale.ENGLISH);
				LocalDate reprogramada = LocalDate.parse(fechasRealesReprogramadas[j], formatter);
				Date fechaReprogramacion = java.sql.Date.valueOf(reprogramada);

				Actividad_Realizada actividadRealizada = actividad_realizadaService
						.buscarActividad(Integer.parseInt(Ids[j]));

				r.setMotivo(motivo);
				r.setActividadRealizada(actividadRealizada);
				r.setFechaEstimadaAnterior(fechaEstimada);
				r.setFechaReprogramacion(fechaReprogramacion);

				// Guardar reprogramación
				reprogramacionService.save(r);
				
				Actividad_Realizada a = new Actividad_Realizada();
				a= actividad_realizadaService.buscarActividad(Integer.parseInt(Ids[j]));
				a.setFechaEstimada(fechaReprogramacion);
				
				//se actualiza la fecha editada en actividad realizada
				actividad_realizadaService.editarActividad_Realizada(a);

			}

		}

		return true;
	}

}
