package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Actividad_Realizada;
import com.app.proyectotitulo.domain.Predio;
import com.app.proyectotitulo.repository.ActividadRealizadaRepository;

@Service
public class ActividadRealizadaServiceImplementation implements ActividadRealizadaService {

	private ActividadRealizadaRepository actividadRealizadaRepo;

	@Autowired
	public void setActividadRealizadaRepository(ActividadRealizadaRepository actividadRealizadaRepository) {
		actividadRealizadaRepo = actividadRealizadaRepository;
	}

	@Override
	public Actividad_Realizada saveAndFlush(Actividad_Realizada ar) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.saveAndFlush(ar);
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

	@Override
	public Actividad_Realizada editarActividad_Realizada(Actividad_Realizada a) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.save(a);
	}

	@Override
	public List<Actividad_Realizada> listaActividadesAsignadasAPredioEnTemporada(int idTemporada, int idPredio) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.actividadesAsignadasAPredioEnTemporada(idTemporada, idPredio);
	}
	
	@Override
	public List<Actividad_Realizada> totalActividadesRealizadas() {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.listaActividadesRealizadas();
	}

	@Override
	public List<Actividad_Realizada> actividadesReporteTemporada(int idTemporada) {
		// TODO Auto-generated method stub
		return actividadRealizadaRepo.actividadesReporteTemporada(idTemporada);
	}

}
