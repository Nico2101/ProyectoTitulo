package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Actividad_Insumo;
import com.app.proyectotitulo.repository.ActividadInsumoRepository;

@Service
public class ActividadInsumoServiceImplementation implements ActividadInsumoService {

	private ActividadInsumoRepository actividadInsumoRepo;

	@Autowired
	public void setActividadInsumoRepository(ActividadInsumoRepository actividadInsumoRepository) {
		actividadInsumoRepo = actividadInsumoRepository;
	}

	@Override
	public void save(Actividad_Insumo ai) {
		// TODO Auto-generated method stub
		actividadInsumoRepo.save(ai);
	}

	@Override
	public List<Actividad_Insumo> listaInsumosActividadRealizada(int idActividadRealizada) {
		// TODO Auto-generated method stub
		return actividadInsumoRepo.findByActividadRealizadaIdActividadRealizada(idActividadRealizada);
	}

	@Override
	public void delete(Actividad_Insumo ai) {
		// TODO Auto-generated method stub
		actividadInsumoRepo.delete(ai);
	}

	@Override
	public Actividad_Insumo buscarActividadInsumo(int idActividadInsumo) {
		// TODO Auto-generated method stub
		return actividadInsumoRepo.findByIdActividadInsumo(idActividadInsumo);
	}
	
	@Override
	public List<Actividad_Insumo> obtenerCostosTotales(int idPredio) {
		// TODO Auto-generated method stub
		return actividadInsumoRepo.obtenerCostos(idPredio);
	}

}
