package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Actividad;

public interface ActividadService {

	public void save(Actividad a);

	List<Actividad> listaActividadesPlan(int idPlan, boolean actividadEliminada);

	Actividad findByIdActividad(int idActividad);

}
