package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Temporada;

public interface TemporadaService {

	List<Temporada> listaTemporadas(boolean temporadaEliminada);

	Temporada saveTemporada(Temporada t);

	Temporada buscarTemporada(int idTemporada);
	
	Integer totalTemporadasActivas();
	
	
	List<Temporada> listarTemporadasActivas();
}
