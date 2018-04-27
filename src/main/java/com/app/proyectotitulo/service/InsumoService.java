package com.app.proyectotitulo.service;

import java.util.List;

import com.app.proyectotitulo.domain.Insumo;

public interface InsumoService {

	List<Insumo> listarTodosLosInsumos(boolean insumoEliminado);

	Insumo saveAndFlush(Insumo i);

	Insumo findByIdInsumo(int idInsumo);

	// Eliminar insumo
	Insumo eliminarInsumo(Insumo i);

	// Editar insumo
	Insumo editarInsumo(Insumo i);

}
