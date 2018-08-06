package com.app.proyectotitulo.service;

import java.util.List;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;

public interface PredioService {

	List<Predio> listarTodosLosPredios(boolean predioEliminado, boolean sectorEliminado);

	// agregar predio
	Predio saveAndFlush(Predio p);

	Integer TotalSuperficiePredios(int id_sector);

	Predio findByIdPredio(int idPredio);

	// Eliminar predio
	Predio eliminarPredio(Predio p);

	// Editar Predio
	Predio editarPredio(Predio p);

	List<Predio> listarPrediosDeUnSector(int idSector);

	public void save(Predio p);

	// Predios que tienen planes asignados
	List<Predio> getListaPrediosConPlanesAsignados(int idSector);

	List<Predio> obtenerEstadoPredios(int idSector);

	List<Predio> listaPrediosConPlanesAsigandosParaComparacion(int idTemporada, int idSector);

	Integer totalPredios();

	Integer totalPrediosEnProceso();

	Integer totalPrediosCosechados();

	Integer totalPrediosSinPlanAsignado();

	List<Predio> getPrediosParaCostos(int id_temporada, int id_sector);

	List<Predio> findByNombre(String nombre);

}
