package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.domain.Sector;
import com.app.proyectotitulo.repository.PredioRepository;

@Service
public class PredioServiceImplementation implements PredioService {

	private PredioRepository predioRepo;

	@Autowired
	public void setPredioRepository(PredioRepository predioRepository) {
		predioRepo = predioRepository;
	}

	@Override
	public List<Predio> listarTodosLosPredios(boolean predioEliminado, boolean sectorEliminado) {
		// TODO Auto-generated method stub
		return predioRepo.findByPredioEliminadoAndSectorSectorEliminadoOrderByNombreAsc(predioEliminado,
				sectorEliminado);
	}

	@Override
	public Predio saveAndFlush(Predio p) {
		// TODO Auto-generated method stub
		return predioRepo.saveAndFlush(p);

	}

	@Override
	public Integer TotalSuperficiePredios(int id_sector) {
		// TODO Auto-generated method stub
		return predioRepo.superficieTotal(id_sector);
	}

	@Override
	public Predio eliminarPredio(Predio p) {
		// TODO Auto-generated method stub
		return predioRepo.save(p);
	}

	@Override
	public Predio findByIdPredio(int idPredio) {
		// TODO Auto-generated method stub
		return predioRepo.findByIdPredio(idPredio);
	}

	@Override
	public Predio editarPredio(Predio p) {
		// TODO Auto-generated method stub
		return predioRepo.save(p);
	}

	@Override
	public List<Predio> listarPrediosDeUnSector(int idSector) {
		// TODO Auto-generated method stub
		return predioRepo.prediosDeUnSector(idSector);
	}

	@Override
	public List<Predio> getListaPrediosConPlanesAsignados(int idSector) {
		// TODO Auto-generated method stub
		return predioRepo.listaPrediosConPlanesAsignados(idSector);
	}

	@Override
	public void save(Predio p) {
		// TODO Auto-generated method stub
		predioRepo.save(p);
	}

	@Override
	public List<Predio> obtenerEstadoPredios(int idSector) {
		// TODO Auto-generated method stub
		return predioRepo.obtenerEstadoPredios(idSector);
	}

	@Override
	public List<Predio> listaPrediosConPlanesAsigandosParaComparacion(int idTemporada, int idSector) {
		// TODO Auto-generated method stub
		return predioRepo.listaPrediosConPlanesAsigandosParaComparacion(idTemporada, idSector);
	}

	@Override
	public Integer totalPredios() {
		// TODO Auto-generated method stub
		return predioRepo.totalPredios();
	}

	@Override
	public Integer totalPrediosEnProceso() {
		// TODO Auto-generated method stub
		return predioRepo.totalPrediosEnProceso();
	}

	@Override
	public Integer totalPrediosCosechados() {
		// TODO Auto-generated method stub
		return predioRepo.totalPrediosCosechados();
	}

	@Override
	public Integer totalPrediosSinPlanAsignado() {
		// TODO Auto-generated method stub
		return predioRepo.totalPrediosSinPlanAsignado();
	}

	@Override
	public List<Predio> getPrediosParaCostos(int id_temporada, int id_sector) {
		// TODO Auto-generated method stub
		return predioRepo.listaDePrediosParaCostos(id_temporada, id_sector);
	}
	
	@Override
	public Predio findByNombre(String nombre) {
		// TODO Auto-generated method stub
		return predioRepo.findByNombre(nombre);
	}

}
