package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.repository.ActividadRealizadaRepository;

@Service
public class ActividadRealizadaServiceImplementation implements ActividadRealizadaService {

	private ActividadRealizadaRepository actividadRealizadaRepo;

	@Autowired
	public void setActividadRealizadaRepository(ActividadRealizadaRepository actividadRealizadaRepository) {
		actividadRealizadaRepo = actividadRealizadaRepository;
	}

	@Override
	public List<Actividad_Realizada> listaActividadesAsignadasAPredio(int idPredio) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.listaActividadesAsiganadasAlPredio(idPredio);
	}

	@Override
	public Actividad_Realizada buscarActividad(int idActividadRealizada) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.findByIdActividadRealizada(idActividadRealizada);
	}

	@Override
	public void save(Actividad_Realizada ar) {
		// TODO Auto-generated method stub
		actividadRealizadaRepo.save(ar);
	}

}
