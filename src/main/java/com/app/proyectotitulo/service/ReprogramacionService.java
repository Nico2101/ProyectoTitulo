package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Reprogramacion;

public interface ReprogramacionService {

	Reprogramacion save(Reprogramacion r);

	List<Reprogramacion> getListaReprogramacionActividad(int idActividadRealizada);

}
