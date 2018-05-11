package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Plan_Ejecucion;

public interface PlanEjecucionService {

	Plan_Ejecucion saveAndFlush(Plan_Ejecucion p);

	List<Plan_Ejecucion> listaPlanes(boolean planEliminado);

}
