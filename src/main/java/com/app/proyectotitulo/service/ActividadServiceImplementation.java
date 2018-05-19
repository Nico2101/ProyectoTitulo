package com.app.proyectotitulo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.app.proyectotitulo.domain.Actividad;
import com.app.proyectotitulo.repository.ActividadRepository;

@Service
public class ActividadServiceImplementation implements ActividadService {

	private ActividadRepository actividadRepo;

	@Autowired
	public void setActividadRepository(ActividadRepository actividadRepository) {
		actividadRepo = actividadRepository;
	}

	@Override
	public void save(Actividad a) {
		// TODO Auto-generated method stub
		actividadRepo.save(a);
	}

	@Override
	public List<Actividad> listaActividadesPlan(int idPlan, boolean actividadEliminada) {
		// TODO Auto-generated method stub
		return actividadRepo.findByPlanEjecucionIdPlanEjecucionAndActividadEliminada(idPlan, actividadEliminada);
	}

	@Override
	public Actividad findByIdActividad(int idActividad) {
		// TODO Auto-generated method stub
		return actividadRepo.findByIdActividad(idActividad);
	}
}
