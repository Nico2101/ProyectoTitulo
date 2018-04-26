package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Insumo;

public interface InsumoService {

	List<Insumo> listarTodosLosInsumos(boolean insumoEliminado);

	public void save(Insumo i);

}
