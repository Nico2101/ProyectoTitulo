package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.repository.PredioRepository;

@Service
public class PredioServiceImplementation implements PredioService {

	private PredioRepository predioRepo;

	@Autowired
	public void setPredioRepository(PredioRepository predioRepository) {
		predioRepo = predioRepository;
	}

	@Override
	public List<Predio> listarTodosLosPredios(boolean predioEliminado) {
		// TODO Auto-generated method stub
		return predioRepo.findByPredioEliminado(predioEliminado);
	}
	
	@Override
	public Predio saveAndFlush(Predio p) {
		// TODO Auto-generated method stub
		return predioRepo.saveAndFlush(p);
	
   
	}
	
	@Override
	public Integer  TotalSuperficiePredios(int id_sector) {
		// TODO Auto-generated method stub
		return predioRepo.superficieTotal( id_sector);
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

}
