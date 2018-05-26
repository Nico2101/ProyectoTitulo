package com.app.proyectotitulo.service;

import java.util.List;
import com.app.proyectotitulo.domain.Predio;

public interface PredioService {

	List<Predio> listarTodosLosPredios(boolean predioEliminado);

	// agregar predio
	Predio saveAndFlush(Predio p);

	Integer TotalSuperficiePredios(int id_sector);

	Predio findByIdPredio(int idPredio);

	// Eliminar predio
	Predio eliminarPredio(Predio p);

	// Editar Predio
	Predio editarPredio(Predio p);

	// Predios que tienen planes asignados
	List<Predio> getListaPrediosConPlanesAsignados(int idSector);

}
